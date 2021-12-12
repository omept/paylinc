import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paylinc/utils/controllers/auth_controller.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';

void main() async {
  // Init Hive
  await Hive.initFlutter();
  // register controllers
  Get.put(AuthController());
  // Start App
  runApp(Paylinc(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository()));
}
