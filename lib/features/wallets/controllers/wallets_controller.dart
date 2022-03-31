part of wallets;

class WalletsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var combinedBal = 0.0.obs;
  var currncy = "".obs;
  var stashBal = 0.obs;
  var walletsList = <Wallet?>[].obs;
  AuthController authController = Get.find();

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() {
    super.onInit();
    stashBal.value = authController.user.value.stashBalance ?? 0;
    currncy.value = authController.user.value.country?.currencyAbr ?? '';
    walletsList.value = authController.user.value.wallets ?? [];

    for (var e in walletsList) {
      combinedBal.value += e?.balance ?? 0;
    }
  }

  void setSelectedWallet(int selectedIndex) {
    try {
      authController.selectedWallet.value = walletsList[selectedIndex]!;
    } on Exception catch (_) {}
  }
}
