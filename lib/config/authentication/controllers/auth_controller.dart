import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
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
    _token.value = await localStorageServices.getToken();
    authenticated = _token.value.isNotEmpty;
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
    print("current `stateArr` called in appInactive : $stateArr");
    // don't take any action if last index of stateArr isn't  AppLifecycleState.resumed
    // if (stateArr.length > 1 && stateArr.last != AppLifecycleState.resumed) {
    //   return;
    // }
    print('call pre-app lock logic');
    AuthenticationStatus currentState =
        await authenticationRepository.currentAuthenticationState();

    if (currentState == AuthenticationStatus.authenticated) {
      print("reset inactiveAt");
      // save the current time of entering inactivity while in authenticated state
      localStorageServices.saveAppInactiveAt();
    }
  }

// checks if the app was in the background for more than `lockAppIn` secs and changes the state to lock app
// Auth state if true
  void appResumed(List<AppLifecycleState> stateArr) async {
    // don't take any action if last index of stateArr isn't  AppLifecycleState.inactive or AppLifecycleState.paused
    // if (stateArr.length > 1) {
    //   if (stateArr[stateArr.length - 1] != AppLifecycleState.inactive ||
    //       stateArr[stateArr.length - 1] != AppLifecycleState.paused) {
    //     return;
    //   }
    // }

    print('executing app lock logic');

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
          print(' app locked');
        }
      }
    } catch (_) {}
  }

  void unlock() {
    //TODO: unlock the app
  }
}
