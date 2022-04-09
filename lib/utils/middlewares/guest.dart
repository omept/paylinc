import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';

class GuestMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    if (authController.isAuthenticated) {
      return RouteSettings(name: Routes.dashboard);
    }
    return null;
  }
}
