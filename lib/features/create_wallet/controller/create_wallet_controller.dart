import 'package:awesome_select/awesome_select.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/shared_components/models/supported_category.dart';
import 'package:paylinc/utils/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

class CreateWalletController extends GetxController {
  var _status = FormzStatus.pure.obs;
  AuthController authController = Get.find<AuthController>();

  FormzStatus get status => _status.value;
  set status(val) => _status.value = val;

  String _selectedCatValue = '';
  String get selectedCatValue => _selectedCatValue;

  set selectedCatValue(value) => _selectedCatValue = value;

  var paytagUsageMessage = ''.obs;

  var paytag = ''.obs;
  updatePaytag(String val) async {
    paytag.value = val;

    try {
      SettingsApi settingsApi = SettingsApi.withAuthRepository(
          authController.authenticationRepository);
      var res = await settingsApi.isWalletPaytagUsable({'wallet_paytag': val});

      paytagUsageMessage.value = res.message?.toLowerCase() ?? "checking ...";
    } on Exception catch (_) {
      paytagUsageMessage.value = "network problem";
    }
  }

  var categoryOptions =
      <S2Choice<String>>[S2Choice<String>(value: '', title: 'Select one')].obs;

  @override
  void onInit() async {
    super.onInit();

    categoryOptions.value = await fetchOptions;
  }

  Future<List<S2Choice<String>>> get fetchOptions async {
    List<S2Choice<String>> s2Choices = [];

    var settingsApi = SettingsApi();
    ResponseModel supCatRes = await settingsApi.supportedCategories();

    if (supCatRes.status == true) {
      List<SupportedCategory> supCatList = List<SupportedCategory>.from(
          supCatRes.data?['supported_categories']
              ?.map((x) => SupportedCategory?.fromMap(x)));

      s2Choices = List<S2Choice<String>>.from(supCatList
          .map((e) => S2Choice<String>(value: e.value, title: e.title)));
    } else {
      Snackbar.errSnackBar(
          'Network error', supCatRes.message ?? RestApiServices.errMessage);
    }

    return s2Choices;
  }

  void createWallet() {
    _status.value = FormzStatus.submissionInProgress;
  }
}
