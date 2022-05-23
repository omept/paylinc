library transfer;

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/shared_components.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/utils/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:user_repository/user_repository.dart';

part '../bindings/transfer_binding.dart';
part '../controller/transfer_controller.dart';
part '../view/transfer_money_flow.dart';

class TransferScreen extends GetView<TransferController> {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: ResponsiveBuilder(
          mobileBuilder: _transferMobileScreenWidget,
          tabletBuilder: _transferTabletScreenWidget,
          desktopBuilder: _transferDesktopScreenWidget,
        )),
      ),
    );
  }

  Widget _transferDesktopScreenWidget(context, constraints) {
    return Container();
  }

  Widget _transferTabletScreenWidget(context, constraints) {
    return Container();
  }

  Widget _transferMobileScreenWidget(context, constraints) {
    return TransferMoneyFlow();
  }
}
