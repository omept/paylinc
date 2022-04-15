import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/shared_components.dart';
import 'package:paylinc/utils/utils.dart';

part 'confirm_forgot_password_state.dart';

class ConfirmForgotPasswordCubit extends Cubit<ConfirmForgotPasswordState> {
  ConfirmForgotPasswordCubit()
      : super(ConfirmForgotPasswordState(emailI: EmailInput.pure()));

  void submit() async {
    if (state.status.isInvalid ||
        !(state.confirmPassword.value == state.password.value)) {
      Snackbar.infoSnackBar("fill missing fields and correct all errors.");
      return;
    }

    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    AuthenticationRepository authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(Get.context!);

    var api = UserApi.withAuthRepository(authenticationRepository);
    ResponseModel cForgotPassRes = await api.confirmForgotPassword({
      'password': state.password.value,
      'email': state.emailI.value,
      'email_token': state.emailToken.value,
    });
    if (cForgotPassRes.status == true) {
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));
      Get.offNamed(Routes.dashboard);
    } else {
      emit(state.copyWith(status: FormzStatus.submissionFailure));

      Snackbar.errSnackBar('Submission Failed',
          cForgotPassRes.message ?? RestApiServices.errMessage);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  updateEmail(String email) {
    emit(state.copyWith(
        status: Formz.validate(formInputs()), email: EmailInput.dirty(email)));
  }

  updateEmailToken(String emailTok) {
    emit(state.copyWith(
        status: Formz.validate(formInputs()),
        emailT: TextInput.dirty(emailTok)));
  }

  updateNewPassWord(String password) {
    emit(state.copyWith(
        status: Formz.validate(formInputs()),
        password: Password.dirty(password)));
  }

  updateConfirmNewPassWord(String password) {
    emit(state.copyWith(
        status: Formz.validate(formInputs()),
        confirmPassword: Password.dirty(password)));
  }

  List<FormzInput> formInputs() {
    return [
      state.emailI,
      state.emailToken,
      state.password,
      state.confirmPassword
    ];
  }
}
