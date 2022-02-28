library password_update;

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

part '../bindings/password_update_bindings.dart';
part '../controller/password_update_controller.dart';

class PasswordUpdateScreen extends GetView<PasswordUpdateController> {
  const PasswordUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Scaffold(
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        mobileBuilder: _passwordUpdateMobileScreenWidget,
        tabletBuilder: _passwordUpdateTabletScreenWidget,
        desktopBuilder: _passwordUpdateDesktopScreenWidget,
      )),
    );
  }

  Widget _passwordUpdateDesktopScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_passwordUpdateMobileScreenWidget(context, constraints)],
    );

    // return Container();
  }

  Widget _passwordUpdateTabletScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_passwordUpdateMobileScreenWidget(context, constraints)],
    );
  }

  Widget _passwordUpdateMobileScreenWidget(context, constraints) {
    return PasswordUpdateFlow();
  }
}

class PasswordUpdateFlow extends StatefulWidget {
  PasswordUpdateFlow({Key? key}) : super(key: key);

  @override
  _PasswordUpdateFlowState createState() => _PasswordUpdateFlowState();
}

class _PasswordUpdateFlowState extends State<PasswordUpdateFlow> {
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
    PasswordUpdateController controller = Get.find<PasswordUpdateController>();
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
                    'Update Password',
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
                      _currentPasswordPage(themeContext, controller),
                      _newPasswordPage(themeContext, controller),
                      _confirmNewPasswordPage(themeContext, controller),
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
                                      controller.passwordUpdate();
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

  Widget _currentPasswordPage(
      ThemeData themeContext, PasswordUpdateController controller) {
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
                    "Current Password",
                    style: kTitleStyle,
                  ),
                ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your current password.',
                    style: kSubtitleStyle(themeContext),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: Obx(() {
            return TextFormField(
              obscureText: true,
              initialValue: controller.currentPassword.value,
              onChanged: (val) {
                controller.currentPassword.value = val;
              },
              decoration: InputDecoration(
                labelText: 'Current Password',
                errorStyle: TextStyle(color: kDangerColor),
                errorText: null,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _newPasswordPage(
      ThemeData themeContext, PasswordUpdateController controller) {
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
                    "New Password",
                    style: kTitleStyle,
                  ),
                ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter the your new password',
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
          child: Obx(() {
            return TextFormField(
              obscureText: true,
              initialValue: controller.newPassword.value,
              onChanged: (val) {
                controller.newPassword.value = val;
              },
              decoration: InputDecoration(
                labelText: 'New Password',
                errorStyle: TextStyle(color: kDangerColor),
                errorText: null,
              ),
            );
          }),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _confirmNewPasswordPage(
      ThemeData themeContext, PasswordUpdateController controller) {
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
                    "Confirm New Password",
                    style: kTitleStyle,
                  ),
                ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your new password again',
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
          child: Obx(() {
            return TextFormField(
              obscureText: true,
              initialValue: controller.cNewPassword.value,
              onChanged: (val) {
                controller.cNewPassword.value = val;
              },
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                errorStyle: TextStyle(color: kDangerColor),
                errorText: null,
              ),
            );
          }),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
