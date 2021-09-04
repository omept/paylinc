import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })   : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(UnknownAuth(user: User.empty)) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    var user = await _tryGetUser();
    if (user == null) {
      user = User.empty;
    }
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return Unauthenticated(user: user);
      case AuthenticationStatus.authenticated:
        return Authenticated(user: user);
      case AuthenticationStatus.signup:
        return SignUpAuth(user: user);
      case AuthenticationStatus.validate_otp:
        return ValidateOtp(user: user);
      case AuthenticationStatus.forgot_password:
        return ForgotPassword(user: user);
      case AuthenticationStatus.validate_email:
        return ValidateEmail(user: user);
      default:
        return UnknownAuth(user: user);
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}