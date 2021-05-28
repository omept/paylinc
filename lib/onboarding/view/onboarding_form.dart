import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylinc/onboarding/onboarding.dart';

class OnboardingForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        print(state);
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.all(12)),
            Text('Onboarding'),
            const Padding(padding: EdgeInsets.all(12)),
            _RequestLoginButton(),
            const Padding(padding: EdgeInsets.all(12)),
            _RequestSignUpButton(),
          ],
        ),
      ),
    );
  }
}



class _RequestLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      // buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return  ElevatedButton(
                  key: const Key('onboarding_OnboardingRequestLogin_raisedButton'),
                  child: const Text('Request Login'),
                  onPressed:  () {
                    context.read<OnboardingBloc>().add(const OnboardingRequestLogin());
                  }
                );
      },
    );
  }
}

class _RequestSignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      // buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return ElevatedButton(
                key: const Key('onboarding_OnboardingRequestSignUp_raisedButton'),
                child: const Text('Request Sign up'),
                onPressed: () {
                  context.read<OnboardingBloc>().add(const OnboardingRequestSignUp());
                },
              );
      },
    );
  }
}