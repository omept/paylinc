part of password_update;

class PasswordUpdateController extends GetxController {
  var _status = FormzStatus.pure.obs;
  var currentPassword = "".obs;
  var newPassword = "".obs;
  var cNewPassword = "".obs;
  AuthController authController = Get.find<AuthController>();

  FormzStatus get status => _status.value;
  set status(val) => _status.value = val;

  void passwordUpdate() async {
    _status.value = FormzStatus.submissionInProgress;
    try {
      UserApi api =
          UserApi.withAuthRepository(authController.authenticationRepository);
      var res = await api.updatePassword({
        'old_password': currentPassword.value,
        'password': newPassword.value,
        'confirm_password': cNewPassword.value
      });

      if (res.status == true) {
        _status.value = FormzStatus.submissionSuccess;
        Snackbar.errSnackBar(
            'Updated', res.message ?? RestApiServices.errMessage);

        Get.offNamed(Routes.settings);
      } else {
        _status.value = FormzStatus.submissionFailure;

        Snackbar.errSnackBar(
            'Failed', res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar('Network error', RestApiServices.errMessage);
    }
  }
}
