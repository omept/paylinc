library create_wallet;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/shared_components.dart';
import 'package:paylinc/utils/utils.dart';
import 'package:user_repository/user_repository.dart';

part '../bindings/create_wallet_bindings.dart';
part '../controller/create_wallet_controller.dart';

class CreateWalletScreen extends GetView<CreateWalletController> {
  const CreateWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Scaffold(
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        mobileBuilder: _createWalletMobileScreenWidget,
        tabletBuilder: _createWalletTabletScreenWidget,
        desktopBuilder: _createWalletDesktopScreenWidget,
      )),
    );
  }

  Widget _createWalletDesktopScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_createWalletMobileScreenWidget(context, constraints)],
    );

    // return Container();
  }

  Widget _createWalletTabletScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_createWalletMobileScreenWidget(context, constraints)],
    );
  }

  Widget _createWalletMobileScreenWidget(context, constraints) {
    return CreateWalletFlow();
  }
}

class CreateWalletFlow extends StatefulWidget {
  CreateWalletFlow({Key? key}) : super(key: key);

  @override
  _CreateWalletFlowState createState() => _CreateWalletFlowState();
}

class _CreateWalletFlowState extends State<CreateWalletFlow> {
  final int _numPages = 2;
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
  kSelectionStyle(themeContext) => TextStyle(
        color: themeContext?.textTheme?.caption?.color,
        fontSize: 15.0,
        height: 1.2,
      );

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Builder(builder: (context) {
      var themeContext = Theme.of(context);
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
    var size = MediaQuery.of(context).size;
    ThemeData themeContext = Theme.of(context);
    CreateWalletController controller = Get.find<CreateWalletController>();
    return SafeArea(
      child: Container(
        height: size.height - 60,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kSpacing * 2, vertical: kSpacing / 3),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Wallet',
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
                      _supportedCategoryPage(themeContext, controller),
                      _walletPaytagPage(themeContext, controller),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: kSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
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
                                    color:
                                        themeContext.colorScheme.onBackground,
                                    size: 30.0,
                                  ),
                                  SizedBox(width: 10.0)
                                ],
                              ),
                            ),
                          ),
                        ),
                  _currentPage == _numPages - 1
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
                                                'Create',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  fontSize: 22.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                    onPressed: () {
                                      controller.createWallet();
                                    },
                                  );
                                })
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  _currentPage == _numPages - 1
                      ? Container()
                      : Container(
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
                                    color:
                                        themeContext.colorScheme.onBackground,
                                    size: 30.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _supportedCategoryPage(
      ThemeData themeContext, CreateWalletController c) {
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
                  "Category",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'select the wallet category.',
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
                title: 'Category',
                selectedValue: c.selectedCatValue,
                choiceItems: c.categoryOptions,
                // choiceLoader: c.categoryChoiceOpts,
                onChange: (state) => c.selectedCatValue = state.value)),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _walletPaytagPage(
      ThemeData themeContext, CreateWalletController controller) {
    return Column(
      children: [
        Container(
          height: 200.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Vendor Wallet Paytag",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Enter the name of the vendor wallet paytag to create. You\'ll use this for recieving money.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: PaytagInput(),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}

class PaytagInput extends StatefulWidget {
  @override
  State<PaytagInput> createState() => _PaytagInputState();
}

class _PaytagInputState extends State<PaytagInput> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    CreateWalletController controller = Get.find<CreateWalletController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Obx(() {
          return TextFormField(
            initialValue: controller.paytag.value,
            onChanged: (paytag) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                controller.updatePaytag(paytag);
              });
            },
            decoration: InputDecoration(
              labelText: 'Wallet Paytag',
              errorStyle: TextStyle(color: kDangerColor),
              errorText:
                  controller.paytag.value.isEmpty ? 'invalid paytag' : null,
            ),
          );
        }),
        Obx(() {
          return controller.paytag.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    controller.paytagUsageMessage.value,
                    style: _paytagMessageStyle(
                        controller.paytagUsageMessage.value),
                  ),
                )
              : Container();
        })
      ],
    );
  }

  TextStyle? _paytagMessageStyle(String paytagUsageMessage) {
    if (paytagUsageMessage == "") {
      return null;
    }

    if (paytagUsageMessage == "available") {
      return TextStyle(color: kNotifColor);
    } else if (paytagUsageMessage == "checking . . .") {
      return TextStyle(color: kNotifColor);
    } else {
      return TextStyle(color: Theme.of(Get.context!).errorColor);
    }
  }
}
