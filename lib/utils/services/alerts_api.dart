part of "rest_api_services.dart";

class AlertsApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;

  AlertsApi();

  AlertsApi.withAuthRepository(
      AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  Future<ResponseModel> getAlerts() async {
    return await makePost(
      url: "get-alerts",
    );
  }
}
