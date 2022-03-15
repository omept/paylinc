part of lock_screen;

class LockScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LockScreenController());
  }
}
