part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
    AuthenticationState({
     required this.status,
     required  this.user,
  });

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}

class UnknownAuth extends AuthenticationState {
  UnknownAuth({
    required User user,
  }) : super(
          status: AuthenticationStatus.unknown,
          user: user,
      );
}
class SignUpAuth extends AuthenticationState {
  SignUpAuth({
    required User user,
  }) : super(
          status: AuthenticationStatus.signup,
          user: user,
      );
}
class Authenticated extends AuthenticationState {
  Authenticated({
    required User user,
  }) : super(
          status: AuthenticationStatus.authenticated,
          user: user,
      );
}

class Unauthenticated extends AuthenticationState {
  Unauthenticated({
    required User user,
  }) : super(
          status: AuthenticationStatus.unauthenticated,
          user: user,
      );
}
class ValidateOtp extends AuthenticationState {
  ValidateOtp({
    required User user,
  }) : super(
          status: AuthenticationStatus.validate_otp,
          user: user,
      );
}
class ValidateEmail extends AuthenticationState {
  ValidateEmail({
    required User user,
  }) : super(
          status: AuthenticationStatus.validate_email,
          user: user,
      );
}
class ForgotPassword extends AuthenticationState {
  ForgotPassword({
    required User user,
  }) : super(
          status: AuthenticationStatus.forgot_password,
          user: user,
      );
}