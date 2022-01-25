library user_alerts;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/models/initializedTransactionB64.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/shared_components/models/profile.dart';
import 'package:paylinc/shared_components/models/user_alerts_response.dart';
import 'package:paylinc/shared_components/profile_tile.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/selected_project.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:paylinc/shared_components/today_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paylinc/utils/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/helpers/get_profile.dart';
import 'package:paylinc/utils/helpers/is_text_an_integer.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

// binding
part '../../bindings/user_alerts_binding.dart';

// controller
part '../../controllers/user_alerts_controller.dart';

class UserAlertsScreen extends GetView<UserAlertsController> {
  const UserAlertsScreen({Key? key}) : super(key: key);

  final kTitleStyle = const TextStyle(
    fontFamily: 'CM Sans Serif',
    fontSize: 26.0,
    height: 1.5,
  );

  kSubtitleStyle(ThemeData themeContext) => TextStyle(
        color: themeContext.textTheme.caption?.color,
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
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        mobileBuilder: _userAlertsMobileScreenWidget,
        tabletBuilder: _userAlertsTabletScreenWidget,
        desktopBuilder: _userAlertsDesktopScreenWidget,
      )),
    );
  }

  Widget _userAlertsDesktopScreenWidget(context, constraints) {
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
  }

  Sidebar _sideBar() {
    return Sidebar(
      data: getSelectedProject(),
      initialSelected: 3,
    );
  }

  Widget _userAlertsTabletScreenWidget(context, constraints) {
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

  Widget _userAlertsMobileScreenWidget(context, constraints) {
    ThemeData themeData = Theme.of(context);
    // MediaQueryData mediaQuery = MediaQuery.of(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
          _buildHeader(onPressedMenu: () => controller.openDrawer()),
          const SizedBox(height: kSpacing / 2),
          Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Alerts",
                  style: kTitleStyle,
                ),
                SizedBox(height: 8.0),
                Text(
                  'view your most recent alerts.',
                  style: kSubtitleStyle(themeData),
                ),
                SizedBox(height: 15.0),
                DefaultTabController(
                  length: 2,
                  child: Column(children: [
                    Container(
                        child: const TabBar(
                      tabs: [
                        Tab(
                          text: "Payments",
                        ),
                        Tab(text: "Wallets")
                      ],
                    )),
                    Container(
                      height: 550,
                      child: const TabBarView(children: [
                        _PaymentAlerts(),
                        _WalletsAlerts(),
                      ]),
                    ),
                  ]),
                ),
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
              child: Header(todayText: TodayText(message: "My Alerts"))),
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

class _PaymentAlerts extends StatelessWidget {
  const _PaymentAlerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserAlertsController uAC = Get.find();
    return SingleChildScrollView(child: Obx(() {
      if (uAC.paymentAlertList.isEmpty) {
        return Center(child: Text("Empty"));
      }

      final List fixedList =
          Iterable<int>.generate(uAC.paymentAlertList.length).toList();

      final List<Widget> paymentTiles = fixedList.map((idx) {
        return _PaymentAlertListItem(
          alertTagMessage: AlertTagHelper.alertTagObj(
                  title:
                      "${uAC.paymentAlertList[idx]?.alertTag}")?['message'] ??
              '',
          transactionAmount: "${uAC.paymentAlertList[idx]?.amount}",
          transactionCurrency:
              "${uAC.paymentAlertList[idx]?.sender?.country?.currencyAbr}",
          senderPaytag: "${uAC.paymentAlertList[idx]?.sender?.paytag}",
          walletPaytag:
              "${uAC.paymentAlertList[idx]?.initializedTransaction?.wallet?.walletPaytag}",
          createdAt: Jiffy('${uAC.paymentAlertList[idx]?.createdAt}')
              .fromNow()
              .toString(),
          readStatus: uAC.paymentAlertList[idx]?.readStatus ?? false,
        );
      }).toList();

      return ListView(
        physics: NeverScrollableScrollPhysics(),
        children: paymentTiles.length > 0 ? paymentTiles : <Widget>[],
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5.0),
      );
    }));
  }
}

