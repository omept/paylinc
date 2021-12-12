import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/utils/controllers/auth_controller.dart';

class AuthenticatedMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    if (!authController.authenticated) {
      return RouteSettings(name: Routes.login);
    }
  }
}
