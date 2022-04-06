part of add_bank;

class AddBankBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddBankController());
  }
}
