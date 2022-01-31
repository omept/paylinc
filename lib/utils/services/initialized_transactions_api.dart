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
    try {
      final String url = "get-initiated-transaction";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: InitializedTransactionsApi.errMessage);
    }
  }

  Future<ResponseModel> acceptTransaction(Map<String, dynamic> data) async {
    try {
      final String url = "accept-transaction";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: InitializedTransactionsApi.errMessage);
    }
  }

  Future<ResponseModel> declineTransaction(Map<String, dynamic> data) async {
    try {
      final String url = "decline-transaction";
      final response = await post(url, data, headers: this.requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return ResponseModel(message: InitializedTransactionsApi.errMessage);
    }
  }
}
