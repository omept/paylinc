part of send_money;

class SendMoneyFlow extends StatefulWidget {
  SendMoneyFlow({Key? key}) : super(key: key);

  @override
  _SendMoneyFlowState createState() => _SendMoneyFlowState();
}

class _SendMoneyFlowState extends State<SendMoneyFlow> {
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final kTitleStyle = TextStyle(
    fontFamily: 'CM Sans Serif',
    fontSize: 26.0,
    height: 1.5,
  );

  kSubtitleStyle(themeContext) => TextStyle(
        color: themeContext?.textTheme?.caption?.color,
        fontSize: 13.0,
        height: 1.2,
      );

  kReviewHeaderStyle(ThemeData themeContext) =>
      TextStyle(color: themeContext.textTheme.caption?.color, fontSize: 18.0);
  kReviewSubHeaderFaintStyle(ThemeData themeContext) =>
      TextStyle(color: themeContext.textTheme.caption?.color, fontSize: 15);
  kReviewSubHeaderStyle(ThemeData themeContext, {bool withBold = false}) {
    TextStyle(
      color: themeContext.textTheme.caption?.color,
      fontSize: 28.0,
    );
  }

  kReviewSubHeaderValueStyle(themeContext) => TextStyle(fontSize: 15.0);
  kSelectionStyle(themeContext) =>
      TextStyle(color: themeContext?.textTheme?.caption?.color, fontSize: 15.0);

  List<Widget> _buildPageIndicator(ThemeData themeContext) {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage
          ? _indicator(true, themeContext)
          : _indicator(false, themeContext));
    }
    return list;
  }

  Widget _indicator(bool isActive, ThemeData themeContext) {
    return Builder(builder: (context) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        height: 8.0,
        width: isActive ? 24.0 : 16.0,
        decoration: BoxDecoration(
          color: isActive
              ? themeContext.colorScheme.onBackground
              : themeContext.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var themeContext = Theme.of(context);
    SendMoneyController controller = Get.find<SendMoneyController>();
    return Container(
      height: size.height - 60,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kSpacing * 2, vertical: kSpacing / 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Send Money',
                  style: TextStyle(
                    color: themeContext.textTheme.caption?.color,
                    fontSize: 14.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.offNamed(Routes.dashboard);
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'X',
                        style: TextStyle(
                          color: themeContext.colorScheme.onBackground,
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    _transactionAmountPage(themeContext, controller),
                    _recipientPaytagPage(themeContext, controller),
                    _transactionPurposePage(themeContext, controller),
                    _transactionReviewPage(themeContext, controller, size),
                    _transactionOtpPage(
                        themeContext, controller, _pageController),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(themeContext),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage == 0
                    ? Container()
                    : Container(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_back,
                                  color: themeContext.colorScheme.onBackground,
                                  size: 30.0,
                                ),
                                SizedBox(width: 10.0)
                              ],
                            ),
                          ),
                        ),
                      ),
                _currentPage == _numPages - 2
                    ? Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Obx(() {
                                return TextButton(
                                  child: controller
                                          .status.isSubmissionInProgress
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              const CircularProgressIndicator(),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Accept',
                                              style: TextStyle(
                                                color: themeContext
                                                    .colorScheme.onBackground,
                                                fontSize: 22.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                  onPressed: () {
                                    if (controller.status.isSubmissionSuccess) {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                _currentPage < _numPages - 2
                    ? Container(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: themeContext.colorScheme.onBackground,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _recipientPaytagPage(ThemeData themeContext, SendMoneyController c) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 150.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Wallet Paytag",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'enter the vendor paytag you want to send money to.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: _RWalletPaytagInput()),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _transactionAmountPage(ThemeData themeContext, SendMoneyController c) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 120.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Amount",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Enter the amount you want to send.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: _AmountInput(),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _transactionPurposePage(
      ThemeData themeContext, SendMoneyController c) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 120.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Purpose",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Enter a description for the transaction.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: _PurposeInputField(),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _transactionOtpPage(ThemeData themeContext, SendMoneyController c,
      PageController pageController) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 120.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "OTP",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Enter your transaction otp.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: _TransferPinInput(pageController: pageController),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _transactionReviewPage(
      ThemeData themeContext, SendMoneyController c, Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: size.width,
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: kSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Review",
                      style: kTitleStyle,
                    ),
                    SizedBox(height: 15.0),
                    !c.status.isSubmissionSuccess
                        ? Expanded(
                            child: Container(
                            height: 300,
                            child: Center(child: CircularProgressIndicator()),
                          ))
                        : Expanded(
                            child: Card(
                            color: themeContext.cardColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Transaction',
                                          style:
                                              kReviewHeaderStyle(themeContext),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ),
                                  // Sender
                                  Container(
                                    width: size.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sender',
                                          style: kReviewSubHeaderFaintStyle(
                                              themeContext),
                                        ),
                                        SizedBox(
                                          width: kSpacing,
                                        ),
                                        Obx(() {
                                          return Text(
                                            '@${c.reviewSend.value.sender?.paytag}',
                                            style: kReviewSubHeaderValueStyle(
                                                themeContext),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ),
                                  // Recipient
                                  Container(
                                    width: size.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Recipient',
                                          style: kReviewSubHeaderFaintStyle(
                                              themeContext),
                                        ),
                                        Obx(() {
                                          return Text(
                                            '@${c.reviewSend.value.recipient?.paytag}',
                                            style: kReviewSubHeaderValueStyle(
                                                themeContext),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ), // Recipient
                                  Container(
                                    width: size.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Recipient Wallet',
                                          style: kReviewSubHeaderFaintStyle(
                                              themeContext),
                                        ),
                                        Obx(() {
                                          return Text(
                                            '@${c.selectedWalletValue.value}',
                                            style: kReviewSubHeaderValueStyle(
                                                themeContext),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ),
                                  // Purpost
                                  Container(
                                    width: size.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Purpose',
                                          style: kReviewSubHeaderFaintStyle(
                                              themeContext),
                                        ),
                                        Obx(() {
                                          return Text(
                                            '${c.purpose.value}',
                                            style: kReviewSubHeaderValueStyle(
                                                themeContext),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ),
                                  // Recipient
                                  Container(
                                    width: size.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Amount',
                                            style: kReviewSubHeaderFaintStyle(
                                                themeContext),
                                          ),
                                        ),
                                        SizedBox(
                                          width: kSpacing,
                                        ),
                                        Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Obx(() {
                                              return Text(
                                                  '${c.reviewSend.value.amount?.intHumanFormat()}',
                                                  style:
                                                      kReviewSubHeaderValueStyle(
                                                          themeContext));
                                            }),
                                            Obx(() {
                                              return Text(
                                                '${c.reviewSend.value.recipient?.country?.currencyAbr} ',
                                                style:
                                                    kReviewSubHeaderValueStyle(
                                                        themeContext),
                                              );
                                            }),
                                          ],
                                        ),
                                        SizedBox(
                                          height: kSpacing,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                  ],
                ),
              ),
            ),
            // ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}

class _AmountInput extends StatefulWidget {
  @override
  State<_AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<_AmountInput> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    SendMoneyController controller = Get.find<SendMoneyController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Obx(() {
          return TextFormField(
            keyboardType: TextInputType.number,
            initialValue: controller.amount.value,
            onChanged: (amount) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                controller.updateAmount(amount);
              });
            },
            decoration: InputDecoration(
              labelText: 'Amount',
              errorStyle: TextStyle(color: kDangerColor),
              errorText: controller.amount.value.isEmpty ||
                      !canBeInteger(controller.amount.value)
                  ? 'invalid amount'
                  : null,
            ),
          );
        })
      ],
    );
  }
}

class _PurposeInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SendMoneyController controller = Get.find<SendMoneyController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Obx(() {
          return TextFormField(
            initialValue: controller.purpose.value,
            onChanged: (purpose) {
              controller.updatePurpose(purpose);
            },
            decoration: InputDecoration(
              labelText: 'Purpose',
              errorStyle: TextStyle(color: kDangerColor),
              errorText: null,
            ),
          );
        })
      ],
    );
  }
}

