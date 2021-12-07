import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get/route_manager.dart';
import 'package:paylinc/shared_components/form_inputs/password.dart';
import 'package:paylinc/shared_components/form_inputs/username.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

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
        var api = UserApi.withAuthRepository(this._authenticationRepository);
        var loginRes = await api.login({
          'email_or_paytag': state.username.value,
          'password': state.password.value,
        });

        if (loginRes.status == true) {
          var locStorageServ = LocalStorageServices();
          locStorageServ.saveToken(loginRes.data?['access_token']);
          locStorageServ.saveUserFromMap(loginRes.data?['user']);
          _authenticationRepository.setLoggedIn();

          yield state.copyWith(
            status: FormzStatus.submissionSuccess,
          );
        } else {
          Get.snackbar(
              'Login Failed', loginRes.message ?? RestApiServices.errMessage);

          yield state.copyWith(
              status: FormzStatus.submissionFailure, message: loginRes.message);
        }
      } on Exception catch (_) {
        yield state.copyWith(
            status: FormzStatus.submissionFailure, message: UserApi.errMessage);
      }
    }
  }
}
