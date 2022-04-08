part of transfer;

class TransferMoneyFlow extends StatefulWidget {
  TransferMoneyFlow({Key? key}) : super(key: key);

  @override
  _TransferMoneyFlowState createState() => _TransferMoneyFlowState();
}

class _TransferMoneyFlowState extends State<TransferMoneyFlow> {
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
    TransferController controller = Get.find<TransferController>();
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
                  'Transfer Money',
                  style: TextStyle(
                    color: themeContext.textTheme.caption?.color,
                    fontSize: 14.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    String prvRoute = Get.previousRoute;
                    var canGoBack = [
                      Routes.wallets,
                      Routes.viewWallet,
                      Routes.viewStash,
                    ];

                    if (canGoBack.contains(prvRoute)) {
                      Get.offAllNamed(prvRoute);
                    } else {
                      Get.offAllNamed(Routes.wallets);
                    }
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
                    _selectBankPage(themeContext, controller),
                    _transactionAmountPage(themeContext, controller),
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
                              TextButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                if (_currentPage < _numPages - 2)
                  Container(
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
                  ),
                if (_currentPage == _numPages - 1)
                  Container(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          controller.submitTransferMoney();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Send',
                              style: TextStyle(
                                color: themeContext.colorScheme.onBackground,
                                fontSize: 22.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _selectBankPage(ThemeData themeContext, TransferController c) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Select Bank Account",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'enter or select the account number you want to transfer to.',
                  style: kSubtitleStyle(themeContext),
                ),
                SizedBox(height: 15.0),
                BankAccountInput(),
                SizedBox(height: 15.0),
                Obx(() {
                  if (c.uBanksList.isEmpty) {
                    return Row(
                      children: [
                        Container(
                          color: themeContext.colorScheme.primary,
                          child: InkWell(
                            onTap: () {
                              Get.offAllNamed(Routes.addBank);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Add a new bank account?',
                                style: TextStyle(
                                  color: themeContext.colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  if (c.sUBank.value.accountName != null) {
                    return SizedBox(
                      height: 50.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text((c.sUBank.value.accountName ?? '')),
                          Text(c.sUBank.value.bank?.name ?? ''),
                        ],
                      ),
                    );
                  }

                  List<Widget> bankTiles = c.uBanksList.map((entry) {
                    return _RecipientBankListItem(uBank: entry ?? UserBank());
                  }).toList();

                  return ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: bankTiles.isNotEmpty ? bankTiles : <Widget>[],
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                  );
                })
              ],
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _transactionAmountPage(ThemeData themeContext, TransferController c) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 350.0,
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
                  'Enter the amount you want to transfer.',
                  style: kSubtitleStyle(themeContext),
                ),
                SizedBox(height: 35.0),
                Text(
                  'Transfer settings :',
                  style: kSubtitleStyle(themeContext),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Obx(() {
                    return SmartSelect<TransferOrigin>.single(
                        modalType: S2ModalType.bottomSheet,
                        tileBuilder: (context, state) {
                          return S2Tile<dynamic>(
                            title: state.titleWidget,
                            value: Text(
                              state.selected.toString(),
                              style: kSelectionStyle(themeContext),
                            ),
                            onTap: state.showModal,
                          );
                        },
                        title: 'origin',
                        selectedValue: c.selectedTransferOrgn.value ??
                            TransferOrigin.stash,
                        // selectedValue: TransferOrigin.stash,
                        choiceItems: c.transferOrigins,
                        onChange: (state) => c.setTransferOrigin(state));
                  }),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Obx(() {
                    if (c.walletOptions.isEmpty ||
                        c.selectedTransferOrgn.value == TransferOrigin.stash) {
                      return Container();
                    }
                    return SmartSelect<Wallet>.single(
                        modalType: S2ModalType.bottomSheet,
                        tileBuilder: (context, state) {
                          return S2Tile<dynamic>(
                            title: state.titleWidget,
                            value: Text(state.selected.toString()),
                            onTap: state.showModal,
                          );
                        },
                        title: 'wallet',
                        selectedValue: c.defaultWallet.value ?? Wallet(),
                        choiceItems: c.walletOptions,
                        onChange: (state) {});
                  }),
                  // Container()
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

  Widget _transactionPurposePage(ThemeData themeContext, TransferController c) {
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

  Widget _transactionOtpPage(ThemeData themeContext, TransferController c,
      PageController pageController) {
    return Obx(() {
      if (c.status.value == FormzStatus.submissionInProgress) {
        return Center(
          child: Container(
              height: 40.0, width: 40.0, child: CircularProgressIndicator()),
        );
      }

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
    });
  }

  Widget _transactionReviewPage(
      ThemeData themeContext, TransferController c, Size size) {
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
                    Expanded(
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
                                    'Bank Transfer To : ',
                                    style: kReviewHeaderStyle(themeContext),
                                  ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() => Text(
                                        c.sUBank.value.accountNumber.toString(),
                                        style: kReviewSubHeaderFaintStyle(
                                            themeContext),
                                      )),
                                  Obx(() => Text(
                                        c.sUBank.value.accountName.toString(),
                                        style: kReviewSubHeaderFaintStyle(
                                            themeContext),
                                      )),
                                  Obx(() => Text(
                                        c.sUBank.value.bank?.name?.toString() ??
                                            "",
                                        style: kReviewSubHeaderFaintStyle(
                                            themeContext),
                                      ))
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Total',
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
                                      Obx(() => Text(
                                          (c.amount.value +
                                                  c.transferCharge.value)
                                              .intHumanFormat(),
                                          style: TextStyle(fontSize: 20))),
                                    ],
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Send',
                                        style: kReviewSubHeaderFaintStyle(
                                            themeContext),
                                      ),
                                      Row(
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Obx(() => Text(
                                              c.amount.value.toString(),
                                              style: kReviewSubHeaderFaintStyle(
                                                  themeContext))),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Charge',
                                        style: kReviewSubHeaderFaintStyle(
                                            themeContext),
                                      ),
                                      Row(
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Text(
                                              c.transferCharge.value.toString(),
                                              style: kReviewSubHeaderFaintStyle(
                                                  themeContext)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: kSpacing / 2,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Purpose',
                                        style: kReviewSubHeaderFaintStyle(
                                            themeContext),
                                      ),
                                      Text(c.purpose.value.toString(),
                                          style: kReviewSubHeaderFaintStyle(
                                              themeContext))
                                    ],
                                  ),
                                  SizedBox(
                                    height: kSpacing / 2,
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
  TransferController controller = Get.find<TransferController>();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Stack(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Obx(() {
            return TextFormField(
              key: Key(controller.amount.value.toString()),
              keyboardType: TextInputType.number,
              initialValue: controller.amount.value.toString(),
              autofocus: true,
              onChanged: (amount) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  controller.updateAmount(amount);
                });
              },
              decoration: InputDecoration(
                labelText: 'Amount',
                errorStyle: TextStyle(color: kDangerColor),
                errorText:
                    controller.amount.value <= 0 ? 'invalid amount' : null,
              ),
            );
          })
        ],
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: InkWell(
            onTap: () {
              controller.maxAmount();
            },
            child: Container(
              color: themeData.colorScheme.primary,
              child: Padding(
                  padding: const EdgeInsets.all(kSpacing / 3),
                  child: Text("MAX")),
            ),
          ),
        ),
      ),
    ]);
  }
}

