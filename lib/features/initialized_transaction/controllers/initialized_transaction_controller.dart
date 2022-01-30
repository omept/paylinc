part of initialized_transaction;

class InitializedTransactionController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LocalStorageServices localStorageServices = Get.find();
  AuthController authController = Get.find();
  var initializedTransaction = InitializedTransaction().obs;
  var intlzdTrnscnB64Url = InitializedTransactionB64().obs;
  var b64UrlStr = "".obs;
  var initTrznId = 0.obs;
  var activityList = <ActivityLogData>[].obs;
  var pageStatus = FormzStatus.pure.obs;

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
      // retrieve the transaction with id from api
      try {
        String b64Url = B64Encoder.base64UrlDecode(b64UrlStr.value);
        Map<String, dynamic> b64UrlJson = json.decode(b64Url);
        initTrznId.value = b64UrlJson['id'];
      } on Exception catch (_) {
        _badPageRedrct();
      }
    } else {
      //check if there is a transaction in the local storage
      var intlzdTrnsctnB64Str =
          await localStorageServices.getInitializedTransactionB64();
      if (intlzdTrnsctnB64Str == null) {
        _badPageRedrct();
      }
      intTB64 =
          InitializedTransactionB64().fromBase64UrlStr(intlzdTrnsctnB64Str!);
      InitializedTransaction intTVal = InitializedTransaction();
      if (intTB64.initializedTransaction != null) {
        intTVal = intTB64.initializedTransaction!;
      }

      // simulate having a promo
      // intTVal.promoCode = TransactionPromoCode.fromMap(
      //     json.decode('{"id": 1, "promo_code": "IjsdOW"}'));

      // TODO: set promocode to null if you're the sender

      initializedTransaction.value = intTVal;
      pageStatus.value = FormzStatus.submissionSuccess;
    }
  }

  void _badPageRedrct() {
    Snackbar.errSnackBar("Bad Page", "met an invalid page");
    Get.offNamed(Routes.dashboard);
  }

  @override
  void onReady() {
    super.onReady();
    updatePage(initTrznId.value);
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

  void updatePage(int initTrnzId) async {
    pageStatus.value = FormzStatus.submissionInProgress;
    try {
      InitializedTransactionsApi intTrznzApi =
          InitializedTransactionsApi.withAuthRepository(
              authController.authenticationRepository);
      var res = await intTrznzApi.getInitializedTransaction(
          {'initialized_transaction_id': initTrnzId});

      if (res.status == true) {
        pageStatus.value = FormzStatus.submissionSuccess;
        var intTrzn = InitializedTransaction.fromMap(
            res.data?['initialized_transaction']);

        initializedTransaction.value = intTrzn;
      } else {
        _badPageRedrct();
      }
    } on Exception catch (_) {
      // _badPageRedrct();
    }
  }
}

class ActivityLogData {}
