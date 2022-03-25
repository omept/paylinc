part of view_wallet;

class ViewWalletController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  LocalStorageServices localStorageServices = Get.find();
  var walletTransactionsList = <WalletLogData?>[].obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // set logs
    // retrieve logs from storage
    WalletLogsResponse? _wlRs =
        await localStorageServices.getWalletLogsResponse();
    walletTransactionsList.value = _wlRs?.walletLogsData ?? [];

    updateLogs();
  }

  void updateLogs() async {
    try {
      var api = WalletsApi();
      ResponseModel res = await api.getWalletLogs({
        'wallet_paytag': authController.selectedWallet.value.walletPaytag ?? '',
      });
      if (res.status == true) {
        WalletLogsResponse _wLRs = WalletLogsResponse.fromMap(res.data!);
        walletTransactionsList.value = _wLRs.walletLogsData ?? [];
        // save to storage
        localStorageServices.saveWalletLogsResponse(_wLRs);
      } else {
        Snackbar.errSnackBar('Could not fetch your logs',
            res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar('Could not fetch your logs', WalletsApi.errMessage);
    }
  }

  void viewInititalizedTransaction(
      {required AlertTagType selectedType,
      required int selectedIndex,
      required int? initializedTransactionId}) async {
    var initTran = InitializedTransaction();
    initTran.id = initializedTransactionId;
    var initializedTransactionB64 = InitializedTransactionB64.fromMap({
      "alert_tag_type": '',
      "alert_td": 0,
      "initialized_transaction": initTran.toMap(),
    });
    localStorageServices.saveInitializedTransactionB64(
        initializedTransactionB64: initializedTransactionB64);
    // redirect to the initialized transaction page
    await Get.toNamed(Routes.initializedTransactionNoId);
  }
}
