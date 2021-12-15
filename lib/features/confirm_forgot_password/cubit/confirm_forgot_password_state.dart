part of 'confirm_forgot_password_cubit.dart';

class ConfirmForgotPasswordState extends Equatable {
  final EmailInput emailI;
  final Password password;
  final Password confirmPassword;
  final TextInput emailToken;
  final FormzStatus status;

  const ConfirmForgotPasswordState({
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.emailToken = const TextInput.pure(),
    this.status = FormzStatus.pure,
    this.emailI = const EmailInput.pure(),
  });

  @override
  List<Object> get props =>
      [emailI, password, confirmPassword, emailToken, status];

  ConfirmForgotPasswordState copyWith(
      {FormzStatus? status,
      EmailInput? email,
      Password? password,
      Password? confirmPassword,
      TextInput? emailT}) {
    return ConfirmForgotPasswordState(
      status: status ?? this.status,
      emailI: email ?? this.emailI,
      emailToken: emailT ?? this.emailToken,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
