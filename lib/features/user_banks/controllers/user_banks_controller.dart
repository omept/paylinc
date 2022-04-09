part of user_banks;

class UserBanksController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  // LocalStorageServices localStorageServices = Get.find();
  RxList<UserBank?> uBanksList = <UserBank?>[].obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    uBanksList.value = authController.user.value.userBanks ?? [];
  }

  Future<void> deleteUserBank(UserBank uBank, int index) async {
    try {
      // delete locally
      uBanksList.removeAt(index);
      authController.user.value.userBanks?.removeAt(index);

      // make api call to delete from server
      WalletsApi walletsApi = WalletsApi.withAuthRepository(
          authController.authenticationRepository);

      ResponseModel res =
          await walletsApi.walletTransferToBank({'id': uBank.id.toString()});

      if (res.status == true) {
        authController.fetUserFromToken();
        Snackbar.successSnackBar('Successful', res.message ?? '');
      } else {
        Snackbar.errSnackBar(
            'Failed', res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {}
  }
}
