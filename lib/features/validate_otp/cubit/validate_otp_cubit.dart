import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/form_inputs/otp.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

part 'validate_otp_state.dart';

class ValidateOtpCubit extends Cubit<ValidateOtpState> {
  ValidateOtpCubit() : super(ValidateOtpState(otp: OtpInput.pure()));

  void submit() async {
    AuthenticationRepository authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(Get.context!);
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
}
