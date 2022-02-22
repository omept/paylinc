part of view_wallet;

class ViewWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewWalletController());
  }
}
