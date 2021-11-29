import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylinc/features/onboarding/onboarding.dart';
import 'package:paylinc/features/onboarding/view/onboarding_form.dart';

class OnboardingPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => OnboardingPage(), settings: routeSettings);
  }

  static final RouteSettings routeSettings = RouteSettings(name: "/welcome");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return OnboardingBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: OnboardingForm(),
        ),
      ),
    );
  }
}
