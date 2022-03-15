part of password_update;

class PasswordUpdateBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordUpdateController());
  }
}
