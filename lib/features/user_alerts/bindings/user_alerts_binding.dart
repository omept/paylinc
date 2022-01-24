part of user_alerts;

class UserAlertsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserAlertsController());
    Get.lazyPut(() => LocalStorageServices());
  }
}
