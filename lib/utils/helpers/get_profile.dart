part of app_helpers;

Profile getProfile() {
  AuthController authController = Get.find();
  return Profile(
    photo: AssetImage(ImageRasterPath.avatar1),
    name: authController.user.name?.toString() ?? '',
    email: authController.user.email?.toString() ?? '',
    paytag: authController.user.paytag?.toString() ?? '',
  );
}
