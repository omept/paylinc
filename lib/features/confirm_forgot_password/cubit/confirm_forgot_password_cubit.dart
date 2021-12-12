import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/form_inputs/email.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

part 'confirm_forgot_password_state.dart';

class ConfirmForgotPasswordCubit extends Cubit<ConfirmForgotPasswordState> {
  ConfirmForgotPasswordCubit()
      : super(ConfirmForgotPasswordState(emailI: EmailInput.pure()));

  // void submit() {
  //   emit(ConfirmForgotPasswordState(emailI: state.emailI));
  // }
  void submit() async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    AuthenticationRepository authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(Get.context!);

    var api = UserApi.withAuthRepository(authenticationRepository);
    ResponseModel forgotPassRes = await api.confirmForgotPassword({
      'password': state.emailI.value,
    });
    print(forgotPassRes);
    if (forgotPassRes.status == true) {
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));
      Get.offNamed(Routes.confirm_forgot_password);
    } else {
      emit(state.copyWith(status: FormzStatus.submissionFailure));

      Snackbar.errSnackBar('Submission Failed',
          forgotPassRes.message ?? RestApiServices.errMessage);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  newEmail(String email) {
    emit(state.copyWith(email: EmailInput.dirty(email)));
  }
}
