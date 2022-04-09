part of app_helpers;

Profile getProfile() {
  AuthController authController = Get.find();
  return Profile(
    photo: AssetImage(ImageRasterPath.avatar1),
    name: authController.user.value.name?.toString() ?? '',
    email: authController.user.value.email?.toString() ?? '',
    paytag: authController.user.value.paytag?.toString() ?? '',
  );
}
