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

  Future<ResponseModel> isPaytagUsable(Map<String, String> data) async {
    try {
      final String url = "auth/validate-paytag";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: SettingsApi.errMessage);
    }
  }

  Future<ResponseModel> signUp(Map<String, String> data) async {
    try {
      final String url = "auth/sign-up";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: SettingsApi.errMessage);
    }
  }

  Future<ResponseModel> validateOtp(Map<String, String> data) async {
    try {
      final String url = "auth/confirm-otp";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: SettingsApi.errMessage);
    }
  }

  Future<ResponseModel> sendforgotPasswordLink(Map<String, String> data) async {
    try {
      final String url = "auth/send-password-reset-link";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: SettingsApi.errMessage);
    }
  }

  Future<ResponseModel> confirmForgotPassword(Map<String, String> data) async {
    try {
      final String url = "auth/reset-password";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: SettingsApi.errMessage);
    }
  }

  Future<ResponseModel> resendOtp() async {
    try {
      final String url = "auth/resend-otp";
      final response = await post(url, '', headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: SettingsApi.errMessage);
    }
  }
}
