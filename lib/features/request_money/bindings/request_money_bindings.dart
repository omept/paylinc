part of request_money;

class RequestMoneyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestMoneyController());
  }
}
