import 'package:awesome_select/awesome_select.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/shared_components/models/supported_category.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

class CreateWalletController extends GetxController {
  FormzStatus _status = FormzStatus.pure;

  FormzStatus get status => _status;

  String _selectedCatValue = '';
  String get selectedCatValue => _selectedCatValue;
  set selectedCatValue(value) => _selectedCatValue = value;

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
}
