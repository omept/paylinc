import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

enum AuthenticationStatus {
  unknown,
  signup,
  forgotPassword,
  authenticated,
  unauthenticated,
  validate_otp,
  forgot_password,
  validate_email
}

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
  AuthenticationStatus _authStatus = AuthenticationStatus.unknown;

  Stream<AuthenticationStatus> get status async* {
    AuthenticationStatus cAS = await this.currentAuthenticationState();
    yield cAS;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );
  }
  Future<void> setLoggedIn() async {
    _controller.add(AuthenticationStatus.authenticated);
  }

  currentAuthenticationState() async {
    // Determine their anthentication status.
    this._authStatus = await retrieveAuthStatus();
    return this._authStatus;
  }

  retrieveAuthStatus() async {
    // Get auth status from hive storage
    var authRepBox = await Hive.openBox('auth_repository');
    var status = authRepBox.get('status');
    return hiveStringToAuth(status);
  }

  saveAuthStatus(AuthenticationStatus authStatus) {
    // save auth status for hive storage
    var authRepository = Hive.box('auth_repository');
    authRepository.put('status', hiveAuthToString(authStatus));
  }

  hiveStringToAuth(authString) {
    AuthenticationStatus as;
    if (authString == 'unknown') {
      as = AuthenticationStatus.unknown;
    } else if (authString == 'signup') {
      as = AuthenticationStatus.signup;
    } else if (authString == 'forgotPassword') {
      as = AuthenticationStatus.forgotPassword;
    } else if (authString == 'authenticated') {
      as = AuthenticationStatus.authenticated;
    } else if (authString == 'unauthenticated') {
      as = AuthenticationStatus.unauthenticated;
    } else if (authString == 'validate_otp') {
      as = AuthenticationStatus.validate_otp;
    } else if (authString == 'forgot_password') {
      as = AuthenticationStatus.forgot_password;
    } else if (authString == 'validate_email') {
      as = AuthenticationStatus.validate_email;
    } else {
      as = AuthenticationStatus.unknown;
    }
    return as;
  }

  hiveAuthToString(auth) {
    String as;
    if (auth == AuthenticationStatus.unknown) {
      as = 'unknown';
    } else if (auth == AuthenticationStatus.signup) {
      as = 'signup';
    } else if (auth == AuthenticationStatus.forgotPassword) {
      as = 'forgotPassword';
    } else if (auth == AuthenticationStatus.authenticated) {
      as = 'authenticated';
    } else if (auth == AuthenticationStatus.unauthenticated) {
      as = 'unauthenticated';
    } else if (auth == AuthenticationStatus.validate_otp) {
      as = 'validate_otp';
    } else if (auth == AuthenticationStatus.forgot_password) {
      as = 'forgot_password';
    } else if (auth == AuthenticationStatus.validate_email) {
      as = 'validate_email';
    } else {
      as = 'unknown';
    }
    return as;
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

  void dispose() {
    _controller.close();
  }

  void onboardingReqAcctVerification() {
    _controller.add(AuthenticationStatus.validate_otp);
  }
}
