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
    try {
      final String url = "transactions/pre-send-money";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: WalletsApi.errMessage);
    }
  }

  Future<ResponseModel> preRequestMoney(Map<String, String> data) async {
    try {
      final String url = "transactions/pre-request-money";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: WalletsApi.errMessage);
    }
  }

  Future<ResponseModel> isWalletPaytagUsable(Map<String, String> data) async {
    try {
      final String url = "wallet/validate-wallet-paytag";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: WalletsApi.errMessage);
    }
  }

  Future<ResponseModel> checkWalletPaytagExistance(
      Map<String, String> data) async {
    try {
      final String url = "wallet/check-wallet-paytag-existance";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: WalletsApi.errMessage);
    }
  }

  Future<ResponseModel> createWallet(Map<String, String> data) async {
    try {
      final String url = "wallet/create";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: WalletsApi.errMessage);
    }
  }

  Future<ResponseModel> requestMoney(Map<String, String> data) async {
    try {
      final String url = "transactions/request-money";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: WalletsApi.errMessage);
    }
  }
}
