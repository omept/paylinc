import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';

class AuthenticatedMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    print(' AuthenticatedMiddleware redirect for $route called');

    if (authController.appLocked && route != Routes.lockScreen) {
      print('redirect to lock screen');
      return RouteSettings(name: Routes.lockScreen);
    }

    if (!authController.authenticated) {
      print('redirect to login');
      return RouteSettings(name: Routes.login);
    }

    //  if (!authController.authenticated) {
    //     print('redirect to login');
    //     return RouteSettings(name: Routes.login);
    //   }
    print('return null');

    return null;
  }
}
