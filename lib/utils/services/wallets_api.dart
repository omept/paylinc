part of "rest_api_services.dart";

class WalletsApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;
  WalletsApi();
  WalletsApi.withAuthRepository(
      AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  Future<ResponseModel> preSendMoney(Map<String, String> data) async {
    return await makePost(data: data, url: "transactions/pre-send-money");
  }

  Future<ResponseModel> preRequestMoney(Map<String, String> data) async {
    return await makePost(data: data, url: "transactions/pre-request-money");
  }

  Future<ResponseModel> isWalletPaytagUsable(Map<String, String> data) async {
    return await makePost(data: data, url: "wallet/validate-wallet-paytag");
  }

  Future<ResponseModel> checkWalletPaytagExistance(
      Map<String, String> data) async {
    return await makePost(
        data: data, url: "wallet/check-wallet-paytag-existance");
  }

  Future<ResponseModel> getWalletLogs(Map<String, String> data) async {
    return await makePost(data: data, url: "wallet/logs");
  }

  Future<ResponseModel> getStashLogs() async {
    return await makePost(url: "stash/logs");
  }

  Future<ResponseModel> createWallet(Map<String, String> data) async {
    return await makePost(data: data, url: "wallet/create");
  }

  Future<ResponseModel> requestMoney(Map<String, String> data) async {
    return await makePost(data: data, url: "transactions/request-money");
  }

  Future<ResponseModel> sendMoney(Map<String, String> data) async {
    return await makePost(data: data, url: "transactions/send-money");
  }

  Future<ResponseModel> walletTransferToBank(Map<String, String> data) async {
    return await makePost(data: data, url: "wallet/transfer-to-bank");
  }

  Future<ResponseModel> stashTransferToBank(Map<String, String> data) async {
    return await makePost(data: data, url: "stash/transfer-to-bank");
  }

  Future<ResponseModel> walletTransferToStash(Map<String, String> data) async {
    return await makePost(data: data, url: "wallet/transfer-to-stash");
  }

  Future<ResponseModel> deleteBank(Map<String, String> data) async {
    return await makePost(data: data, url: "delete-user-bank");
  }

  Future<ResponseModel> resolveAcctName(Map<String, String> data) async {
    return await makePost(data: data, url: "verify-user-bank-account");
  }

  Future<ResponseModel> saveUserBank(Map<String, String> data) async {
    return await makePost(data: data, url: "add-user-bank");
  }
}
