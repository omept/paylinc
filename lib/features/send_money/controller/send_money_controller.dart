part of send_money;

class SendMoneyController extends GetxController {
  final Rx<FormzStatus> status = FormzStatus.pure.obs;
  AuthController authController = Get.find<AuthController>();

  static final defaultWalletChoice =
      S2Choice<String>(value: '', title: 'Select one');
  var walletOptions = <S2Choice<String>>[defaultWalletChoice].obs;
  var selectedWalletValue = "".obs;

  var amount = ''.obs;
  var transferPin = ''.obs;
  var purpose = ''.obs;
  var rWalletPaytagUsageMessage = ''.obs;
  var reviewSend = ReviewRequest().obs;

  @override
  void onInit() async {
    super.onInit();
    walletOptions.value = await fetchOptions;
  }

  updateAmount(String val) {
    amount.value = val;
    preSendMoneyReview();
  }

  Future<List<S2Choice<String>>> get fetchOptions async {
    List<S2Choice<String>> s2Choices = [];

    var wallets = authController.user.value.wallets;
    if (wallets?.isNotEmpty ?? false) {
      s2Choices = List<S2Choice<String>>.from(wallets!.map((e) =>
          S2Choice<String>(
              value: e!.walletPaytag ?? '', title: "@${(e.walletPaytag)}")));
    } else {
      s2Choices = [defaultWalletChoice];
    }

    return s2Choices;
  }

  void updatePurpose(String mes) {
    purpose.value = mes;
    // preSendMoneyReview();
  }

  void updateOtp(String pin) {
    transferPin.value = pin;
  }

  void updateRWalletPaytag(String val) async {
    selectedWalletValue.value = val;
    try {
      rWalletPaytagUsageMessage.value = "checking ...";

      var api = WalletsApi.withAuthRepository(
          authController.authenticationRepository);
      var res = await api.checkWalletPaytagExistance({
        'wallet_paytag': val,
      });
      if (res.status == true) {
        rWalletPaytagUsageMessage.value =
            retrieveMessage(res.message!.toLowerCase());
        preSendMoneyReview();
      } else {
        rWalletPaytagUsageMessage.value =
            retrieveMessage('', defaultMessage: WalletsApi.errMessage);
      }
    } on Exception catch (_) {
      rWalletPaytagUsageMessage.value = "network problem";
    }
  }

  String retrieveMessage(String key, {String defaultMessage = ''}) {
    try {
      var pVM = {
        'wallet paytag exists.': "valid",
        'wallet paytag does not exist.': "invalid"
      };
      return pVM[key] != null ? pVM[key].toString() : defaultMessage;
    } on Exception catch (_) {
      return defaultMessage;
    }
  }

  Future<void> preSendMoneyReview() async {
    try {
      if (amount.value.isEmpty ||
          (amount.value.isNotEmpty && !canBeInteger(amount.value)) ||
          // purpose.value.isEmpty ||
          rWalletPaytagUsageMessage.value != 'valid' ||
          selectedWalletValue.isEmpty) {
        status.value = FormzStatus.submissionInProgress;
        return;
      }
      status.value = FormzStatus.submissionInProgress;
      WalletsApi walletsApi = WalletsApi.withAuthRepository(
          authController.authenticationRepository);
      var res = await walletsApi.preSendMoney({
        "country_id":
            authController.user.value.country?.countryId.toString() ?? '',
        'paytag': reviewSend.value.sender?.paytag ?? '',
        'wallet_paytag': selectedWalletValue.value,
        'amount': amount.value.replaceAll(",", ""),
        'transfer_pin': transferPin.value,
        'purpose': purpose.value,
      });
      if (res.status == true) {
        status.value = FormzStatus.submissionSuccess;
        var resFormat = {'transaction': res.data!};
        reviewSend.value = ReviewRequest.fromMap(resFormat['transaction']!);
      } else {
        status.value = FormzStatus.submissionFailure;
        res.message?.trim().isEmpty;
        var errMs = res.message ?? '';
        Snackbar.errSnackBar('Could not load review', errMs);
      }
    } on Exception catch (_) {
      status.value = FormzStatus.submissionFailure;
    }
  }

  Future<void> submitSendMoney() async {
    try {
      status.value = FormzStatus.submissionInProgress;

      WalletsApi walletsApi = WalletsApi.withAuthRepository(
          authController.authenticationRepository);
      var data = {
        "country_id":
            authController.user.value.country?.countryId.toString() ?? '',
        'paytag': reviewSend.value.sender?.paytag ?? '',
        'wallet_paytag': selectedWalletValue.value,
        'amount': amount.value.replaceAll(",", ""),
        'transfer_pin': transferPin.value,
        'purpose': purpose.value,
      };
      var res = await walletsApi.sendMoney(data);

      if (res.status == true) {
        Snackbar.successSnackBar('Successful', res.message ?? '');
        status.value = FormzStatus.submissionSuccess;
        Get.offNamed(Routes.dashboard);
      } else {
        Snackbar.errSnackBar(
            'Failed', res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      rWalletPaytagUsageMessage.value = "network problem";
      status.value = FormzStatus.submissionFailure;
    }
  }
}
