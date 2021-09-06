import 'dart:async';

enum AuthenticationStatus { unknown, signup, forgotPassword, authenticated, unauthenticated, validate_otp, forgot_password, validate_email }
/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    AuthenticationStatus cAS = this.currentAuthenticationState();
    yield cAS;
    yield* _controller.stream;
  }


  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

   currentAuthenticationState() {
     // TOD O :  check if user exists in hive storage and determine their anthentication status.
    return AuthenticationStatus.unknown;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void onboardingReqLogin() {
    this.logOut();
  }

  void onboardingReqSignUp() {
    _controller.add(AuthenticationStatus.signup);
  }

  void dispose() => _controller.close();
}