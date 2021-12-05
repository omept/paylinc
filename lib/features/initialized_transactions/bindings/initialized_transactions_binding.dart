part of initialized_transactions;

class InitializedTransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitializedTransactionsController());
  }
}
