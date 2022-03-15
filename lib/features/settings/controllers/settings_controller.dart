part of settings;

class SettingsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authCtrl = Get.find();

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void customerVerification() async {
    try {
      var api = UserApi.withAuthRepository(authCtrl.authenticationRepository);
      ResponseModel res = await api.customerVerification();
      if (res.status == true) {
        Snackbar.successSnackBar(
            'Request sent.', "Account verification request sent.");
      } else {
        Snackbar.errSnackBar('Account Verification request failed',
            res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar(
          'Account Verification request failed', SettingsApi.errMessage);
    }
  }
}
