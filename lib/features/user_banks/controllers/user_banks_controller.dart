part of user_banks;

class UserBanksController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  // LocalStorageServices localStorageServices = Get.find();

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  // }

}
