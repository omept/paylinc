part of app_helpers;

Future<User> onAuthenticated(ResponseModel loginRes,
    AuthenticationRepository authenticationRepository) async {
  var locStorageServ = LocalStorageServices();
  locStorageServ.saveToken(loginRes.data?['access_token']);
  User user = await locStorageServ.saveUserFromMap(loginRes.data?['user']);

  locStorageServ.saveUserStatisticsFromMap(loginRes.data?['statistics']);
  if ((user.userId is int) &&
      (user.userId! > 0) &&
      (user.otpVerified != null)) {
    authenticationRepository.setLoggedIn();
  } else {
    authenticationRepository.shouldValidateOtp();
  }
  return user;
}
