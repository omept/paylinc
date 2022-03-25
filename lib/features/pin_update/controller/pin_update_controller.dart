part of pin_update;

class PinUpdateController extends GetxController {
  final _status = FormzStatus.pure.obs;
  var currentPin = 0.obs;
  var newPin = 0.obs;
  var cNewPin = 0.obs;
  AuthController authController = Get.find<AuthController>();

  FormzStatus get status => _status.value;
  set status(val) => _status.value = val;

  void pinUpdate() async {
    _status.value = FormzStatus.submissionInProgress;
    try {
      UserApi api =
          UserApi.withAuthRepository(authController.authenticationRepository);
      var res = await api.updatePin({
        'current_pin': currentPin.value.toString(),
        'new_pin': newPin.value.toString(),
        'confirm_new_pin': cNewPin.value.toString()
      });

      if (res.status == true) {
        _status.value = FormzStatus.submissionSuccess;
        Snackbar.errSnackBar('Your pin has been updated',
            res.message ?? RestApiServices.errMessage);

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
