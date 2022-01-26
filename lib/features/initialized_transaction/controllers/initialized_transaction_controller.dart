part of initialized_transaction;

class InitializedTransactionController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LocalStorageServices localStorageServices = Get.find();
  var initializedTransaction = InitializedTransaction().obs;
  var intlzdTrnscnB64Url = InitializedTransactionB64().obs;
  var b64UrlStr = "".obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    InitializedTransactionB64 intTB64;
    // get the initialized transaction id from url
    b64UrlStr.value = Get.parameters['b64UrlStr']?.toString() ?? "";
    if (b64UrlStr.value != "") {
      // retrieve the transaction from api

    } else {
      //check if there is a transaction in the local storage
      var intlzdTrnsctnB64Str =
          await localStorageServices.getInitializedTransactionB64();
      if (intlzdTrnsctnB64Str == null) {
        Snackbar.errSnackBar("Bad Page", "met an invalid page");
        Get.offNamed(Routes.dashboard);
      }
      intTB64 =
          InitializedTransactionB64().fromBase64UrlStr(intlzdTrnsctnB64Str!);
      InitializedTransaction intTVal = InitializedTransaction();
      if (intTB64.initializedTransaction != null) {
        intTVal = intTB64.initializedTransaction!;
      }

      // log(intTVal.toString());
      initializedTransaction.value = intTVal;
    }
  }

  @override
  void onReady() {
    super.onReady();
    updatePage();
  }

  Future<String?> validateB64UrlStr(String? b64UrlStr) async {
    if (b64UrlStr == null) {
      b64UrlStr = await localStorageServices.getInitializedTransactionB64();
      if (b64UrlStr == null) {
        Snackbar.errSnackBar("Bad Page", "met an invalid page");
        Get.offNamed(Routes.dashboard);
      }
    }
    return b64UrlStr;
  }

  void updatePage() {}
}
