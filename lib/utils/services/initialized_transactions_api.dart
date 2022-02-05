part of "rest_api_services.dart";

class InitializedTransactionsApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;

  InitializedTransactionsApi();

  InitializedTransactionsApi.withAuthRepository(
      AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  @override
  void onInit() {
    super.onInit();
  }

  Future<ResponseModel> getInitializedTransaction(
      Map<String, dynamic> data) async {
    return await makePost(data, "get-initiated-transaction");
  }

  Future<ResponseModel> acceptTransaction(Map<String, dynamic> data) async {
    return await makePost(data, "accept-transaction");
  }

  Future<ResponseModel> terminateTransaction(Map<String, dynamic> data) async {
    return await makePost(data, "cancel-transaction");
  }

  Future<ResponseModel> declineTransaction(Map<String, dynamic> data) async {
    return await makePost(data, "decline-transaction");
  }

  confirmCompletTransaction(Map<String, dynamic> map) async {
    return await makePost(map, "sender-confirm-transaction-completion");
  }

  setAsConflictTransaction(Map<String, dynamic> map) async {
    return await makePost(map, "mark-transaction-as-conflict");
  }

  completTransaction(Map<String, dynamic> map) async {
    return await makePost(map, "mark-transaction-as-completed");
  }

  refundTransaction(Map<String, dynamic> map) async {
    return await makePost(map, "refund-transaction-request");
  }

  Future<ResponseModel> makePost(Map<String, dynamic> data, url) async {
    try {
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: InitializedTransactionsApi.errMessage);
    }
  }
}
