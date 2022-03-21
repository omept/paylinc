library transfer;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/shared_components/shared_components.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';

part '../bindings/transfer_binding.dart';
part '../controller/transfer_controller.dart';

class TransferScreen extends GetView<TransferController> {
  const TransferScreen({Key? key}) : super(key: key);

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
    return Center(
      child: Text("Transfer page"),
    );
  }
}
