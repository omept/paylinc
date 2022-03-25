import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

enum AuthenticationStatus {
  unknown,
  signup,
  forgotPassword,
  authenticated, // logged in
  unauthenticated, // not logged in
  validateOtp,
  validateEmail
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
    AuthenticationStatus cAS = await currentAuthenticationState();
    yield cAS;
    yield* _controller.stream;
  }

  Future<void> setLoggedIn() async {
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> shouldValidateOtp() async {
    _controller.add(AuthenticationStatus.validateOtp);
  }

  Future<AuthenticationStatus> currentAuthenticationState() async {
    // Determine the anthentication status.
    _authStatus = await retrieveAuthStatus();
    return _authStatus;
  }

  Future<AuthenticationStatus> retrieveAuthStatus() async {
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

  AuthenticationStatus hiveStringToAuth(String? authString) {
    Map<String, AuthenticationStatus> _as = {
      'unknown': AuthenticationStatus.unknown,
      'signup': AuthenticationStatus.signup,
      'forgotPassword': AuthenticationStatus.forgotPassword,
      'authenticated': AuthenticationStatus.authenticated,
      'unauthenticated': AuthenticationStatus.unauthenticated,
      'validateOtp': AuthenticationStatus.validateOtp,
      'validateEmail': AuthenticationStatus.validateEmail,
    };
    return _as[authString] ?? AuthenticationStatus.unknown;
  }

  hiveAuthToString(AuthenticationStatus auth) {
    Map<AuthenticationStatus, String> _as2 = {
      AuthenticationStatus.unknown: 'unknown',
      AuthenticationStatus.signup: 'signup',
      AuthenticationStatus.forgotPassword: 'forgotPassword',
      AuthenticationStatus.authenticated: 'authenticated',
      AuthenticationStatus.unauthenticated: 'unauthenticated',
      AuthenticationStatus.validateOtp: 'validateOtp',
      AuthenticationStatus.validateEmail: 'validateEmail',
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
    logOut();
  }

  void onboardingReqSignUp() {
    _controller.add(AuthenticationStatus.signup);
  }

  void dispose() {
    _controller.close();
  }

  void onboardingReqAcctVerification() {
    _controller.add(AuthenticationStatus.validateOtp);
  }
}
