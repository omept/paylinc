import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/form_inputs/text_input.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
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
    final password = TextInput.dirty(event.newPassword);
    return state.copyWith(
      password: password,
    );
  }

  SignUpState _mapCountryChangedToState(
    SignUpCountryChanged event,
    SignUpState state,
  ) {
    final countryID = TextInput.dirty(event.newCountry.countryId.toString());
    return state.copyWith(countryId: countryID);
  }

  SignUpState _mapNameChangedToState(
    SignUpNameChanged event,
    SignUpState state,
  ) {
    final name = TextInput.dirty(event.newName);
    return state.copyWith(
      name: name,
    );
  }

  SignUpState _mapTransferPinChangedToState(
    SignUpTransferPinChanged event,
    SignUpState state,
  ) {
    final transferPin = TextInput.dirty(event.transferPin);
    return state.copyWith(
      transferPin: transferPin,
    );
  }

  SignUpState _mapPaytagChangedToState(
    SignUpPaytagChanged event,
    SignUpState state,
  ) {
    final paytag = TextInput.dirty(event.newPaytag);
    return state.copyWith(
      paytag: paytag,
    );
  }

  SignUpState _mapEmailChangedToState(
    SignUpEmailChanged event,
    SignUpState state,
  ) {
    final email = TextInput.dirty(event.newEmail);
    return state.copyWith(
      email: email,
    );
  }

  Stream<SignUpState> _mapSignUpSubmittedToState(
    SignUpSubmitted event,
    SignUpState state,
  ) async* {
    bool canSubmit = Formz.validate(allStateInputs(state)) == FormzStatus.valid;
    if (canSubmit) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        var api = UserApi.withAuthRepository(_authenticationRepository);
        var signUpRes = await api.signUp({
          'email': state.email.value,
          'name': state.name.value,
          'paytag': state.paytag.value,
          'country_id': kCountry.countryId.toString(),
          'password': state.password.value,
          'transfer_pin': state.transferPin.value,
        });
        if (signUpRes.status == true) {
          yield state.copyWith(
            status: FormzStatus.submissionSuccess,
          );

          await onAuthenticated(signUpRes, _authenticationRepository);
        } else {
          Snackbar.errSnackBar('Sign Up Failed',
              signUpRes.message ?? RestApiServices.errMessage);

          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
        // yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } else {
      Snackbar.errSnackBar('Missing Fields', "fill the registration form");
    }
  }

  Stream<SignUpState> _checkPaytagAvailability(
      SignUpPaytagChanged event, SignUpState state) async* {
    yield state.copyWith(
      paytagUsageMessage: 'checking ' + event.newPaytag,
    );
    try {
      var api = UserApi.withAuthRepository(_authenticationRepository);
      var loginRes = await api.isPaytagUsable({
        'paytag': event.newPaytag,
      });
      yield state.copyWith(
        paytagUsageMessage: loginRes.message?.toLowerCase(),
      );
    } on Exception catch (_) {
      yield state.copyWith(
        paytagUsageMessage: 'no internet',
      );
    }
  }

  List<FormzInput> allStateInputs(SignUpState state) {
    return state.allInputs();
  }
}
