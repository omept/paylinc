// ignore_for_file: must_be_immutable

library user_banks;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/shared_components.dart';

import 'package:paylinc/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:user_repository/user_repository.dart';
// binding
part '../../bindings/user_banks_bindings.dart';

// controller
part '../../controllers/user_banks_controller.dart';

class UserBanksScreen extends GetView<UserBanksController> {
  UserBanksScreen({Key? key}) : super(key: key);

  final kTitleStyle = const TextStyle(
    fontFamily: 'CM Sans Serif',
    fontSize: 26.0,
    height: 1.5,
  );

  UserBanksController uBCtrl = Get.find<UserBanksController>();

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

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: kSpacing / 2,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAllNamed(Routes.settings);
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () => Get.offNamed(Routes.addBank),
                  child: Container(
                    width: 100.0,
                    height: 50.0,
                    child: Card(
                      child: Center(
                        child: Icon(
                          EvaIcons.plus,
                          color: themeData.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 55.0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                    child: Text(
                      'Banks',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: kTitleStyle,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Swipe to delete a bank.',
                  // style: kSubtitleStyle(themeData),
                ),
                SizedBox(height: 15.0),
                Divider(),
                Obx(() {
                  if (uBCtrl.uBanksList.isEmpty) {
                    return Row(
                      children: [
                        Container(
                          color: themeData.colorScheme.primary,
                          child: InkWell(
                            onTap: () {
                              Get.offAllNamed(Routes.addBank);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Add a new bank account?',
                                style: TextStyle(
                                  color: themeData.colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  List<Widget> bankTiles = controller.uBanksList.map((entry) {
                    return _BankListItem(uBank: entry ?? UserBank());
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
        ]);
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

class _BankListItem extends StatelessWidget {
  _BankListItem({
    Key? key,
    required this.uBank,
  }) : super(key: key);

  final UserBank uBank;

  final UserBanksController uBCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (contex) {
              uBCtrl.deleteUserBank(uBank);
            },
            backgroundColor: Color.fromARGB(255, 188, 43, 69),
            foregroundColor: Colors.white,
            icon: Icons.delete_forever,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Card(
          elevation: 1.0,
          margin: EdgeInsets.all(0),
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
