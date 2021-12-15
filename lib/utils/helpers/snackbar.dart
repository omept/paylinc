part of 'app_helpers.dart';

class Snackbar {
  static successSnackBar(String title, String message) =>
      Get.snackbar(title, message);

  static errSnackBar(String title, String message) =>
      Get.snackbar(title, message);

  static infoSnackBar(String message) => Get.snackbar("Info", message);
}
