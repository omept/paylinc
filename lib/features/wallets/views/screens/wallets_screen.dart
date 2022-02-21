library wallets;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/models/empty_list_indicator.dart';

import 'package:paylinc/shared_components/models/profile.dart';
import 'package:paylinc/shared_components/profile_tile.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/selected_project.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:paylinc/shared_components/today_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paylinc/shared_components/wallet_card.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/get_profile.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:user_repository/user_repository.dart';

// binding
part '../../bindings/wallets_binding.dart';

// controller
part '../../controllers/wallets_controller.dart';

class WalletsScreen extends GetView<WalletsController> {
  WalletsScreen({Key? key}) : super(key: key);

  final alrtAmountStyle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.w600,
    // color: themeContext.textTheme.caption?.color,
  );

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Scaffold(
      key: controller.scaffoldKey,
      drawer: (ResponsiveBuilder.isDesktop(context))
          ? null
          : Drawer(
              child: Padding(
                padding: const EdgeInsets.only(top: kSpacing),
                child: Sidebar(
                  data: getSelectedProject(),
                  initialSelected: 2,
                ),
              ),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: ResponsiveBuilder(
          mobileBuilder: _walletsMobileScreenWidget,
          tabletBuilder: _walletsTabletScreenWidget,
          desktopBuilder: _walletsDesktopScreenWidget,
        )),
      ),
    );
  }

  Widget _walletsDesktopScreenWidget(context, constraints) {
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
              child: Sidebar(
                data: getSelectedProject(),
                initialSelected: 2,
              )),
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

  Widget _walletsTabletScreenWidget(context, constraints) {
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

  Widget _walletsMobileScreenWidget(context, constraints) {
    ThemeData themeData = Theme.of(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    WalletsController ctrl = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          _buildHeader(onPressedMenu: () => controller.openDrawer()),
          const SizedBox(height: kSpacing * 2),
          Obx(
            () => Text(
              "${ctrl.currncy.value} ${ctrl.combinedBal.value.doubleHumanFormat()} ",
              style: alrtAmountStyle,
            ),
          ),
          Text(
            "Combined balance",
          ),
          const SizedBox(height: kSpacing),
          Container(
            width: 100.0,
            height: 50.0,
            child: Card(
              child: Center(
                child: Icon(
                  EvaIcons.paperPlane,
                  color: themeData.colorScheme.secondary,
                ),
              ),
            ),
          ),
          const Divider(),
        ]),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Stash",
                style: TextStyle(color: themeData.textTheme.caption?.color),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 7.0),
                child: Container(
                  height: 40.0,
                  width: mediaQueryData.size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Obx(
                        () => Text(
                          "${ctrl.currncy.value} ${ctrl.stashBal.value.intHumanFormat()}",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wallets",
                style: TextStyle(color: themeData.textTheme.caption?.color),
              ),
              _WalletsList(),
              WalletCard(
                onTap: () {},
                data: WalletCardData(totalWallets: ctrl.walletsList.length),
              ),
            ],
          ),
        )
      ],
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
            todayText: TodayText(message: "Wallets"),
          ))
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

class _WalletsList extends StatelessWidget {
  _WalletsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletsController ctrl = Get.find();
    return SingleChildScrollView(
      child: Obx(() {
        if (ctrl.walletsList.isEmpty) {
          return emptyListIndicator();
        }
        final List fixedList =
            Iterable<int>.generate(ctrl.walletsList.length).toList();

        final List<Widget> walletTiles = fixedList.map((idx) {
          return _WalletListItem(
            selectedIndex: idx,
            balance: "${ctrl.walletsList[idx]?.balance}",
            currency: "${ctrl.currncy.value}",
            walletPaytag: "${ctrl.walletsList[idx]?.walletPaytag}",
          );
        }).toList();

        return ListView(
          physics: NeverScrollableScrollPhysics(),
          children: walletTiles.length > 0 ? walletTiles : <Widget>[],
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 5.0),
        );
      }),
    );
  }
}

class _WalletDescription extends StatelessWidget {
  final alrtAmountStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    // color: themeContext.textTheme.caption?.color,
  );

  _WalletDescription(
      {Key? key,
      required this.balance,
      required this.currency,
      required this.walletPaytag})
      : super(key: key);

  final String balance;
  final String currency;
  final String walletPaytag;

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
            Text(balance.toShortHumanFormat(currency: "$currency "),
                style: alrtAmountStyle),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "@$walletPaytag",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: themeCtx.textTheme.caption?.color,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WalletListItem extends StatelessWidget {
  _WalletListItem({
    Key? key,
    required this.selectedIndex,
    required this.balance,
    required this.currency,
    required this.walletPaytag,
  }) : super(key: key);

  final int selectedIndex;
  final String balance;
  final String currency;
  final String walletPaytag;
  final WalletsController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            ctrl.setSelectedWallet(selectedIndex);
            Get.toNamed(Routes.view_wallet);
          },
          child: SizedBox(
            height: 68.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
                    child: _WalletDescription(
                      balance: balance,
                      currency: currency,
                      walletPaytag: walletPaytag,
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
