part of create_wallet;

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

  void createWallet() async {
    _status.value = FormzStatus.submissionInProgress;
    try {
      WalletsApi walletsApi = WalletsApi.withAuthRepository(
          authController.authenticationRepository);
      var res = await walletsApi.createWallet({
        'wallet_paytag': paytag.value,
        'supported_category_id': _selectedCatValue
      });

      if (res.status == true) {
        _status.value = FormzStatus.submissionSuccess;
        List<Wallet> wallets = List<Wallet>.from(
            res.data?['wallets']?.map((x) => Wallet.fromMap(x)));
        authController.updateUserWallets(wallets);
        Snackbar.successSnackBar('Successful', "vendor wallet created");
        Get.offNamed(Routes.wallets);
      } else {
        _status.value = FormzStatus.submissionFailure;

        Snackbar.errSnackBar(
            'Failed', res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      Snackbar.errSnackBar('Network error', RestApiServices.errMessage);
    }
  }
}
