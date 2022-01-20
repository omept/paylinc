part of user_alerts;

class UserAlertsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  LocalStorageServices localStorageServices = Get.find();
  var walletAlertList = <WalletAlert?>[].obs;
  var paymentAlertList = <PaymentAlert?>[].obs;
  var userAlertList = <UserAlert?>[].obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void onInit() {
    super.onInit();
    // set alerts
    updateAlerts();
  }

  void updateAlerts() async {
    try {
      var api = AlertsApi();
      ResponseModel res = await api.getAlerts();

      if (res.status == true) {
        UserAlertResonse userAlertResonse =
            UserAlertResonse.fromJson(res.data!);

        // UserAlert _userAlrt = await localStorageServices
        //     .saveUserAlertsFromMap(res.data?['user_alerts']);

        // userAlertList.value = _userAlrt;
      } else {
        Snackbar.errSnackBar(
            'Failed getting alerts', res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar('Failed getting alerts', RestApiServices.errMessage);
    }
  }
}
