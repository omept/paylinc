part of send_money;

class SendMoneyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendMoneyController());
  }
}
