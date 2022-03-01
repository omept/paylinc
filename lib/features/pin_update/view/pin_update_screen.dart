library pin_update;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/helpers/is_text_an_integer.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

part '../bindings/pin_update_bindings.dart';
part '../controller/pin_update_controller.dart';

class PinUpdateScreen extends GetView<PinUpdateController> {
  const PinUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Scaffold(
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        mobileBuilder: _pinUpdateMobileScreenWidget,
        tabletBuilder: _pinUpdateTabletScreenWidget,
        desktopBuilder: _pinUpdateDesktopScreenWidget,
      )),
    );
  }

  Widget _pinUpdateDesktopScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_pinUpdateMobileScreenWidget(context, constraints)],
    );

    // return Container();
  }

  Widget _pinUpdateTabletScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_pinUpdateMobileScreenWidget(context, constraints)],
    );
  }

  Widget _pinUpdateMobileScreenWidget(context, constraints) {
    return PinUpdateFlow();
  }
}

class PinUpdateFlow extends StatefulWidget {
  PinUpdateFlow({Key? key}) : super(key: key);

  @override
  _PinUpdateFlowState createState() => _PinUpdateFlowState();
}

class _PinUpdateFlowState extends State<PinUpdateFlow> {
  final int _numPages = 3;
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
    PinUpdateController controller = Get.find<PinUpdateController>();
    return SafeArea(
      child: Container(
        height: size.height - 60,
        width: size.width,
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
                    'Update Pin',
                    style: TextStyle(
                      color: themeContext.textTheme.caption?.color,
                      fontSize: 14.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offNamed(Routes.settings);
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
                      _currentPinPage(themeContext, controller),
                      _newPinPage(themeContext, controller),
                      _confirmNewPinPage(themeContext, controller),
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
                                                'Submit',
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
                                      controller.pinUpdate();
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

  Widget _currentPinPage(
      ThemeData themeContext, PinUpdateController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200.0,
          // width: 30.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Current Pin",
                    style: kTitleStyle,
                  ),
                ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your current pin.',
                    style: kSubtitleStyle(themeContext),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: _TransferPinInput(),
        ),
      ],
    );
  }

  Widget _newPinPage(ThemeData themeContext, PinUpdateController controller) {
    return Column(
      children: [
        Container(
          height: 200.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "New Pin",
                    style: kTitleStyle,
                  ),
                ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter the your new pin',
                    style: kSubtitleStyle(themeContext),
                  ),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: _NewTransferPinInput()),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _confirmNewPinPage(
      ThemeData themeContext, PinUpdateController controller) {
    return Column(
      children: [
        Container(
          height: 200.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm New Pin",
                    style: kTitleStyle,
                  ),
                ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your new pin again',
                    style: kSubtitleStyle(themeContext),
                  ),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: _CNewTransferPinInput()),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}

class _TransferPinInput extends StatefulWidget {
  const _TransferPinInput({Key? key}) : super(key: key);
  @override
  State<_TransferPinInput> createState() => _TransferPinInputState();
}

class _TransferPinInputState extends State<_TransferPinInput> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();
  PinUpdateController controller = Get.find();

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
      length: 6,
      obscureText: true,
      animationType: AnimationType.fade,
      animationDuration: Duration(milliseconds: 300),
      errorAnimationController: errorController,
      keyboardType: TextInputType.number,
      controller: textEditingController,
      onChanged: (value) {
        if (canBeInteger(value) && (value.length > 0)) {
          controller.newPin.value = value.toInt();
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

class _NewTransferPinInput extends StatefulWidget {
  const _NewTransferPinInput({Key? key}) : super(key: key);
  @override
  State<_NewTransferPinInput> createState() => _NewTransferPinInputState();
}

class _NewTransferPinInputState extends State<_NewTransferPinInput> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();
  PinUpdateController controller = Get.find();

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
      length: 6,
      obscureText: true,
      animationType: AnimationType.fade,
      animationDuration: Duration(milliseconds: 300),
      errorAnimationController: errorController,
      keyboardType: TextInputType.number,
      controller: textEditingController,
      onChanged: (value) {
        if (canBeInteger(value) && (value.length > 0)) {
          controller.newPin.value = value.toInt();
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

class _CNewTransferPinInput extends StatefulWidget {
  const _CNewTransferPinInput({Key? key}) : super(key: key);
  @override
  State<_CNewTransferPinInput> createState() => _CNewTransferPinInputState();
}

class _CNewTransferPinInputState extends State<_CNewTransferPinInput> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();
  PinUpdateController controller = Get.find();

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
        length: 6,
        obscureText: true,
        animationType: AnimationType.fade,
        animationDuration: Duration(milliseconds: 300),
        errorAnimationController: errorController,
        keyboardType: TextInputType.number,
        controller: textEditingController,
        onChanged: (value) {
          if (canBeInteger(value) && (value.length > 0)) {
            controller.cNewPin.value = value.toInt();
            setState(() {
              textEditingController.text = value;
            });
          } else {
            errorController.add(ErrorAnimationType.shake);
          }
        },
        beforeTextPaste: (text) => canBeInteger(text ?? ''));
  }
}
