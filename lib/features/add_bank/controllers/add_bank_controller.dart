part of add_bank;

class AddBankController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  // LocalStorageServices localStorageServices = Get.find();
  var acctNumber = "".obs;
  var acctName = "".obs;
  var resolvingAcctName = false.obs;
  var selectedBank = Bank().obs;

  var bankOptions = <S2Choice<Bank>>[].obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() {
    super.onInit();
    var bankList = authController.appBanks.value.appBanksList ?? [];
    var s2Choices = List<S2Choice<Bank>>.from(bankList
        .map((e) => S2Choice<Bank>(value: e ?? Bank(), title: e?.name)));

    bankOptions.value = s2Choices;
  }

  void updateAcountNumber(String acctNum) {
    acctNumber.value = acctNum;
    checkAccountName();
  }

  void selectBank(Bank bank) {
    selectedBank.value = bank;
    checkAccountName();
  }

  void checkAccountName() async {
    if (acctNumber.isEmpty ||
        acctNumber.value.length < 10 ||
        selectedBank.value.id == null ||
        selectedBank.value.id == 0) {
      resolvingAcctName.value = false;
      return;
    }

    try {
      resolvingAcctName.value = true;
      WalletsApi walletsApi = WalletsApi.withAuthRepository(
          authController.authenticationRepository);

      ResponseModel res = await walletsApi.resolveAcctName({
        'bank_id': selectedBank.value.id.toString(),
        'account_number': acctNumber.value.toString(),
      });

      if (res.status == true) {
        acctName.value = res.data?['account_name'];
      } else {
        Snackbar.errSnackBar("Failed", "Could not resolve account name");
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar("Error", "Could not resolve account name");
    } finally {
      resolvingAcctName.value = false;
    }
  }

  void saveBank() async {
    if (acctNumber.isEmpty ||
        acctNumber.value.length < 10 ||
        selectedBank.value.id == null ||
        selectedBank.value.id == 0) {
      return;
    }

    try {
      WalletsApi walletsApi = WalletsApi.withAuthRepository(
          authController.authenticationRepository);

      ResponseModel res = await walletsApi.saveUserBank({
        'bank_id': selectedBank.value.id.toString(),
        'account_number': acctNumber.value.toString(),
        'account_name': acctName.value.toString(),
      });
      if (res.status == true) {
        authController.fetUserFromToken();
        Snackbar.successSnackBar("Saved", "Account saved successfully");
        Get.offAllNamed(Routes.userBanks);
      } else {
        Snackbar.errSnackBar(
            "Failed", res.message ?? "Could not save bank details");
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar("Error", "Could not save bank details");
    }
  }
}
