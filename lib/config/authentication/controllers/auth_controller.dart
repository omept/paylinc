import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
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
  final _authenticated = false.obs;
  final _appLocked = false.obs;
  final _token = "".obs;
  final _user = User().obs;
  final _userStatistics = UserStatistics().obs;
  var selectedWallet = Wallet().obs;
  bool get authenticated => _authenticated.value;

  var enableAppLock = false.obs;
  var enableBiometric = false.obs;

  bool get appLocked => _appLocked.value;

  set authenticated(bool value) => _authenticated.value = value;
  String get token => _token.value;
  set token(String value) => _token.value = value;
  User get user => _user.value;
  set user(User value) => _user.value = value;
  UserStatistics get userStatistics => _userStatistics.value;
  set userStatistics(value) => _userStatistics.value = value;

  LocalStorageServices localStorageServices = Get.put(LocalStorageServices());

  @override
  void onInit() async {
    // currentAuthenticationState
    var curAuthSt = currentAuthenticationState();

    _token.value = await localStorageServices.getToken();
    authenticated = _token.value.isNotEmpty &&
        curAuthSt == AuthenticationStatus.authenticated;
    var userClass = await localStorageServices.getUser();
    _user(userClass);
    var userStatisticsClass = await localStorageServices.getUserStatistics();
    _userStatistics(userStatisticsClass);
    enableAppLock.value = await localStorageServices.getApplockSettings();
    enableBiometric.value = await localStorageServices.getBiometricSettings();
    super.onInit();
  }

  void logout() async {
    _authenticated.value = false;
    _token.value = "";
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
    User user = _user.value;
    user.wallets = wallets;
    _user(user);
    localStorageServices.saveUserFromMap(user.toMap());
  }

  void fetUserFromToken() async {
    try {
      var api = UserApi.withAuthRepository(authenticationRepository);
      ResponseModel res = await api.authUser({
        'token': _token.value,
      });

      if (res.status == true) {
        User _user =
            await localStorageServices.saveUserFromMap(res.data?['user']);
        localStorageServices.saveUserStatisticsFromMap(res.data?['statistics']);
        user = _user;
        userStatistics = await localStorageServices.getUserStatistics();
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
      // get the time app entered inactivity while in authenticated state
      var inactiveAt = await localStorageServices.getAppInactiveAt();

      if (inactiveAt != null) {
        int timeToLock = inactiveAt + lockAppIn;
        var now = DateTime.now().millisecondsSinceEpoch;

        if (now >= timeToLock) {
          // if the app was in the background for more than "lockAppIn" secs
          // change the state to lock screen
          _appLocked.value = true;
          authenticationRepository.lockApp();
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
    _appLocked.value = false;
    authenticationRepository.setUnlocked();
  }

  currentAuthenticationState() async {
    return await authenticationRepository.currentAuthenticationState();
  }
}
