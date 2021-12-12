part of 'confirm_forgot_password_cubit.dart';

class ConfirmForgotPasswordState extends Equatable {
  final EmailInput emailI;
  final FormzStatus status;

  const ConfirmForgotPasswordState({
    this.status = FormzStatus.pure,
    this.emailI = const EmailInput.pure(),
  });

  @override
  List<Object> get props => [this.emailI];

  ConfirmForgotPasswordState copyWith(
      {FormzStatus? status, EmailInput? email}) {
    return ConfirmForgotPasswordState(
      status: status ?? this.status,
      emailI: email ?? this.emailI,
    );
  }
}
