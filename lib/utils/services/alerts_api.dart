part of "rest_api_services.dart";

class AlertsApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;
  AuthenticationRepository _authenticationRepository = Get.find();

  AlertsApi();

  @override
  void onInit() {
    this.authenticationRepository = _authenticationRepository;
    super.onInit();
  }

  Future<ResponseModel> getAlerts() async {
    try {
      final String url = "alerts/get-alerts";
      final response = await post(url, null, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: WalletsApi.errMessage);
    }
  }
}
