part of dashboard;

class DashboardController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _totalWallet = 0.obs;
  set totalWallet(value) => _totalWallet.value = value;
  get totalWallet => _totalWallet.value;
  AuthController authController = Get.find();

  @override
  void onInit() {
    totalWallet = authController.user.value.wallets?.length ?? 0;
    super.onInit();
    authController.fetUserFromToken();
  }

  @override
  void onReady() async {
    super.onReady();
    Future.delayed(
        Duration(seconds: 3), () async => await authController.initOnesignal());
  }

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }
}
