import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => SplashPage(), settings: routeSettings);
  }

  static final RouteSettings routeSettings = RouteSettings(name: "/loading");

  @override
  Widget build(BuildContext context) {
    // const Duration(milliseconds: 8000);

    return const Scaffold(
      // body: Center(child: CircularProgressIndicator()),
      body: Center(child: Text('Loading ...')),
    );
  }
}
