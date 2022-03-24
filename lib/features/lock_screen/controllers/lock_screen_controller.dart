part of lock_screen;

class LockScreenController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();

  unlock() async {
    await authController.unlock();
    print('app unlocked');
    AuthenticationStatus currentState =
        await authController.currentAuthenticationState();

    print("currentState: $currentState");
  }
}
