import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/shared_components/form_inputs/text_input.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUpNameChanged) {
      yield _mapNameChangedToState(event, state);
    } else if (event is SignUpCountryChanged) {
      yield _mapCountryChangedToState(event, state);
    } else if (event is SignUpEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is SignUpPaytagChanged) {
      yield _mapPaytagChangedToState(event, state);
      yield* _checkPaytagAvailability(event, state);
    } else if (event is SignUpTransferPinChanged) {
      yield _mapTransferPinChangedToState(event, state);
    } else if (event is SignUpPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SignUpSubmitted) {
      yield* _mapSignUpSubmittedToState(event, state);
    }
  }

  SignUpState _mapPasswordChangedToState(
    SignUpPasswordChanged event,
    SignUpState state,
  ) {
    final password = TextInput.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password]),
    );
  }

  SignUpState _mapCountryChangedToState(
    SignUpCountryChanged event,
    SignUpState state,
  ) {
    final countryID = TextInput.dirty(event.country.countryId.toString());
    return state.copyWith(
      countryId: countryID,
      status: FormzStatus.valid,
    );
  }

  SignUpState _mapNameChangedToState(
    SignUpNameChanged event,
    SignUpState state,
  ) {
    final name = TextInput.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate([name, state.name]),
    );
  }

  SignUpState _mapTransferPinChangedToState(
    SignUpTransferPinChanged event,
    SignUpState state,
  ) {
    final transferPin = TextInput.dirty(event.transferPin);
    return state.copyWith(
      transferPin: transferPin,
      status: Formz.validate([transferPin, state.transferPin]),
    );
  }

  SignUpState _mapPaytagChangedToState(
    SignUpPaytagChanged event,
    SignUpState state,
  ) {
    final paytag = TextInput.dirty(event.paytag);
    return state.copyWith(
      paytag: paytag,
      status: Formz.validate([paytag, state.paytag]),
    );
  }

  SignUpState _mapEmailChangedToState(
    SignUpEmailChanged event,
    SignUpState state,
  ) {
    final email = TextInput.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  Stream<SignUpState> _mapSignUpSubmittedToState(
    SignUpSubmitted event,
    SignUpState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      print('sign up submit state');
      print(state);
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        // await _authenticationRepository.logIn(
        //   username: state.username.value,
        //   password: state.password.value,
        // );
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }

  Stream<SignUpState> _checkPaytagAvailability(
      SignUpPaytagChanged event, SignUpState state) async* {
    yield state.copyWith(
      paytagUsageMessage: 'checking ' + event.paytag,
    );
    print('should say checking for ' + event.paytag);
    var api = UserApi.withAuthRepository(this._authenticationRepository);
    var loginRes = await api.isPaytagUsable({
      'paytag': event.paytag,
    });
    print(loginRes);
    yield state.copyWith(
      paytagUsageMessage: loginRes.message?.toLowerCase(),
    );
    print('should say ' + (loginRes.message ?? ''));
  }
}
