import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';

void main() async {
  // Init Hive
  await Hive.initFlutter();
  // Start App
  runApp(Paylinc(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository()));
}