class _PaymentAlertDescription extends StatelessWidget {
  final alrtAmountStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    // color: themeContext.textTheme.caption?.color,
  );

  _PaymentAlertDescription({
    Key? key,
    required this.alertTagMessage,
    required this.transactionAmount,
    required this.transactionCurrency,
    required this.senderPaytag,
    required this.walletPaytag,
    required this.createdAt,
    required this.readStatus,
  }) : super(key: key);

  final String alertTagMessage;
  final String transactionAmount;
  final String transactionCurrency;
  final String senderPaytag;
  final String walletPaytag;
  final String createdAt;
  final bool readStatus;

  @override
  Widget build(BuildContext context) {
    ThemeData themeCtx = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              alertTagMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeCtx.textTheme.caption?.color),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            canBeInteger(transactionAmount)
                ? Text(
                    transactionAmount.toShortHumanFormat(
                        currency: "$transactionCurrency "),
                    style: alrtAmountStyle)
                : Container(),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "@$senderPaytag",
                style: TextStyle(
                  color: themeCtx.textTheme.caption?.color,
                  fontSize: 12.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$createdAt',
                    style: TextStyle(
                      color: themeCtx.textTheme.caption?.color,
                      fontSize: 12.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      EvaIcons.diagonalArrowRightUp,
                      size: 12.0,
                      color: !readStatus
                          ? themeCtx.colorScheme.secondary
                          : themeCtx.textTheme.caption?.color,
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

class _PaymentAlertListItem extends StatelessWidget {
  const _PaymentAlertListItem({
    Key? key,
    this.thumbnail,
    required this.alertTagMessage,
    required this.transactionAmount,
    required this.transactionCurrency,
    required this.senderPaytag,
    required this.walletPaytag,
    required this.createdAt,
    required this.readStatus,
  }) : super(key: key);

  final Widget? thumbnail;
  final String alertTagMessage;
  final String transactionAmount;
  final String transactionCurrency;
  final String senderPaytag;
  final String walletPaytag;
  final String createdAt;
  final bool readStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            print('Tapped');
          },
          // onDoubleTap: () {
          //   print('Double Tapped');
          // },
          child: SizedBox(
            height: canBeInteger(transactionAmount) ? 110.0 : 88,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
                    child: _PaymentAlertDescription(
                      alertTagMessage: alertTagMessage,
                      transactionAmount: transactionAmount,
                      transactionCurrency: transactionCurrency,
                      senderPaytag: senderPaytag,
                      walletPaytag: walletPaytag,
                      createdAt: createdAt,
                      readStatus: readStatus,
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

class _WalletsAlerts extends StatelessWidget {
  const _WalletsAlerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserAlertsController uAC = Get.find();
    return SingleChildScrollView(child: Obx(() {
      if (uAC.walletAlertList.isEmpty) {
        return Center(child: Text("Empty"));
      }

      final List fixedList =
          Iterable<int>.generate(uAC.walletAlertList.length).toList();

      final List<Widget> walletTiles = fixedList.map((idx) {
        return _WalletAlertListItem(
          alertTagMessage: AlertTagHelper.alertTagObj(
                  title: "${uAC.walletAlertList[idx]?.alertTag}",
                  tag: AlertTagType.WALLETS)?['message'] ??
              '',
          transactionAmount: "${uAC.walletAlertList[idx]?.amount}",
          transactionCurrency:
              "${uAC.walletAlertList[idx]?.sender?.country?.currencyAbr}",
          senderPaytag: "${uAC.walletAlertList[idx]?.sender?.paytag}",
          walletPaytag:
              "${uAC.walletAlertList[idx]?.initializedTransaction?.wallet?.walletPaytag}",
          createdAt: Jiffy('${uAC.walletAlertList[idx]?.createdAt}')
              .fromNow()
              .toString(),
          readStatus: uAC.walletAlertList[idx]?.readStatus ?? false,
        );
      }).toList();

      return ListView(
        physics: NeverScrollableScrollPhysics(),
        children: walletTiles.length > 0 ? walletTiles : <Widget>[],
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5.0),
      );
    }));
  }
}

class _WalletAlertDescription extends StatelessWidget {
  final alrtAmountStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    // color: themeContext.textTheme.caption?.color,
  );

  _WalletAlertDescription({
    Key? key,
    required this.alertTagMessage,
    required this.transactionAmount,
    required this.transactionCurrency,
    required this.senderPaytag,
    required this.walletPaytag,
    required this.createdAt,
    required this.readStatus,
  }) : super(key: key);

  final String alertTagMessage;
  final String transactionAmount;
  final String transactionCurrency;
  final String senderPaytag;
  final String walletPaytag;
  final String createdAt;
  final bool readStatus;

  @override
  Widget build(BuildContext context) {
    ThemeData themeCtx = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              alertTagMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeCtx.textTheme.caption?.color),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            canBeInteger(transactionAmount)
                ? Text(
                    transactionAmount.toShortHumanFormat(
                        currency: "$transactionCurrency "),
                    style: alrtAmountStyle)
                : Container(),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "@$senderPaytag  ->  @$walletPaytag",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: themeCtx.textTheme.caption?.color,
                  fontSize: 12.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$createdAt',
                    style: TextStyle(
                      color: themeCtx.textTheme.caption?.color,
                      fontSize: 12.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      EvaIcons.diagonalArrowLeftDown,
                      size: 12.0,
                      color: !readStatus
                          ? themeCtx.colorScheme.secondary
                          : themeCtx.textTheme.caption?.color,
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

class _WalletAlertListItem extends StatelessWidget {
  _WalletAlertListItem({
    Key? key,
    this.thumbnail,
    required this.alertTagMessage,
    required this.transactionAmount,
    required this.transactionCurrency,
    required this.senderPaytag,
    required this.walletPaytag,
    required this.createdAt,
    required this.readStatus,
  }) : super(key: key);

  final Widget? thumbnail;
  final String alertTagMessage;
  final String transactionAmount;
  final String transactionCurrency;
  final String senderPaytag;
  final String walletPaytag;
  final String createdAt;
  final bool readStatus;
  final UserAlertsController uAC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            uAC.viewInititalizedTransaction(
                alertTagType: AlertTagType.WALLETS,
                alertId: uAC.walletAlertList[0]?.alertId,
                initializedTransaction:
                    uAC.walletAlertList[0]?.initializedTransaction);
          },
          child: SizedBox(
            height: canBeInteger(transactionAmount) ? 110.0 : 88,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
                    child: _WalletAlertDescription(
                      alertTagMessage: alertTagMessage,
                      transactionAmount: transactionAmount,
                      transactionCurrency: transactionCurrency,
                      senderPaytag: senderPaytag,
                      walletPaytag: walletPaytag,
                      createdAt: createdAt,
                      readStatus: readStatus,
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

enum AlertTagType { PAYMENT, WALLETS }

class AlertTagHelper {
  static alertTagObj(
      {required String title, AlertTagType tag = AlertTagType.PAYMENT}) {
    Map<String?, Map<String, String>?> paymentAlertTagMap = {
      'REQUEST MONEY': {
        'message': 'New  requested  charge',
        'next_action': 'Click to view more details',
      }
    };

    Map<String?, Map<String, String>?> walletAlertTagMap = {
      'SEND MONEY': {
        'message': 'Incoming requested  wallet  payment',
        'next_action': 'Click to view more details',
      }
    };

    if (tag == AlertTagType.WALLETS) {
      return walletAlertTagMap[title] ??
          {
            'message': title,
            'next_action': '',
          };
    }
    return paymentAlertTagMap[title] ??
        {
          'message': title,
          'next_action': '',
        };
  }
}

class WalletAlertTagHelper {}
