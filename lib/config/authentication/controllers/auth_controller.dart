import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/shared_components.dart';
import 'package:paylinc/utils/utils.dart';
import 'package:user_repository/user_repository.dart';

class AuthController extends GetxController {
  AuthController({
    required this.authenticationRepository,
  });

  //

  final AuthenticationRepository authenticationRepository;
  RxBool authenticated = false.obs;
  var appLocked = false.obs;
  var token = "".obs;
  Rx<User> user = User().obs;
  var userStatistics = UserStatistics().obs;
  var selectedWallet = Wallet().obs;
  bool get isAuthenticated => authenticated.value;

  var appBanks = AppBanks().obs;
  var enableAppLock = false.obs;
  var bankTransferCharge = 0.obs;
  var enableBiometric = false.obs;
  var lockedAtRoute = Routes.dashboard;
  var requestPushNotifPermission = false;
  var oneSignalInitialized = false;
  var oneSignalUserId = "";

  bool get isAppLocked => appLocked.value;

  set isAuthenticated(bool value) => authenticated.value = value;

  LocalStorageServices localStorageServices = Get.put(LocalStorageServices());

  @override
  void onInit() async {
    super.onInit();
    var curAuthSt = currentAuthenticationState();

    token.value = await localStorageServices.getToken();
    isAuthenticated = token.value.isNotEmpty &&
        curAuthSt == AuthenticationStatus.authenticated;
    var userClass = await localStorageServices.getUser();
    user.value = userClass;
    var userStatisticsClass = await localStorageServices.getUserStatistics();
    userStatistics.value = userStatisticsClass;
    enableAppLock.value = await localStorageServices.getApplockSettings();
    enableBiometric.value = await localStorageServices.getBiometricSettings();
  }

  void logout() async {
    authenticated.value = false;
    token.value = "";
    // backup the app lock and biometric settings if they exist
    await clearStorage();
    authenticationRepository.onboardingReqLogin();
  }

  Future<void> clearStorage() async {
    var aplkBiomtr = await getApplckBiomtrc();
    await Hive.deleteFromDisk();
    localStorageServices
        .saveBiometricSettings(aplkBiomtr['biometricsEnabled']!);
    localStorageServices.saveApplockSettings(aplkBiomtr['applockEnabled']!);
  }

  Future<Map<String, bool>> getApplckBiomtrc() async {
    bool applockBmtrcStngsBx =
        await Hive.boxExists("applock_biometric_settings");
    bool applockEnabled = false;
    bool biometricsEnabled = false;
    // biometrics_enabled
    if (applockBmtrcStngsBx) {
      applockEnabled = await localStorageServices.getApplockSettings();
      biometricsEnabled = await localStorageServices.getBiometricSettings();
    }
    return {
      'applockEnabled': applockEnabled,
      'biometricsEnabled': biometricsEnabled,
    };
  }

  void updateUserWallets(List<Wallet> wallets) {
    User _user = user.value;
    _user.wallets = wallets;
    user.value = _user;
    localStorageServices.saveUserFromMap(_user.toMap());
  }

  void fetUserFromToken() async {
    try {
      var api = UserApi.withAuthRepository(authenticationRepository);
      ResponseModel res = await api.authUser({
        'token': token.value,
      });

      if (res.status == true) {
        User _user =
            await localStorageServices.saveUserFromMap(res.data?['user']);
        localStorageServices.saveUserStatisticsFromMap(res.data?['statistics']);
        user.value = _user;
        userStatistics.value = await localStorageServices.getUserStatistics();
      }
    } on Exception catch (_) {}
  }

  void toggleAppLockSettings() {
    enableAppLock.value = !enableAppLock.value;
    localStorageServices.saveApplockSettings(enableAppLock.value);
  }

