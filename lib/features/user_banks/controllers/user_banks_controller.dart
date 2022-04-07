part of user_banks;

class UserBanksController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  // LocalStorageServices localStorageServices = Get.find();
  RxList<UserBank?> uBanksList = <UserBank?>[].obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    print(authController.user.value.userBanks);
    uBanksList.value = authController.user.value.userBanks ?? [];
  }

  void deleteUserBank(UserBank uBank) {}
}
