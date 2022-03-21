import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';

class AuthenticatedMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    if (authController.appLocked && route != Routes.lockScreen) {
      return RouteSettings(name: Routes.lockScreen);
    } else if (!authController.appLocked) {
      if (!authController.authenticated) {
        return RouteSettings(name: Routes.login);
      }
    }

    return null;
  }
}
