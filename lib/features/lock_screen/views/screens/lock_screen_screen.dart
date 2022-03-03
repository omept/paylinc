library lock_screen;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
// binding
part '../../bindings/lock_screen_binding.dart';

// controller
part '../../controllers/lock_screen_controller.dart';

class LockScreen extends GetView<LockScreenController> {
  const LockScreen({Key? key}) : super(key: key);
  final kTitleStyle = const TextStyle(
    fontFamily: 'CM Sans Serif',
    fontSize: 26.0,
    height: 1.5,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Icon(
            Icons.fingerprint,
            size: 100,
          ),
        ),
      ),
    );
  }
}
