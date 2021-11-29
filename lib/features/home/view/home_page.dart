import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/config/themes/app_theme.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:paylinc/config/authentication/bloc/authentication_bloc.dart';
import 'package:paylinc/features/dashboard/views/screens/dashboard_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => HomePage(), settings: routeSettings);
  }

  static final RouteSettings routeSettings = RouteSettings(name: "/home");

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Home')),
    //   body: Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         Builder(
    //           builder: (context) {
    //             final userId = context.select(
    //               (AuthenticationBloc bloc) => bloc.state.user.id,
    //             );
    //             return Text('UserID: $userId');
    //           },
    //         ),
    //         ElevatedButton(
    //           child: const Text('Logout'),
    //           onPressed: () {
    //             context
    //                 .read<AuthenticationBloc>()
    //                 .add(AuthenticationLogoutRequested());
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return GetMaterialApp(
      title: 'Paylinc',
      theme: AppTheme.basic,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
