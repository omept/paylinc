library lock_screen;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/shared_components.dart';
// binding
part '../../bindings/lock_screen_binding.dart';

// controller
part '../../controllers/lock_screen_controller.dart';

class LockScreen extends GetView<LockScreenController> {
  LockScreen({Key? key}) : super(key: key);
  final kTitleStyle = TextStyle(
    fontSize: 36.0,
    height: 1.5,
  );
  final kSubTitleStyle = TextStyle(
    // fontFamily: 'CM Sans Serif',
    fontSize: 18.0,
    height: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: ResponsiveBuilder(
          mobileBuilder: _applockMobileScreenWidget,
          tabletBuilder: _applockMobileScreenWidget,
          desktopBuilder: _applockMobileScreenWidget,
        )),
      ),
    );
  }

  Widget _applockMobileScreenWidget(context, constraints) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100, width: double.infinity),
        SizedBox(
          height: 200,
          width: 100,
          child: Center(
            child: InkWell(
              onTap: () async {
                await controller.unlock();
              },
              child: Icon(
                Icons.fingerprint,
                size: 100,
              ),
            ),
          ),
        ),
        Text("App Locked", style: kTitleStyle),
        SizedBox(height: kSpacing / 3),
        Text("Tap biometric icon to unlock", style: kSubTitleStyle)
      ],
    );
  }
}
