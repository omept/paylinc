part of view_stash;

class ViewStashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewStashController());
  }
}