class _TransferPinInput extends StatefulWidget {
  final PageController pageController;

  const _TransferPinInput({Key? key, required this.pageController})
      : super(key: key);
  @override
  State<_TransferPinInput> createState() => _TransferPinInputState();
}

class _TransferPinInputState extends State<_TransferPinInput> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();
  SendMoneyController controller = Get.find<SendMoneyController>();

  String currentText = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      obscureText: true,
      animationType: AnimationType.fade,
      animationDuration: Duration(milliseconds: 300),
      errorAnimationController: errorController,
      keyboardType: TextInputType.number,
      controller: textEditingController,
      onChanged: (value) {
        if (canBeInteger(value) && (value.length > 0)) {
          controller.updateOtp(value);
        }
      },
      beforeTextPaste: (text) => canBeInteger(text ?? ''),
      onCompleted: (value) {
        controller.submitSendMoney();
      },
    );
  }
}

class _RWalletPaytagInput extends StatefulWidget {
  @override
  State<_RWalletPaytagInput> createState() => _RWalletPaytagInputState();
}

class _RWalletPaytagInputState extends State<_RWalletPaytagInput> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    SendMoneyController controller = Get.find<SendMoneyController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Obx(() {
          return TextFormField(
            initialValue: controller.selectedWalletValue.value,
            onChanged: (paytag) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                controller.updateRWalletPaytag(paytag);
              });
            },
            decoration: InputDecoration(
              labelText: 'Paytag',
              errorStyle: TextStyle(color: kDangerColor),
              errorText: controller.rWalletPaytagUsageMessage.value.isEmpty
                  ? 'invalid paytag'
                  : null,
            ),
          );
        }),
        Obx(() {
          return controller.rWalletPaytagUsageMessage.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    controller.rWalletPaytagUsageMessage.value,
                    style: _paytagMessageStyle(
                        controller.rWalletPaytagUsageMessage.value),
                  ),
                )
              : Container();
        })
      ],
    );
  }

  TextStyle? _paytagMessageStyle(String mes) {
    if (mes == "") {
      return null;
    }

    if (mes == "valid") {
      return TextStyle(color: kNotifColor);
    } else if (mes == "checking . . .") {
      return TextStyle(color: kNotifColor);
    } else {
      return TextStyle(color: Theme.of(Get.context!).errorColor);
    }
  }
}