  void toggleBiometricSettings() async {
    enableBiometric.value = !enableBiometric.value;
    bool hasBiomtrk = await LocalAuthApi.hasBiometrics();
    if (hasBiomtrk) {
      localStorageServices.saveBiometricSettings(enableBiometric.value);
    } else {
      Snackbar.errSnackBar("Device Info", "no biometrics found");
    }
  }

  void appInactive(List<AppLifecycleState> stateArr) async {
    AuthenticationStatus currentState =
        await authenticationRepository.currentAuthenticationState();

    // if any of the last two indexes of stateArr is either AppLifecycleState.paused or AppLifecycleState.inactive and not AppLifecycleState.resumed return false
    if (!((stateArr.isNotEmpty &&
            (stateArr[stateArr.length - 1] == AppLifecycleState.paused ||
                stateArr[stateArr.length - 1] == AppLifecycleState.inactive) &&
            stateArr[stateArr.length - 1] != AppLifecycleState.resumed) &&
        (stateArr.length > 1 &&
            (stateArr[stateArr.length - 2] == AppLifecycleState.paused ||
                stateArr[stateArr.length - 2] == AppLifecycleState.inactive) &&
            stateArr[stateArr.length - 2] != AppLifecycleState.resumed))) {
      if (currentState == AuthenticationStatus.authenticated) {
        // save the current time of entering inactivity while in authenticated state
        localStorageServices.saveAppInactiveAt();
      }
    }
  }

// checks if the app was in the background while authenticated for more than `lockAppIn` secs and changes the auth state to "lock app"
  void appResumed(List<AppLifecycleState> stateArr) async {
    try {
      if (!enableAppLock.value) {
        return;
      }
      // get the time app entered inactivity while in authenticated state
      var inactiveAt = await localStorageServices.getAppInactiveAt();

      if (inactiveAt != null) {
        int timeToLock = inactiveAt + lockAppIn;
        var now = DateTime.now().millisecondsSinceEpoch;

        if (now >= timeToLock) {
          // if the app was in the background for more than "lockAppIn" secs
          // lock app screen (i.e set appLocked to true and reload the page to trigger lock middleware check)
          appLocked.value = true;
          lockedAtRoute = Get.currentRoute;
          Get.offAllNamed(Get.currentRoute);
        }
      }
    } catch (_) {}
  }

  Future<void> unlock() async {
    if (enableBiometric.isTrue) {
      var localAuth = LocalAuthentication();
      bool didBioAuthntct = await localAuth.authenticate(
          localizedReason: 'Please authenticate to gain access',
          biometricOnly: true);
      // print("didBioAuthntct: $didBioAuthntct");
      if (didBioAuthntct) {
        await innerUnlock();
      }
    } else {
      await innerUnlock();
    }
  }

  Future<void> innerUnlock() async {
    appLocked.value = false;
    Get.offAllNamed(lockedAtRoute);
  }

  currentAuthenticationState() async {
    return await authenticationRepository.currentAuthenticationState();
  }

  Future<void> initOnesignal() async {
    if (requestPushNotifPermission == false) {
      requestPushNotifPermission = true;
      await OneSignal.shared.setAppId("");

      // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt.
      var accepted = await OneSignal.shared
          .promptUserForPushNotificationPermission(fallbackToSettings: true);
      print("Accepted permission: $accepted");
    }

    if (oneSignalInitialized == false && requestPushNotifPermission) {
      oneSignalInitialized = true;

      /// Get the Onesignal userId and update that into the firebase.
      /// So, that it can be used to send Notifications to users later.̥
      final status = await OneSignal.shared.getDeviceState();
      oneSignalUserId = status?.userId ?? '';
      print("oneSignalUserId : $oneSignalUserId");

      OneSignal.shared.setNotificationWillShowInForegroundHandler(
          (OSNotificationReceivedEvent event) {
        // Will be called whenever a notification is received in foreground
        // Display Notification, pass null param for not displaying the notification
        event.complete(event.notification);
      });
    }
  }
}
