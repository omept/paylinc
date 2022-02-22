part of "rest_api_services.dart";

class UserApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;

  UserApi.withAuthRepository(AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  Future<ResponseModel> login(Map<String, String> data) async {
    return makePost(data: data, url: "auth/login");
  }

  Future<ResponseModel> isPaytagUsable(Map<String, String> data) async {
    return makePost(data: data, url: "auth/validate-paytag");
  }

  Future<ResponseModel> isPaytagAvailable(Map<String, String> data) async {
    return makePost(data: data, url: "auth/paytag-availability");
  }

  Future<ResponseModel> signUp(Map<String, String> data) async {
    return makePost(data: data, url: "auth/sign-up");
  }

  Future<ResponseModel> validateOtp(Map<String, String> data) async {
    return makePost(data: data, url: "auth/confirm-otp");
  }

  Future<ResponseModel> sendforgotPasswordLink(Map<String, String> data) async {
    return makePost(data: data, url: "auth/send-password-reset-link");
  }

  Future<ResponseModel> confirmForgotPassword(Map<String, String> data) async {
    return makePost(data: data, url: "auth/reset-password");
  }

  Future<ResponseModel> resendOtp() async {
    return makePost(url: "auth/resend-otp");
  }

  Future<ResponseModel> authUser(Map<String, String> data) async {
    return makePost(data: data, url: "auth/user");
  }

  // Future<ResponseModel> makePost(Map<String, dynamic>? data, url) async {
  //   try {
  //     var response = await post(url, data, headers: this.requestHeader());
  //     return this.responseHandler(response);
  //   } on Exception catch (_) {
  //     return ResponseModel(message: WalletsApi.errMessage);
  //   }
  // }
}
