import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get/get_connect.dart';
import 'package:paylinc/shared_components/form_inputs/password.dart';
import 'package:paylinc/shared_components/form_inputs/username.dart';
import 'package:paylinc/utils/apis/userRequest.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(
        status: FormzStatus.submissionInProgress,
        username: Username.dirty(state.username.value),
        password: Password.dirty(state.password.value),
      );
      try {
        await _authenticationRequest(
          username: state.username.value,
          password: state.password.value,
        );
        var userApi = new UserApi();
        var resp = await userApi.login({
          'username': state.username.value,
          'password': state.password.value,
        });
        print(resp);
        //  await _authenticationRepository.logIn(
        //   username: state.username.value,
        //   password: state.password.value,
        // );
        // yield state.copyWith(
        //   status: FormzStatus.submissionSuccess,
        //   username: Username.dirty(state.username.value),
        //   password: Password.dirty(state.password.value),
        // );
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  _authenticationRequest(
      {required String username, required String password}) async {
    // Map data = {'username': username, 'password': password};
  }
}
