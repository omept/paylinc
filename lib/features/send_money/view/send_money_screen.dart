library send_money;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:paylinc/utils/helpers/is_text_an_integer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:paylinc/shared_components/models/review_request.dart';
import 'package:paylinc/utils/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

part '../bindings/send_money_bindings.dart';
part '../controller/send_money_controller.dart';
part './send_money_flow.dart';

class SendMoneyScreen extends GetView<SendMoneyController> {
  const SendMoneyScreen({Key? key}) : super(key: key);

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
    return SendMoneyFlow();
  }
}
