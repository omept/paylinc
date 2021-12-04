part of 'onboarding_bloc.dart';


abstract class OnboardingEvent {
  const OnboardingEvent();
}

class OnboardingRequestLogin extends OnboardingEvent {
  const OnboardingRequestLogin();
}

class OnboardingRequestSignUp extends OnboardingEvent {
  const OnboardingRequestSignUp();
}