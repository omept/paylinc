import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylinc/forgot_password/forgot_password.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ForgotPasswordPage(), settings: routeSettings);
  }
  static final RouteSettings routeSettings = RouteSettings(name: "/forgot-password");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return ForgotPasswordCubit();
          },
          child: ForgotPasswordForm(),
        ),
      ),
    );
  }
}