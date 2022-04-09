import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';

// Check if the app is locked. redirect to locked page if app is locked or ignore redirect
class CheckLockedMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    if (authController.isAppLocked && route != Routes.lockScreen) {
      return RouteSettings(name: Routes.lockScreen);
    }

    return null;
  }
}
