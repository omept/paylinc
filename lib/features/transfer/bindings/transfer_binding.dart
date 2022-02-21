part of transfer;

class TransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransferController());
  }
}
