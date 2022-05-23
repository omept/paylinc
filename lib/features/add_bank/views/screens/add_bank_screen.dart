library add_bank;

import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/shared_components.dart';

import 'package:paylinc/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/utils/utils.dart';
import 'package:user_repository/user_repository.dart';
// binding
part '../../bindings/add_bank_bindings.dart';

// controller
part '../../controllers/add_bank_controller.dart';

class AddBankScreen extends GetView<AddBankController> {
  AddBankScreen({Key? key}) : super(key: key);

  final kTitleStyle = TextStyle(
    fontFamily: 'CM Sans Serif',
    fontSize: 26.0,
    height: 1.5,
  );

  kSubtitleStyle(themeData) => TextStyle(
        color: themeData?.textTheme?.caption?.color,
        fontSize: 13.0,
        height: 1.2,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: (ResponsiveBuilder.isDesktop(context))
          ? null
          : Drawer(
              child: Padding(
                  padding: const EdgeInsets.only(top: kSpacing),
                  child: _sideBar()),
            ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: _initializedTransactionsMobileScreenWidget,
          tabletBuilder: _initializedTransactionsTabletScreenWidget,
          desktopBuilder: _initializedTransactionsDesktopScreenWidget,
        ),
      )),
    );
  }

  Widget _initializedTransactionsDesktopScreenWidget(context, constraints) {
    var maxWidth = 1360;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: (constraints.maxWidth < maxWidth) ? 4 : 3,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(kBorderRadius),
                bottomRight: Radius.circular(kBorderRadius),
              ),
              child: _sideBar()),
        ),
        Flexible(
          flex: 9,
          child: Column(
            children: [
              const SizedBox(height: kSpacing),
              _buildHeader(),
              const SizedBox(height: kSpacing * 2),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: kSpacing / 2),
              _buildProfile(data: getProfile()),
              const Divider(thickness: 1),
              const SizedBox(height: kSpacing),
            ],
          ),
        )
      ],
    );

    // return Container();
  }

  Sidebar _sideBar() {
    return Sidebar(
      data: getSelectedProject(),
      initialSelected: 4,
    );
  }

  Widget _initializedTransactionsTabletScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: (constraints.maxWidth < 950) ? 6 : 9,
          child: Column(
            children: [
              const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
              _buildHeader(onPressedMenu: () => controller.openDrawer()),
              const SizedBox(height: kSpacing * 2),
              const SizedBox(height: kSpacing * 2),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: kSpacing * (kIsWeb ? 0.5 : 1.5)),
            ],
          ),
        )
      ],
    );
  }

  Widget _initializedTransactionsMobileScreenWidget(context, constraints) {
    ThemeData themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: kSpacing / 2,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAllNamed(Routes.userBanks);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.arrow_back,
                        color: themeData.colorScheme.onBackground,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Add A Bank Account",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Obx(() {
                    return SmartSelect<Bank>.single(
                        modalType: S2ModalType.bottomSheet,
                        tileBuilder: (context, state) {
                          return S2Tile<dynamic>(
                            title: state.titleWidget,
                            value: Text(
                              state.selected.toString(),
                              // style: kSelectionStyle(themeContext),
                            ),
                            onTap: state.showModal,
                          );
                        },
                        title: 'Select Bank',
                        selectedValue: controller.selectedBank.value,
                        choiceItems: controller.bankOptions,
                        onChange: (state) => controller.selectBank(state));
                  }),
                ),
                SizedBox(height: 15.0),
                _BankAccountInput(),
                SizedBox(height: 15.0),
                Obx(() {
                  if (!controller.resolvingAcctName.value) {
                    return Container();
                  }
                  return Text(
                    "checking account name...",
                  );
                }),
                Obx(() {
                  if (controller.acctName.value.isEmpty) {
                    return Container();
                  }
                  return Text(controller.acctName.value);
                }),
                Obx(() {
                  if (controller.acctName.value.isEmpty) {
                    return Container();
                  }
                  return ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      controller.saveBank();
                    },
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

  Widget _buildHeader({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          if (onPressedMenu != null)
            Padding(
              padding: const EdgeInsets.only(right: kSpacing),
              child: IconButton(
                onPressed: onPressedMenu,
                icon: const Icon(EvaIcons.menu),
                tooltip: "menu",
              ),
            ),
          const Expanded(
              child: Header(
            todayText: TodayText(message: "Your Banks"),
          )),
        ],
      ),
    );
  }

  Widget _buildProfile({required Profile data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: ProfilTile(
        data: data,
        onPressedNotification: () {},
      ),
    );
  }
}

// ignore: must_be_immutable
class _BankAccountInput extends StatelessWidget {
  Timer? debounce;

  _BankAccountInput({
    Key? key,
    this.debounce,
  }) : super(key: key);
  AddBankController controller = Get.find<AddBankController>();

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
                  ? 'invalid account number'
                  : null,
            ),
          );
        })
      ],
    );
  }
}
