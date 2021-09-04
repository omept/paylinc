import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylinc/login/login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage(), settings: routeSettings);
  }
  static final RouteSettings routeSettings = RouteSettings(name: "/login");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}