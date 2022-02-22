part of view_stash;

class ViewStashController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  LocalStorageServices localStorageServices = Get.find();
  var stashTransactionsList = <StashLogData?>[].obs;

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
    StashLogsResponse? _wlRs =
        await localStorageServices.getStashLogsResponse();
    stashTransactionsList.value = _wlRs?.stashLogsData ?? [];

    updateLogs();
  }

  void updateLogs() async {
    try {
      var api = WalletsApi();
      ResponseModel res = await api.getStashLogs();
      if (res.status == true) {
        StashLogsResponse _sLRs = StashLogsResponse.fromMap(res.data!);
        log(_sLRs.stashLogsData.toString());

        stashTransactionsList.value = _sLRs.stashLogsData ?? [];
        // save to storage
        localStorageServices.saveStashLogsResponse(_sLRs);
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
    await Get.toNamed(Routes.initialized_transaction_no_id);
  }
}
