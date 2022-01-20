part of user_alerts;

class UserAlertsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  LocalStorageServices localStorageServices = Get.find();
  var walletAlertList = <IncomingAlertsData>[].obs;
  var paymentAlertList = <OutgoingAlertsData>[].obs;
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

        // save to storage
        localStorageServices.saveUserAlertResonse(_usrAlrtRs);
      } else {
        Snackbar.errSnackBar(
            'Failed getting alerts', res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar('Failed getting alerts', RestApiServices.errMessage);
    }
  }
}
