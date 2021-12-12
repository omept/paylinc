import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get/route_manager.dart';
import 'package:paylinc/shared_components/form_inputs/password.dart';
import 'package:paylinc/shared_components/form_inputs/username.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/shared_components/models/user_statistics.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';
import 'package:user_repository/user_repository.dart';

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
        ResponseModel loginRes = await api.login({
          'email_or_paytag': state.username.value,
          'password': state.password.value,
        });

        if (loginRes.status == true) {
          await onAuthenticated(loginRes, _authenticationRepository);

          yield state.copyWith(
            status: FormzStatus.submissionSuccess,
          );
        } else {
          Snackbar.errSnackBar(
              'Login Failed', loginRes.message ?? RestApiServices.errMessage);

          yield state.copyWith(
              status: FormzStatus.submissionFailure, message: loginRes.message);
        }
      } on Exception catch (_) {
        Snackbar.errSnackBar('Login Failed', RestApiServices.errMessage);

        yield state.copyWith(
            status: FormzStatus.submissionFailure, message: UserApi.errMessage);
      }
    }
  }
}
