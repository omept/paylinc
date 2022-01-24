part of "rest_api_services.dart";

class AlertsApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;

  AlertsApi();

  AlertsApi.withAuthRepository(
      AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  @override
  void onInit() {
    super.onInit();
  }

  Future<ResponseModel> getAlerts() async {
    try {
      final String url = "get-alerts";
      final response = await post(url, null, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: WalletsApi.errMessage);
    }
  }
}
