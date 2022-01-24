part of request_money;

class RequestMoneyFlow extends StatefulWidget {
  RequestMoneyFlow({Key? key}) : super(key: key);

  @override
  _RequestMoneyFlowState createState() => _RequestMoneyFlowState();
}

class _RequestMoneyFlowState extends State<RequestMoneyFlow> {
  final int _numPages = 6;
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

  Widget _promoCode(String code) {
    return (code == 'null')
        ? Container()
        : Container(
            width: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: kNotifColor,
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Builder(builder: (context) {
              return Text(
                code,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              );
            }),
          );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var themeContext = Theme.of(context);
    RequestMoneyController controller = Get.find<RequestMoneyController>();
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
                  'Request Money',
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
                    _recipientPaytagPage(themeContext, controller),
                    _senderPaytagePage(themeContext, controller),
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

  Widget _recipientPaytagPage(
      ThemeData themeContext, RequestMoneyController c) {
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
                  "Wallet",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'select the wallet you want this transaction for.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: SmartSelect<String>.single(
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
                title: 'My Wallet',
                selectedValue: c.selectedWalletValue,
                choiceItems: c.walletOptions,
                onChange: (state) => c.updateSelectedWallet(state.value))),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _senderPaytagePage(ThemeData themeContext, RequestMoneyController c) {
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
                  "Sender Paytag",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'enter the account paytag you want to request money from.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: _SenderPaytagInput()),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _transactionAmountPage(
      ThemeData themeContext, RequestMoneyController c) {
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
                  'Enter the amount you want to request.',
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
      ThemeData themeContext, RequestMoneyController c) {
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

  Widget _transactionOtpPage(ThemeData themeContext, RequestMoneyController c,
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
      ThemeData themeContext, RequestMoneyController c, Size size) {
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
                                            '@${c.reviewRequest.value.sender?.paytag}',
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
                                            '@${c.reviewRequest.value.recipient?.paytag}',
                                            style: kReviewSubHeaderValueStyle(
                                                themeContext),
                                          );
                                        }),
                                        Obx(() {
                                          return _promoCode(
                                              '${c.reviewRequest.value.promoCode}');
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
                                                  '${c.reviewRequest.value.amount?.intHumanFormat()}',
                                                  style:
                                                      kReviewSubHeaderValueStyle(
                                                          themeContext));
                                            }),
                                            Obx(() {
                                              return Text(
                                                '${c.reviewRequest.value.recipient?.country?.currencyAbr} ',
                                                style:
                                                    kReviewSubHeaderValueStyle(
                                                        themeContext),
                                              );
                                            }),
                                          ],
                                        ),
                                        Divider(),
                                        Text(
                                          'Receive',
                                          style:
                                              kReviewHeaderStyle(themeContext),
                                        ),
                                        SizedBox(
                                          height: kSpacing / 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'International',
                                              style: kReviewSubHeaderFaintStyle(
                                                  themeContext),
                                            ),
                                            Row(
                                              textDirection: TextDirection.rtl,
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                      '${c.reviewRequest.value.remitableAmountInt?.doubleHumanFormat()}',
                                                      style:
                                                          kReviewSubHeaderValueStyle(
                                                              themeContext));
                                                }),
                                                Obx(() {
                                                  return Text(
                                                    '${c.reviewRequest.value.recipient?.country?.currencyAbr} ',
                                                    style:
                                                        kReviewSubHeaderStyle(
                                                            themeContext),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Local',
                                              style: kReviewSubHeaderFaintStyle(
                                                  themeContext),
                                            ),
                                            Row(
                                              textDirection: TextDirection.rtl,
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                      '${c.reviewRequest.value.remitableAmountLoc?.doubleHumanFormat()}',
                                                      style:
                                                          kReviewSubHeaderValueStyle(
                                                              themeContext));
                                                }),
                                                Obx(() {
                                                  return Text(
                                                    '${c.reviewRequest.value.recipient?.country?.currencyAbr} ',
                                                    style:
                                                        kReviewSubHeaderStyle(
                                                            themeContext),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: kSpacing / 2,
                                        ),
                                        c.reviewRequest.value.promoApplied ==
                                                false
                                            ? Container()
                                            : Column(
                                                children: [
                                                  Divider(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: kSpacing),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Promo',
                                                            style:
                                                                kReviewSubHeaderFaintStyle(
                                                                    themeContext),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: kSpacing / 2,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'International',
                                                              style: kReviewSubHeaderFaintStyle(
                                                                  themeContext),
                                                            ),
                                                            Row(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              children: [
                                                                Obx(() {
                                                                  return Text(
                                                                      '${c.reviewRequest.value.promoRemitableAmountInt?.doubleHumanFormat()}',
                                                                      style: kReviewSubHeaderValueStyle(
                                                                          themeContext));
                                                                }),
                                                                Obx(() {
                                                                  return Text(
                                                                    '${c.reviewRequest.value.recipient?.country?.currencyAbr} ',
                                                                    style: kReviewSubHeaderStyle(
                                                                        themeContext),
                                                                  );
                                                                }),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Local',
                                                              style: kReviewSubHeaderFaintStyle(
                                                                  themeContext),
                                                            ),
                                                            Row(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              children: [
                                                                Obx(() {
                                                                  return Text(
                                                                      '${c.reviewRequest.value.promoRemitableAmountLoc?.doubleHumanFormat()}',
                                                                      style: kReviewSubHeaderValueStyle(
                                                                          themeContext));
                                                                }),
                                                                Obx(() {
                                                                  return Text(
                                                                    '${c.reviewRequest.value.recipient?.country?.currencyAbr} ',
                                                                    style: kReviewSubHeaderValueStyle(
                                                                        themeContext),
                                                                  );
                                                                }),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(),
                                                ],
                                              ),
                                        Divider(),
                                        Text(
                                          'Charge Info',
                                          style:
                                              kReviewHeaderStyle(themeContext),
                                        ),
                                        SizedBox(
                                          height: kSpacing / 2,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Obx(() {
                                            return Text(
                                              '${c.reviewRequest.value.paymentProviderName}',
                                              style: kReviewSubHeaderFaintStyle(
                                                  themeContext),
                                            );
                                          }),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'International',
                                              style: kReviewSubHeaderFaintStyle(
                                                  themeContext),
                                            ),
                                            Row(
                                              textDirection: TextDirection.rtl,
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                      '${c.reviewRequest.value.providerChargeInt?.doubleHumanFormat()}',
                                                      style:
                                                          kReviewSubHeaderValueStyle(
                                                              themeContext));
                                                }),
                                                Obx(() {
                                                  return Text(
                                                    '${c.reviewRequest.value.recipient?.country?.currencyAbr} ',
                                                    style:
                                                        kReviewSubHeaderValueStyle(
                                                            themeContext),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Local',
                                              style: kReviewSubHeaderFaintStyle(
                                                  themeContext),
                                            ),
                                            Row(
                                              textDirection: TextDirection.rtl,
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                      '${c.reviewRequest.value.providerChargeLoc?.doubleHumanFormat()}',
                                                      style:
                                                          kReviewSubHeaderValueStyle(
                                                              themeContext));
                                                }),
                                                Obx(() {
                                                  return Text(
                                                    '${c.reviewRequest.value.recipient?.country?.currencyAbr} ',
                                                    style:
                                                        kReviewSubHeaderValueStyle(
                                                            themeContext),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: kSpacing,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Service',
                                              style: kReviewSubHeaderFaintStyle(
                                                  themeContext),
                                            ),
                                            Row(
                                              textDirection: TextDirection.rtl,
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                      '${c.reviewRequest.value.appCharge?.doubleHumanFormat()}',
                                                      style:
                                                          kReviewSubHeaderValueStyle(
                                                              themeContext));
                                                }),
                                                Obx(() {
                                                  return Text(
                                                    '${c.reviewRequest.value.recipient?.country?.currencyAbr} ',
                                                    style:
                                                        kReviewSubHeaderValueStyle(
                                                            themeContext),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ],
                                        ),
                                        c.reviewRequest.value.promoApplied ==
                                                false
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Save',
                                                    style:
                                                        kReviewSubHeaderFaintStyle(
                                                            themeContext),
                                                  ),
                                                  Row(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    children: [
                                                      Obx(() {
                                                        return Text(
                                                            '${c.reviewRequest.value.appliedPromoCodeDeduction?.doubleHumanFormat}',
                                                            style: kReviewSubHeaderValueStyle(
                                                                themeContext));
                                                      }),
                                                      Obx(() {
                                                        return Text(
                                                          '${c.reviewRequest.value.recipient?.country?.currencyAbr} ',
                                                          style:
                                                              kReviewSubHeaderValueStyle(
                                                                  themeContext),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                        // Divider(),
                                        SizedBox(
                                          height: kSpacing / 2,
                                        )
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
    RequestMoneyController controller = Get.find<RequestMoneyController>();
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
    RequestMoneyController controller = Get.find<RequestMoneyController>();
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
  RequestMoneyController controller = Get.find<RequestMoneyController>();

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
        controller.submitRequestMoney();
      },
    );
  }
}

class _SenderPaytagInput extends StatefulWidget {
  @override
  State<_SenderPaytagInput> createState() => _SenderPaytagInputState();
}

class _SenderPaytagInputState extends State<_SenderPaytagInput> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    RequestMoneyController controller = Get.find<RequestMoneyController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Obx(() {
          return TextFormField(
            initialValue: controller.sender.value,
            onChanged: (paytag) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                controller.updateSenderPaytag(paytag);
              });
            },
            decoration: InputDecoration(
              labelText: 'Paytag',
              errorStyle: TextStyle(color: kDangerColor),
              errorText:
                  controller.sender.value.isEmpty ? 'invalid paytag' : null,
            ),
          );
        }),
        Obx(() {
          return controller.sender.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    controller.senderPaytagUsageMessage.value,
                    style: _paytagMessageStyle(
                        controller.senderPaytagUsageMessage.value),
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
