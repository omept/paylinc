import 'package:get/get_connect.dart';

class BaseRequest extends GetConnect {
  @override
  void onInit() {
    // All request will pass to jsonEncode so CasesModel.fromJson()
    // httpClient.defaultDecoder = CasesModel.fromJson;
    httpClient.baseUrl = 'https://api.covid19api.com';
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = Duration(seconds: 8);
    httpClient.addResponseModifier((request, response) async {
      print(response.body);
    });
    super.onInit();
  }
}

class UserApi extends BaseRequest {
  Future<Response> login(Map data) async => post('/sign-in', data);
}
