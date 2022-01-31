part of user_alerts;

class UserAlertsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  LocalStorageServices localStorageServices = Get.find();
  var walletAlertList = <IncomingAlertsData?>[].obs;
  var paymentAlertList = <OutgoingAlertsData?>[].obs;
  var userAlertResonse = UserAlertResonse().obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // set alerts
    // retrieve alerts from storage
    UserAlertResonse? _usrAlrtRs =
        await localStorageServices.getUserAlertResonse();
    paymentAlertList.value =
        _usrAlrtRs?.outgoingAlerts?.outgoingAlertsData ?? [];
    walletAlertList.value =
        _usrAlrtRs?.incomingAlerts?.incomingAlertsData ?? [];

    updateAlerts();
  }

  void updateAlerts() async {
    try {
      var api = AlertsApi();
      ResponseModel res = await api.getAlerts();

      if (res.status == true) {
        UserAlertResonse _usrAlrtRs = UserAlertResonse.fromMap(res.data!);
        paymentAlertList.value =
            _usrAlrtRs.outgoingAlerts?.outgoingAlertsData ?? [];
        walletAlertList.value =
            _usrAlrtRs.incomingAlerts?.incomingAlertsData ?? [];
        // log(_usrAlrtRs.toJson());
        // save to storage
        localStorageServices.saveUserAlertResonse(_usrAlrtRs);
      } else {
        Snackbar.errSnackBar('Could not fetch your alerts',
            res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar(
          'Could not fetch your alerts', RestApiServices.errMessage);
    }
  }

  void viewInititalizedTransaction(
      {required AlertTagType alertTagType,
      required int? alertId,
      required int alertIndex,
      InitializedTransaction? initializedTransaction}) {
    // set the default initialized transaction page data to storage

    if (alertTagType == AlertTagType.PAYMENT) {
      initializedTransaction?.createdAt =
          paymentAlertList[alertIndex]?.createdAt;
    } else {
      initializedTransaction?.createdAt =
          walletAlertList[alertIndex]?.createdAt;
    }

    var initializedTransactionB64 = InitializedTransactionB64.fromMap({
      "alert_tag_type": alertTagType,
      "alert_td": alertId,
      "initialized_transaction": initializedTransaction?.toMap(),
    });
    localStorageServices.saveInitializedTransactionB64(
        initializedTransactionB64: initializedTransactionB64);
    // redirect to the initialized transaction page
    Get.offNamed(Routes.initialized_transaction_no_id);

    // simulate url
    // var id = (initializedTransaction?.id) ?? 0;
    // var b64Url = '{"id": $id}';
    // var b64UrlStr = B64Encoder.base64UrlEncode(b64Url);
    // Get.offNamed("/initialized-transaction/$b64UrlStr");
  }
}
