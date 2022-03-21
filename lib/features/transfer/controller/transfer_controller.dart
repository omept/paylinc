part of transfer;

class TransferController extends GetxController {
  final Rx<FormzStatus> _status = FormzStatus.pure.obs;
  FormzStatus get status => _status.value;
  AuthController authController = Get.find<AuthController>();

  static final defaultWalletChoice =
      S2Choice<String>(value: '', title: 'Select one');
  var walletOptions = <S2Choice<String>>[defaultWalletChoice].obs;
  var selectedWalletValue = "".obs;

  @override
  void onInit() async {
    super.onInit();
    walletOptions.value = await fetchOptions;
  }

  Future<List<S2Choice<String>>> get fetchOptions async {
    List<S2Choice<String>> s2Choices = [];

    var wallets = authController.user.wallets;
    if (wallets?.isNotEmpty ?? false) {
      s2Choices = List<S2Choice<String>>.from(wallets!.map((e) =>
          S2Choice<String>(
              value: e!.walletPaytag ?? '', title: "@${(e.walletPaytag)}")));
    } else {
      s2Choices = [defaultWalletChoice];
    }

    return s2Choices;
  }
}
