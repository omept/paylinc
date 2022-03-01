part of pin_update;

class PinUpdateBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinUpdateController());
  }
}
