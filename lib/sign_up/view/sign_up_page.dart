import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignUpPage(), settings: routeSettings);
  }

  static final RouteSettings routeSettings = RouteSettings(name: "/sign-up");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Sign up page'),
      ),
    );
  }
}