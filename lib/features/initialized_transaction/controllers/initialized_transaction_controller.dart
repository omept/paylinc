part of initialized_transaction;

class InitializedTransactionController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LocalStorageServices localStorageServices = Get.find();
  AuthController authController = Get.find();
  var initializedTransaction = InitializedTransaction().obs;
  var intlzdTrnscnB64Url = InitializedTransactionB64().obs;
  var b64UrlStr = "".obs;
  var initTrznId = 0.obs;
  var activityLogs = TransactionaActivityLogs().obs;
  var pageStatus = FormzStatus.pure.obs;

  final acceptOrDelineable = <int>[
    TransactionStatus.pending,
    TransactionStatus.requested
  ];
  final payOrTerminatable = <int>[
    TransactionStatus.acceptedNoCard,
  ];

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onReady() async {
    super.onReady();
    InitializedTransactionB64 intTB64;
    // get the initialized transaction id from url
    b64UrlStr.value = Get.parameters['b64UrlStr']?.toString() ?? "";
    if (b64UrlStr.value != "") {
      pageStatus.value = FormzStatus.submissionInProgress;
      // retrieve the transaction with id from api
      try {
        String b64Url = B64Encoder.base64UrlDecode(b64UrlStr.value);
        Map<String, dynamic> b64UrlJson = json.decode(b64Url);
        initTrznId.value = b64UrlJson['id'];
      } on Exception catch (_) {
        return _badPageRedrct();
      }
    } else {
      //check if there is a transaction in the local storage
      var intlzdTrnsctnB64Str =
          await localStorageServices.getInitializedTransactionB64();
      if (intlzdTrnsctnB64Str == null) {
        return _badPageRedrct();
      }
      intTB64 =
          InitializedTransactionB64().fromBase64UrlStr(intlzdTrnsctnB64Str);
      InitializedTransaction intTVal = InitializedTransaction();
      if (intTB64.initializedTransaction != null) {
        intTVal = intTB64.initializedTransaction!;
      }

      if (intTVal.sender?.userId == authController.user.userId) {
        intTVal.promoCode = null;
      }

      initTrznId.value = intTVal.id ?? 0;
      initializedTransaction.value = intTVal;
    }

    updatePage();
  }

  void managePromocode(Rx<InitializedTransaction> initializedTransaction) {
    var intTVal = initializedTransaction.value;
    if (intTVal.sender?.userId == authController.user.userId) {
      intTVal.promoCode = null;
    }

    initTrznId.value = intTVal.id ?? 0;
    initializedTransaction.value = intTVal;
  }

  void _badPageRedrct() {
    Snackbar.errSnackBar("Bad Page", "met an invalid page");
    Get.offNamed(Routes.dashboard);
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

  void updatePage() async {
    try {
      InitializedTransactionsApi intTrznzApi =
          InitializedTransactionsApi.withAuthRepository(
              authController.authenticationRepository);
      var res = await intTrznzApi.getInitializedTransaction(
          {'initialized_transaction_id': initTrznId.value});
      if (res.status != true) {
        return _badPageRedrct();
      }
      pageStatus.value = FormzStatus.submissionSuccess;
      initializedTransaction.value =
          InitializedTransaction.fromMap(res.data?['initialized_transaction']);
      managePromocode(initializedTransaction);
    } on Exception catch (_) {
      return _badPageRedrct();
    }
  }

  void acceptTransaction(InitializedTransaction load) async {
    pageStatus.value = FormzStatus.submissionInProgress;
    try {
      InitializedTransactionsApi intTrznzApi =
          InitializedTransactionsApi.withAuthRepository(
              authController.authenticationRepository);
      var res = await intTrznzApi
          .acceptTransaction({'initialized_transaction_id': load.id});
      pageStatus.value = FormzStatus.submissionSuccess;
      if (res.status != true) {
        Snackbar.errSnackBar("Error", "Failed to accept");
        return;
      }

      clearTransactionStatus();
      Snackbar.successSnackBar("Success", "transaction accept");
    } on Exception catch (_) {
      Snackbar.errSnackBar("Error", "Failed to accept");
    }
  }

  void declineTransaction(InitializedTransaction load) async {
    pageStatus.value = FormzStatus.submissionInProgress;
    try {
      InitializedTransactionsApi intTrznzApi =
          InitializedTransactionsApi.withAuthRepository(
              authController.authenticationRepository);
      var res = await intTrznzApi
          .declineTransaction({'initialized_transaction_id': load.id});
      pageStatus.value = FormzStatus.submissionSuccess;
      if (res.status != true) {
        Snackbar.errSnackBar("Error", "Failed to decline");
        return;
      }
      // clear the transaction status of the loaded transaction
      clearTransactionStatus();
      Snackbar.successSnackBar("Success", "Transaction declined");
    } on Exception catch (_) {
      Snackbar.errSnackBar("Error", "Failed to decline");
    }
  }

  //clear the status of the loaded transaction
  void clearTransactionStatus() {
    initializedTransaction.value.initializedTransactionStatus = null;
  }

  void terminateTransaction(InitializedTransaction load) async {
    pageStatus.value = FormzStatus.submissionInProgress;
    try {
      InitializedTransactionsApi intTrznzApi =
          InitializedTransactionsApi.withAuthRepository(
              authController.authenticationRepository);
      var res = await intTrznzApi
          .terminateTransaction({'initialized_transaction_id': load.id});
      pageStatus.value = FormzStatus.submissionSuccess;
      if (res.status != true) {
        Snackbar.errSnackBar("Failed", "${res.message}");
        return;
      }
      // clear the transaction status of the loaded transaction
      clearTransactionStatus();
      Snackbar.successSnackBar("Success", "Transaction terminated");
    } on Exception catch (_) {
      Snackbar.errSnackBar("Error", "Failed to terminate");
    }
  }

  void payTransaction(InitializedTransaction value) {}
}
