part of "rest_api_services.dart";

class InitializedTransactionsApi extends RestApiServices {
  static String errMessage = RestApiServices.errMessage;

  InitializedTransactionsApi();

  InitializedTransactionsApi.withAuthRepository(
      AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  Future<ResponseModel> getInitializedTransaction(
      Map<String, dynamic> data) async {
    return await makePost(data: data, url: "get-initiated-transaction");
  }

  Future<ResponseModel> acceptTransaction(Map<String, dynamic> data) async {
    return await makePost(data: data, url: "accept-transaction");
  }

  Future<ResponseModel> terminateTransaction(Map<String, dynamic> data) async {
    return await makePost(data: data, url: "cancel-transaction");
  }

  Future<ResponseModel> declineTransaction(Map<String, dynamic> data) async {
    return await makePost(data: data, url: "decline-transaction");
  }

  confirmCompletTransaction(Map<String, dynamic> map) async {
    return await makePost(
        data: map, url: "sender-confirm-transaction-completion");
  }

  setAsConflictTransaction(Map<String, dynamic> map) async {
    return await makePost(
      data: map,
      url: "mark-transaction-as-conflict",
    );
  }

  completTransaction(Map<String, dynamic> map) async {
    return await makePost(
      data: map,
      url: "mark-transaction-as-completed",
    );
  }

  refundTransaction(Map<String, dynamic> map) async {
    return await makePost(
      data: map,
      url: "refund-transaction-request",
    );
  }

  Future<ResponseModel> getInitializedTransactions() async {
    return await makePost(
      url: "initialized-transactions",
    );
  }
}
