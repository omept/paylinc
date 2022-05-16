part of initialized_transactions;

class InitializedTransactionsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  LocalStorageServices localStorageServices = Get.find();
  var walletTransactionsList = <InitializedTransaction?>[].obs;
  var paymentTransactionsList = <InitializedTransaction?>[].obs;
  var userTransactionsResponse = InitializedTransactionsResponse().obs;
  var isRefreshing = false.obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // retrieve cached entries from storage
    InitializedTransactionsResponse? _usrITRs =
        await localStorageServices.getInitializedTransactionsResponse();
    paymentTransactionsList.value =
        _usrITRs?.outgoingInitializedTransactions ?? [];
    walletTransactionsList.value =
        _usrITRs?.incomingInitializedTransactions ?? [];

    updateInitializedTransactions();
  }

  void updateInitializedTransactions() async {
    try {
      isRefreshing.value = true;
      var api = InitializedTransactionsApi();
      ResponseModel res = await api.getInitializedTransactions();
      if (res.status == true) {
        InitializedTransactionsResponse _usrITRs =
            InitializedTransactionsResponse.fromMap(res.data!);
        paymentTransactionsList.value =
            _usrITRs.outgoingInitializedTransactions ?? [];
        walletTransactionsList.value =
            _usrITRs.incomingInitializedTransactions ?? [];
        // save to storage
        localStorageServices.saveInitializedTransactionsResponse(_usrITRs);
      } else {
        Snackbar.errSnackBar('Could not fetch your transactions',
            res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar(
          'Could not fetch your transactions', RestApiServices.errMessage);
    }
    isRefreshing.value = false;
  }

  void viewInititalizedTransaction(
      {required AlertTagType selectedType,
      required int selectedIndex,
      required InitializedTransaction? initializedTransaction}) async {
    // set the default initialized transaction page data to storage
    if (selectedType == AlertTagType.payment) {
      initializedTransaction?.createdAt =
          paymentTransactionsList[selectedIndex]?.createdAt;
    } else {
      initializedTransaction?.createdAt =
          walletTransactionsList[selectedIndex]?.createdAt;
    }

    var initializedTransactionB64 = InitializedTransactionB64.fromMap({
      "alert_tag_type": '',
      "alert_td": 0,
      "initialized_transaction": initializedTransaction?.toMap(),
    });
    localStorageServices.saveInitializedTransactionB64(
        initializedTransactionB64: initializedTransactionB64);
    // redirect to the initialized transaction page
    await Get.toNamed(Routes.initializedTransactionNoId);
  }
}
