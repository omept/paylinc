part of transfer;

enum TransferOrigin { stash, wallet }

class TransferController extends GetxController {
  final Rx<FormzStatus> _status = FormzStatus.pure.obs;
  FormzStatus get status => _status.value;
  AuthController authController = Get.find<AuthController>();

  static var defaultWalletChoice =
      S2Choice<String>(value: '', title: 'Select one');
  var walletOptions = <S2Choice<String>>[defaultWalletChoice].obs;
  var purpose = "".obs;
  var amount = 0.obs;
  var transferPin = "".obs;
  var acctNumber = "".obs;
  var sUBank = UserBank().obs; // selected user bank
  RxList<UserBank?> uBanksList = <UserBank?>[].obs;

  var transferOrigin = TransferOrigin.stash.obs; // stash or wallet
  Rx<Wallet?> selectedWallet = Wallet().obs; // specific wallet to transfer from
  List<Wallet?>? wallets;
  Map<String, double> paytagBals = {};

  @override
  void onInit() async {
    super.onInit();
    wallets = authController.user.value.wallets;
    uBanksList.value = defaultBankList();
    walletOptions.value = await fetchWalltOptns;

    transferOrigin.value =
        evalTransferOrigin(Get.parameters['transferOrigin']?.toString() ?? '');
    var selectedWllt = Get.parameters['selectedWallet']?.toString() ?? '';
    selectedWallet.value = getWalletFromPaytag(selectedWllt);

    if (wallets != null && wallets?.isNotEmpty == true) {
      for (var w in wallets!) {
        paytagBals["${w?.walletPaytag}"] = w?.balance ?? 0;
      }
    }
  }

  TransferOrigin evalTransferOrigin(String val) {
    switch (val) {
      case 'stash':
        return TransferOrigin.stash;
      case 'wallet':
        return TransferOrigin.wallet;
      default:
        return TransferOrigin.stash;
    }
  }

  Wallet? getWalletFromPaytag(String selectedWllt) =>
      wallets?.firstWhere((element) => element?.walletPaytag == selectedWllt,
          orElse: () => wallets?.first);

  double getWalletPaytagMax(String selectedWllt) =>
      paytagBals[selectedWllt] ?? 0;

  int getStashMax(String selectedWllt) =>
      authController.user.value.stashBalance ?? 0;

  Future<List<S2Choice<String>>> get fetchWalltOptns async {
    List<S2Choice<String>> s2Choices = [];

    if (wallets?.isNotEmpty ?? false) {
      s2Choices = List<S2Choice<String>>.from(wallets!.map((e) =>
          S2Choice<String>(
              value: e!.walletPaytag ?? '', title: "@${(e.walletPaytag)}")));
    } else {
      s2Choices = [defaultWalletChoice];
    }

    return s2Choices;
  }

  void updatePurpose(String mes) => purpose.value = mes;

  void updateAmount(String _amount) => amount.value = _amount.toInt();

  void updateOtp(String pin) => transferPin.value = pin;

  void submitTransferMoney() => print("transfer money");

  List<UserBank?> defaultBankList() {
    return authController.user.value.userBanks ?? [];
  }

  void updateAcountNumber(String acctNum) {
    if (acctNum.isEmpty) {
      uBanksList.value = defaultBankList();
      return;
    }
    // reset selected user bank
    sUBank.value = UserBank();
    acctNumber.value = acctNum;
    var bList = defaultBankList();
    uBanksList.value = bList
        .where((b) => b?.accountNumber?.contains(acctNum) ?? false)
        .toList();
  }

  void selectUBank(UserBank _uBank) {
    sUBank.value = _uBank;
    acctNumber.value = _uBank.accountNumber ?? "";
  }
}
