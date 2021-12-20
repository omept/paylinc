part of app_helpers;

Future<User> onAuthenticated(ResponseModel loginRes,
    AuthenticationRepository authenticationRepository) async {
  AuthController authController = Get.find();
  var locStorageServ = LocalStorageServices();
  await locStorageServ.saveToken(loginRes.data?['access_token']);
  User user = await locStorageServ.saveUserFromMap(loginRes.data?['user']);

  locStorageServ.saveUserStatisticsFromMap(loginRes.data?['statistics']);

  authController.user = user;
  authController.token = await locStorageServ.getToken();
  authController.userStatistics = await locStorageServ.getUserStatistics();
  authController.authenticated = true;

  if (user.otpVerified != true) {
    authenticationRepository.shouldValidateOtp();
  }

  if ((user.userId is int) && (user.userId! > 0)) {
    authenticationRepository.setLoggedIn();
  }
  return user;
}
