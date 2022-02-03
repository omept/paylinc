part of "rest_api_services.dart";

class WalletsApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;
  WalletsApi();
  WalletsApi.withAuthRepository(
      AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  @override
  void onInit() {
    super.onInit();
  }

  Future<ResponseModel> preSendMoney(Map<String, String> data) async {
    return await makePost(data, "transactions/pre-send-money");
  }

  Future<ResponseModel> preRequestMoney(Map<String, String> data) async {
    return await makePost(data, "transactions/pre-request-money");
  }

  Future<ResponseModel> isWalletPaytagUsable(Map<String, String> data) async {
    return await makePost(data, "wallet/validate-wallet-paytag");
  }

  Future<ResponseModel> checkWalletPaytagExistance(
      Map<String, String> data) async {
    return await makePost(data, "wallet/check-wallet-paytag-existance");
  }

  Future<ResponseModel> createWallet(Map<String, String> data) async {
    return await makePost(data, "wallet/create");
  }

  Future<ResponseModel> requestMoney(Map<String, String> data) async {
    return await makePost(data, "transactions/request-money");
  }

  Future<ResponseModel> sendMoney(Map<String, String> data) async {
    return await makePost(data, "transactions/send-money");
  }

  Future<ResponseModel> makePost(Map<String, dynamic>? data, url) async {
    try {
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: WalletsApi.errMessage);
    }
  }
}
