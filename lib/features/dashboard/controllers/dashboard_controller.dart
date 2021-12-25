part of dashboard;

class DashboardController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  AuthController authController = Get.find();

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  // Data
  _Profile getProfil() {
    return _Profile(
      photo: AssetImage(ImageRasterPath.avatar1),
      name: authController.user.name.toString(),
      email: authController.user.email.toString(),
      paytag: authController.user.paytag.toString(),
    );
  }

  ProjectCardData getSelectedProject() {
    return ProjectCardData(
      percent: .3,
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Paylinc",
      releaseTime: DateTime.now(),
    );
  }
}
