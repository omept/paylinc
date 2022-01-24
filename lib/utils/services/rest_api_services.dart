import 'package:authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/utils/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
part 'user_api.dart';
part 'settings_api.dart';
part 'wallets_api.dart';
part 'alerts_api.dart';

/// contains all service to get data from Server
class RestApiServices extends GetConnect {
  final String baseUrl = 'https://paylinc.test/api/';
  AuthenticationRepository? authenticationRepository;
  AuthController authCtrlr = Get.find();

  RestApiServices();

  RestApiServices.withAuthRepository(this.authenticationRepository);

  static const errMessage = "We encountered a problem. Please try again later.";

  Map<String, String> requestHeader() {
    Map<String, String> headers = {'Access-Control-Allow-Origin': '*'};
    String token = authCtrlr.token;
    if (token.isNotEmpty || token.length > 0) {
      headers['AUTHORIZATION'] = 'Bearer ' + token;
      headers['HTTP-AUTHORIZATION'] = 'Bearer ' + token;
    }

    return headers;
  }

  ResponseModel responseHandler(Response<dynamic> response) {
    ResponseModel responseModel;
    responseModel = ResponseModel(
      data: response.body?['data'],
      message: response.body?['message'],
      status: response.body?['status'],
      statusCode: response.body?['status-code'],
    );
    if (response.status.hasError) {
      if (response.body != null) {
        // handle backend errors
        // 401 -- auth error response
        // 400 -- problem response
        // 500 -- server response

        switch (response.status.code) {
          case 400:
            break;
          case 401:
            if (responseModel.message == "Account is not yet verified.") {
              this.authenticationRepository?.onboardingReqAcctVerification();
              // } else if (responseModel.message == "Invalid credentials") {
            } else if (responseModel.message == "Expired Session" ||
                responseModel.message == "Token has expired" ||
                responseModel.message == "Invalid Token") {
              Snackbar.infoSnackBar(
                  responseModel.message ?? RestApiServices.errMessage);
              authCtrlr.logout();
            }
            break;
          case 500:
            break;
          default:
        }
        return responseModel;
      }
      return ResponseModel(
        data: {},
        message: '',
        status: false,
        statusCode: 0,
      );
    }
    return responseModel;
  }

  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;
    httpClient.defaultContentType = "application/json";
    super.onInit();
  }
}
