// Data
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/shared_components/models/profile.dart';

Profile getProfile() {
  AuthController authController = Get.find();
  return Profile(
    photo: AssetImage(ImageRasterPath.avatar1),
    name: authController.user.name?.toString() ?? '',
    email: authController.user.email?.toString() ?? '',
    paytag: authController.user.paytag?.toString() ?? '',
  );
}
