import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/models/email.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState(emailI: EmailInput.dirty('')));

  void submit() {
    emit(ForgotPasswordState(emailI: state.emailI));
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
