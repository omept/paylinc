part of user_banks;

class UserBanksBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserBanksController());
  }
}
