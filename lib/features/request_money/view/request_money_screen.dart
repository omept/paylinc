library request_money;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/shared_components.dart';
import 'package:paylinc/utils/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';

part '../bindings/request_money_bindings.dart';
part '../controller/request_money_controller.dart';
part './request_money_flow.dart';

class RequestMoneyScreen extends GetView<RequestMoneyController> {
  const RequestMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: ResponsiveBuilder(
          mobileBuilder: _requestMoneyMobileScreenWidget,
          tabletBuilder: _requestMoneyTabletScreenWidget,
          desktopBuilder: _requestMoneyDesktopScreenWidget,
        )),
      ),
    );
  }

  Widget _requestMoneyDesktopScreenWidget(context, constraints) {
    return Container();
  }

  Widget _requestMoneyTabletScreenWidget(context, constraints) {
    return Container();
  }

  Widget _requestMoneyMobileScreenWidget(context, constraints) {
    return RequestMoneyFlow();
  }
}
