part of "rest_api_services.dart";

class UserApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;

  UserApi.withAuthRepository(AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  @override
  void onInit() {
    super.onInit();
  }

  Future<ResponseModel> login(Map<String, String> data) async {
    try {
      final String url = "auth/login";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }

  Future<ResponseModel> isPaytagUsable(Map<String, String> data) async {
    try {
      final String url = "auth/validate-paytag";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }

  Future<ResponseModel> isPaytagAvailable(Map<String, String> data) async {
    try {
      final String url = "auth/paytag-availability";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }

  Future<ResponseModel> signUp(Map<String, String> data) async {
    try {
      final String url = "auth/sign-up";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }

  Future<ResponseModel> validateOtp(Map<String, String> data) async {
    try {
      final String url = "auth/confirm-otp";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }

  Future<ResponseModel> sendforgotPasswordLink(Map<String, String> data) async {
    try {
      final String url = "auth/send-password-reset-link";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }

  Future<ResponseModel> confirmForgotPassword(Map<String, String> data) async {
    try {
      final String url = "auth/reset-password";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }

  Future<ResponseModel> resendOtp() async {
    try {
      final String url = "auth/resend-otp";
      final response = await post(url, '', headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }

  Future<ResponseModel> authUser(Map<String, String> data) async {
    try {
      final String url = "auth/user";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }
}