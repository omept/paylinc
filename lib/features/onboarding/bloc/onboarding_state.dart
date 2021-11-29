part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
   required this.status,
    required this.hasOnboarded,
  });

  final FormzStatus status;
  final bool hasOnboarded;

  OnboardingState copyWith({
    required bool hasOnboarded,
  }) {
    return OnboardingState(
      hasOnboarded: hasOnboarded, status: FormzStatus.pure
    );
  }

  @override
  List<Object> get props => [status, hasOnboarded];
}