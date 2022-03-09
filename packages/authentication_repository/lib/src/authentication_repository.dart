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

  Future<void> setLoggedIn() async {
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> shouldValidateOtp() async {
    _controller.add(AuthenticationStatus.validate_otp);
  }

  currentAuthenticationState() async {
    // Determine the anthentication status.
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

  hiveStringToAuth(String authString) {
    Map<String, AuthenticationStatus> _as = {
      'unknown': AuthenticationStatus.unknown,
      'signup': AuthenticationStatus.signup,
      'forgotPassword': AuthenticationStatus.forgotPassword,
      'authenticated': AuthenticationStatus.authenticated,
      'unauthenticated': AuthenticationStatus.unauthenticated,
      'validate_otp': AuthenticationStatus.validate_otp,
      'forgot_password': AuthenticationStatus.forgot_password,
      'validate_email': AuthenticationStatus.validate_email,
      'lock_screen': AuthenticationStatus.lock_screen,
    };
    return _as[authString] ?? 'unknown';
  }

  hiveAuthToString(AuthenticationStatus auth) {
    Map<AuthenticationStatus, String> _as2 = {
      AuthenticationStatus.unknown: 'unknown',
      AuthenticationStatus.signup: 'signup',
      AuthenticationStatus.forgotPassword: 'forgotPassword',
      AuthenticationStatus.authenticated: 'authenticated',
      AuthenticationStatus.unauthenticated: 'unauthenticated',
      AuthenticationStatus.validate_otp: 'validate_otp',
      AuthenticationStatus.forgot_password: 'forgot_password',
      AuthenticationStatus.validate_email: 'validate_email',
      AuthenticationStatus.lock_screen: 'lock_screen',
    };

    return _as2[auth] ?? AuthenticationStatus.unknown;
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

  void lockApp() {
    _controller.add(AuthenticationStatus.lock_screen);
  }
}
