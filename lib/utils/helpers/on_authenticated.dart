part of app_helpers;

Future<User?> onAuthenticated(ResponseModel loginRes,
    AuthenticationRepository authenticationRepository) async {
  AuthController authController = Get.find();
  var locStorageServ = LocalStorageServices();
  await locStorageServ.saveToken(loginRes.data?['access_token']);
  var bankTrnsferCharge = loginRes.data?['transfer_charge'] ?? 0;
  User _user = await locStorageServ.saveUserFromMap(loginRes.data?['user']);

  locStorageServ.saveUserStatisticsFromMap(loginRes.data?['statistics']);

  authController.user.value = _user;
  authController.token = await locStorageServ.getToken();
  authController.userStatistics = await locStorageServ.getUserStatistics();
  authController.authenticated = true;
  authController.bankTransferCharge.value = bankTrnsferCharge;

  if (_user.otpVerified != true) {
    authenticationRepository.shouldValidateOtp();
    return null;
  }

  if ((_user.userId is int) && (_user.userId! > 0)) {
    authenticationRepository.setLoggedIn();
  }
  return _user;
}
