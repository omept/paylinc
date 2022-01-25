part of initialized_transaction;

class InitializedTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitializedTransactionController());
  }
}
