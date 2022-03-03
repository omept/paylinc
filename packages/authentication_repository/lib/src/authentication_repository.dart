import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

enum AuthenticationStatus {
  unknown,
  signup,
  forgotPassword,
  authenticated, // logged in
  unauthenticated, // not logged in
  validate_otp,
  forgot_password,
  lock_screen,
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

  Future<void> shouldValidateOtp() async {
    _controller.add(AuthenticationStatus.validate_otp);
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

  saveAuthStatus(AuthenticationStatus authStatus) async {
    // save auth status for hive storage
    var authRepository = await Hive.openBox('auth_repository');
    authRepository.put('status', hiveAuthToString(authStatus));
  }

  hiveStringToAuth(authString) {
    AuthenticationStatus _as;
    if (authString == 'unknown') {
      _as = AuthenticationStatus.unknown;
    } else if (authString == 'signup') {
      _as = AuthenticationStatus.signup;
    } else if (authString == 'forgotPassword') {
      _as = AuthenticationStatus.forgotPassword;
    } else if (authString == 'authenticated') {
      _as = AuthenticationStatus.authenticated;
    } else if (authString == 'unauthenticated') {
      _as = AuthenticationStatus.unauthenticated;
    } else if (authString == 'validate_otp') {
      _as = AuthenticationStatus.validate_otp;
    } else if (authString == 'forgot_password') {
      _as = AuthenticationStatus.forgot_password;
    } else if (authString == 'validate_email') {
      _as = AuthenticationStatus.validate_email;
    } else if (authString == 'lock_screen') {
      _as = AuthenticationStatus.lock_screen;
    } else {
      _as = AuthenticationStatus.unknown;
    }
    return _as;
  }

  hiveAuthToString(auth) {
    String _as;
    if (auth == AuthenticationStatus.unknown) {
      _as = 'unknown';
    } else if (auth == AuthenticationStatus.signup) {
      _as = 'signup';
    } else if (auth == AuthenticationStatus.forgotPassword) {
      _as = 'forgotPassword';
    } else if (auth == AuthenticationStatus.authenticated) {
      _as = 'authenticated';
    } else if (auth == AuthenticationStatus.unauthenticated) {
      _as = 'unauthenticated';
    } else if (auth == AuthenticationStatus.validate_otp) {
      _as = 'validate_otp';
    } else if (auth == AuthenticationStatus.forgot_password) {
      _as = 'forgot_password';
    } else if (auth == AuthenticationStatus.validate_email) {
      _as = 'validate_email';
    } else if (auth == AuthenticationStatus.lock_screen) {
      _as = 'lock_screen';
    } else {
      _as = 'unknown';
    }
    return _as;
  }

  void logOut() async {
    // save new auth status for hive storage
    var authRepository = await Hive.openBox('auth_repository');
    authRepository.put(
        'status', hiveAuthToString(AuthenticationStatus.unauthenticated));
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
