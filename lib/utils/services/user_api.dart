part of "rest_api_services.dart";

class UserApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;

  UserApi.withAuthRepository(AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  @override
  void onInit() {
    super.onInit();
  }

  Future<ResponseModel> login(Map data) async {
    try {
      final String loginUrl = "auth/login/";
      final response =
          await post(loginUrl, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: UserApi.errMessage);
    }
  }
}
