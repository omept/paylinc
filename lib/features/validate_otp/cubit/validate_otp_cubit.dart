import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/shared_components.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

part 'validate_otp_state.dart';

class ValidateOtpCubit extends Cubit<ValidateOtpState> {
  final authController = Get.find<AuthController>();
  ValidateOtpCubit() : super(ValidateOtpState(otp: OtpInput.pure()));

  AuthenticationRepository authenticationRepository =
      RepositoryProvider.of<AuthenticationRepository>(Get.context!);

  void submit() async {
    emit(ValidateOtpState(
        otp: state.otp, status: FormzStatus.submissionInProgress));

    var api = UserApi.withAuthRepository(authenticationRepository);
    ResponseModel otpValRes = await api.validateOtp({
      'otp': state.otp.value,
    });
    if (otpValRes.status == true) {
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));

      await onAuthenticated(otpValRes, authenticationRepository);
      Get.offNamed(Routes.dashboard);
    } else {
      emit(state.copyWith(status: FormzStatus.submissionFailure));

      Snackbar.errSnackBar('OTP Validation Failed',
          otpValRes.message ?? RestApiServices.errMessage);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  newOtp(String otp) {
    emit(state.copyWith(otp: OtpInput.dirty(otp)));
  }

  void resendOtp() async {
    if (state.resendCalled == true) {
      Snackbar.infoSnackBar("Too many retries");
      return;
    }

    var email = authController.user.email;
    if (email != null) {
      AuthenticationRepository authenticationRepository =
          RepositoryProvider.of<AuthenticationRepository>(Get.context!);
      var api = UserApi.withAuthRepository(authenticationRepository);
      ResponseModel rOtpRes = await api.resendOtp();

      if (rOtpRes.status == true) {
        Snackbar.successSnackBar(
            'Done', rOtpRes.message ?? RestApiServices.errMessage);
        resendCalled(true);
      } else {
        Snackbar.errSnackBar(
            'Failed', rOtpRes.message ?? RestApiServices.errMessage);
      }
    }
  }

  void resendCalled(bool val) {
    emit(state.copyWith(resendCalled: val));
  }
}
