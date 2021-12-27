part of "rest_api_services.dart";

class SettingsApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;
  SettingsApi();
  SettingsApi.withAuthRepository(
      AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  @override
  void onInit() {
    super.onInit();
  }

  Future<ResponseModel> supportedCategories() async {
    try {
      final String url = "settings/supported-categories";
      final response = await get(url, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: SettingsApi.errMessage);
    }
  }

  Future<ResponseModel> isWalletPaytagUsable(Map<String, String> data) async {
    try {
      final String url = "wallet/validate-wallet-paytag";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: SettingsApi.errMessage);
    }
  }
}
