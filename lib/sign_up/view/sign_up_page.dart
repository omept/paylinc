import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylinc/sign_up/sign_up.dart';
import 'package:paylinc/sign_up/view/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignUpPage(), settings: routeSettings);
  }

  static final RouteSettings routeSettings = RouteSettings(name: "/sign-up");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return SignUpBloc(
               authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: SignUpForm()),
        ),
    );
  }
}