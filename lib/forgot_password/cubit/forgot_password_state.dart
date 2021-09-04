part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final EmailInput emailI;
  final FormzStatus status;

  const ForgotPasswordState({
    this.status = FormzStatus.pure,
    this.emailI = const EmailInput.pure(),
  });


  @override
  List<Object> get props => [this.emailI];

  ForgotPasswordState copyWith({
    FormzStatus? status,
    EmailInput? email
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      emailI: email ?? this.emailI,
    );
  }
}