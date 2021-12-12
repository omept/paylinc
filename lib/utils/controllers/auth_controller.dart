import 'package:get/get.dart';
import 'package:paylinc/shared_components/models/user_statistics.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';
import 'package:user_repository/user_repository.dart';

class AuthController extends GetxController {
  final _authenticated = false.obs;
  final _token = "".obs;
  final _user = User().obs;
  final _userStatistics = UserStatistics().obs;

  bool get authenticated => _authenticated.value;
  set authenticated(value) => _authenticated.value = value;
  String get token => _token.value;
  set token(value) => _token.value = value;
  User get user => _user.value;
  set user(value) => _user.value = value;
  UserStatistics get userStatistics => _userStatistics.value;
  set userStatistics(value) => _userStatistics.value = value;

  LocalStorageServices localStorageServices = Get.put(LocalStorageServices());

  @override
  void onInit() async {
    ever(_token, (value) {
      token = value;
    });
    ever(_user, (value) {
      user = value;
    });
    ever(_userStatistics, (value) {
      userStatistics = value;
    });

    _token.value = await localStorageServices.getToken();
    var userClass = await localStorageServices.getUser();
    _user(userClass);
    var userStatisticsClass = await localStorageServices.getUserStatistics();
    _userStatistics(userStatisticsClass);

    super.onInit();
  }
}
