part of "rest_api_services.dart";

class SettingsApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;
  SettingsApi();
  SettingsApi.withAuthRepository(
      AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  Future<ResponseModel> supportedCategories() async {
    return await makeGet(url: "settings/supported-categories");
  }
}