// ignore: must_be_immutable
class BankAccountInput extends StatelessWidget {
  Timer? debounce;

  BankAccountInput({
    Key? key,
    this.debounce,
  }) : super(key: key);
  TransferController controller = Get.find<TransferController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Obx(() {
          return TextFormField(
            key: Key(controller.acctNumber.value),
            autofocus: true,
            keyboardType: TextInputType.number,
            initialValue: controller.acctNumber.value,
            onChanged: (acctNum) {
              if (debounce?.isActive ?? false) debounce?.cancel();
              debounce = Timer(const Duration(milliseconds: 500), () {
                controller.updateAcountNumber(acctNum);
              });
            },
            decoration: InputDecoration(
              labelText: 'Account Number',
              errorStyle: TextStyle(color: kDangerColor),
              errorText: controller.acctNumber.isEmpty
                  ? 'invalid acount number'
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
    TransferController controller = Get.find<TransferController>();
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
  TransferController controller = Get.find<TransferController>();

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
      autoFocus: true,
      appContext: context,
      length: 6,
      obscureText: true,
      animationType: AnimationType.fade,
      animationDuration: Duration(milliseconds: 300),
      errorAnimationController: errorController,
      keyboardType: TextInputType.number,
      controller: textEditingController,
      onChanged: (value) {
        if (canBeInteger(value) && (value.isNotEmpty)) {
          controller.updateOtp(value);
          setState(() {
            textEditingController.text = value;
          });
        } else {
          errorController.add(ErrorAnimationType.shake);
        }
      },
      beforeTextPaste: (text) => canBeInteger(text ?? ''),
    );
  }
}

class _RecipientBankListItem extends StatelessWidget {
  _RecipientBankListItem({
    Key? key,
    required this.uBank,
  }) : super(key: key);

  final UserBank uBank;

  final TransferController tCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            tCtrl.selectUBank(uBank);
          },
          child: SizedBox(
            height: 60.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 6.0, 2.0, 2.0),
                    child: _RecipientBankDescription(
                      uBank: uBank,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecipientBankDescription extends StatelessWidget {
  final acctNameStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );
  final UserBank uBank;

  _RecipientBankDescription({Key? key, required this.uBank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeCtx = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(uBank.accountName ?? "", style: acctNameStyle),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    uBank.accountNumber ?? "",
                    style: TextStyle(
                      color: themeCtx.textTheme.caption?.color,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(width: kSpacing / 2),
                  Text(
                    uBank.bank?.name ?? "",
                    style: TextStyle(
                      color: themeCtx.textTheme.caption?.color,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
