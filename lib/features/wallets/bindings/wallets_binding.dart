part of wallets;

class WalletsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletsController());
  }
}
