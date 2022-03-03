import 'package:authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/utils/utils.dart';
import 'package:user_repository/user_repository.dart';

import 'package:paylinc/shared_components/models/user_statistics.dart';

class AuthController extends GetxController {
  AuthController({
    required this.authenticationRepository,
  });

  final AuthenticationRepository authenticationRepository;
  final _authenticated = false.obs;
  final _token = "".obs;
  final _user = User().obs;
  final _userStatistics = UserStatistics().obs;
  var selectedWallet = Wallet().obs;
  bool get authenticated => _authenticated.value;

  var enableAppLock = false.obs;
  var enableBiometric = false.obs;

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

    super.onInit();
  }

  void logout() async {
    _authenticated.value = false;
    _token.value = "";
    await Hive.deleteFromDisk();
    authenticationRepository.onboardingReqLogin();
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
  }

  void toggleBiometricSettings() async {
    enableBiometric.value = !enableBiometric.value;

    bool biomtcEnbld = await LocalAuthApi.hasBiometrics();
    if (enableBiometric.value && biomtcEnbld) {
      print("biomtcEnbld: $biomtcEnbld");
    }
  }
}
