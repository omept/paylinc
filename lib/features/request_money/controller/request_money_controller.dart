part of request_money;

class RequestMoneyController extends GetxController {
  final Rx<FormzStatus> _status = FormzStatus.pure.obs;
  FormzStatus get status => _status.value;
  AuthController authController = Get.find<AuthController>();

  static final defaultWalletChoice =
      S2Choice<String>(value: '', title: 'Select one');
  var walletOptions = <S2Choice<String>>[defaultWalletChoice].obs;
  String selectedWalletValue = "";

  var sender = ''.obs;
  var amount = ''.obs;
  var transferPin = ''.obs;
  var purpose = ''.obs;
  var senderPaytagUsageMessage = ''.obs;
  var reviewRequest = ReviewRequest().obs;

  @override
  void onInit() async {
    super.onInit();
    walletOptions.value = await fetchOptions;
  }

  updateAmount(String val) {
    amount.value = val;
    preRequestMoneyReview();
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

  updateSelectedWallet(String? value) {
    selectedWalletValue = value ?? '';
    preRequestMoneyReview();
  }

  void updatePurpose(String mes) {
    purpose.value = mes;
    // preRequestMoneyReview();
  }

  void updateOtp(String pin) {
    transferPin.value = pin;
  }

  void updateSenderPaytag(String val) async {
    sender.value = val;

    try {
      senderPaytagUsageMessage.value = "checking ...";

      var api =
          UserApi.withAuthRepository(authController.authenticationRepository);
      var res = await api.isPaytagAvailable({
        'paytag': val,
      });

      if (res.status == true) {
        senderPaytagUsageMessage.value =
            retrieveMessage(res.message!.toLowerCase());
        preRequestMoneyReview();
      } else {
        senderPaytagUsageMessage.value =
            retrieveMessage('', defaultMessage: WalletsApi.errMessage);
      }
    } on Exception catch (_) {
      senderPaytagUsageMessage.value = "network problem";
    }
  }

  String retrieveMessage(String key, {String defaultMessage = ''}) {
    try {
      var pVM = {'bad paytag': "invalid", 'good paytag': "valid"};
      return pVM[key] != null ? pVM[key].toString() : defaultMessage;
    } on Exception catch (_) {
      return defaultMessage;
    }
  }

  Future<void> preRequestMoneyReview() async {
    try {
      if (amount.value.isEmpty ||
          (amount.value.isNotEmpty && !canBeInteger(amount.value)) ||
          // purpose.value.isEmpty ||
          senderPaytagUsageMessage.value != "valid" ||
          sender.value.isEmpty ||
          selectedWalletValue.isEmpty) {
        _status.value = FormzStatus.submissionInProgress;
        return;
      }
      _status.value = FormzStatus.submissionInProgress;
      WalletsApi walletsApi = WalletsApi.withAuthRepository(
          authController.authenticationRepository);
      var res = await walletsApi.preRequestMoney({
        'paytag': sender.value,
        "country_id":
            authController.user.value.country?.countryId.toString() ?? '',
        'wallet_paytag': selectedWalletValue,
        'amount': amount.value,
        'transfer_pin': transferPin.value,
        'purpose': purpose.value,
      });
      if (res.status == true) {
        _status.value = FormzStatus.submissionSuccess;
        var resFormat = {'transaction': res.data!};
        reviewRequest.value = ReviewRequest.fromMap(resFormat['transaction']!);
      } else {
        _status.value = FormzStatus.submissionFailure;
        res.message?.trim().isEmpty;
        var errMs = res.message ?? '';
        Snackbar.errSnackBar('Could not load review', errMs);
      }
    } on Exception catch (_) {
      _status.value = FormzStatus.submissionFailure;
    }
  }

  Future<void> submitRequestMoney() async {
    try {
      _status.value = FormzStatus.submissionInProgress;
      WalletsApi walletsApi = WalletsApi.withAuthRepository(
          authController.authenticationRepository);
      var data = {
        'paytag': sender.value,
        "country_id":
            authController.user.value.country?.countryId.toString() ?? '',
        'wallet_paytag': selectedWalletValue,
        'amount': amount.value,
        'transfer_pin': transferPin.value,
        'purpose': purpose.value,
      };
      var res = await walletsApi.requestMoney(data);
      if (res.status == true) {
        Snackbar.successSnackBar('Successful', res.message ?? '');
        _status.value = FormzStatus.submissionSuccess;
        Get.offNamed(Routes.dashboard);
      } else {
        Snackbar.errSnackBar(
            'Failed', res.message ?? RestApiServices.errMessage);
      }
    } on Exception catch (_) {
      senderPaytagUsageMessage.value = "network problem";
    }
  }
}
