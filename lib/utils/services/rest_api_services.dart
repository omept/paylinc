import 'package:authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:paylinc/shared_components/models/response_model.dart';

/// contains all service to get data from Server
class RestApiServices extends GetConnect {
  final String baseUrl = 'https://paylinc.test/api/';
  AuthenticationRepository? authenticationRepository;

  RestApiServices();
  RestApiServices.withAuthRepository(this.authenticationRepository);

  dynamic responseHandler(Response<dynamic> response) {
    ResponseModel responseModel;
    if (response.status.hasError) {
      if (response.body != null) {
        // handle backend errors
        // 401 -- auth error response
        // 400 -- problem response
        // 500 -- server response

        responseModel = ResponseModel(
          data: response.body['data'],
          message: response.body['message'],
          status: response.body['status'],
          statusCode: response.body['status-code'],
        );
        switch (responseModel.statusCode) {
          case 400:
            break;
          case 401:
            if (responseModel.message == "Account is not yet verified.") {
              this.authenticationRepository?.onboardingReqAcctVerification();
              // } else if (responseModel.message == "Invalid credentials") {
            } else if (responseModel.message == "Expired Session" ||
                responseModel.message == "Invalid Token") {
              this.authenticationRepository?.onboardingReqLogin();
            }
            break;
          case 500:
            break;
          default:
        }
        return responseModel;
      } else {
        return ResponseModel();
      }
    } else {
      // handle successful response
      responseModel = ResponseModel.fromJson(response.body.toString());
      return responseModel;
    }
  }

  Map<String, String> requestHeader() => {'Access-Control-Allow-Origin': '*'};

  @override
  void onInit() {
    httpClient.baseUrl = 'https://paylinc.test/api/';
    httpClient.defaultContentType = "application/json";
    super.onInit();
  }
  // to get data from server, you can use Http for simple feature
  // or Dio for more complex feature

  // Example:
  // Future<ProductDetail?> getProductDetail(int id)async{
  //   var uri = Uri.parse(ApiPath.product + "/$id");
  //   try {
  //     return await Dio().getUri(uri);
  //   } on DioError catch (e) {
  //     print(e);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}

class UserApi extends RestApiServices {
  UserApi.withAuthRepository(AuthenticationRepository authenticationRepository)
      : super.withAuthRepository(authenticationRepository);

  @override
  void onInit() {
    super.onInit();
  }

  Future<dynamic> login(Map data) async {
    try {
      final String loginUrl = "auth/login/";
      final response = await post(loginUrl, data, headers: requestHeader());
      return this.responseHandler(response);
    } on Exception catch (_) {
      return false;
    }
  }
}
