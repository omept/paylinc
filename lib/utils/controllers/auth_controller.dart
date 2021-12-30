import 'package:authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';
import 'package:user_repository/user_repository.dart';

import 'package:paylinc/shared_components/models/user_statistics.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';

class AuthController extends GetxController {
  final AuthenticationRepository authenticationRepository;
  AuthController({
    required this.authenticationRepository,
  });
  final _authenticated = false.obs;
  final _token = "".obs;
  final _user = User().obs;
  final _userStatistics = UserStatistics().obs;

  bool get authenticated => _authenticated.value;
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

  void logout() {
    Hive.deleteBoxFromDisk('auth_token');
    Hive.deleteBoxFromDisk('auth_user');
    _authenticated.value = false;
    _token.value = "";
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
}
