import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
// import 'dart:convert';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({
    required AuthenticationRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(const OnboardingState(hasOnboarded: false, status: FormzStatus.pure));

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if (event is OnboardingRequestLogin) {
      _authenticationRepository.onboardingReqLogin();
      yield _mapAlreadyOnbordedToState();
    } else if (event is OnboardingRequestSignUp) { 
      _authenticationRepository.onboardingReqSignUp();
      yield _mapAlreadyOnbordedToState();
    }
  }

  OnboardingState _mapAlreadyOnbordedToState() {
      return OnboardingState(hasOnboarded: true, status: FormzStatus.submissionSuccess);
  } 

}