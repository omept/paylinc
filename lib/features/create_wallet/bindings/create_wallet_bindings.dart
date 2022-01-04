part of create_wallet;

class CreateWalletBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateWalletController());
  }
}
