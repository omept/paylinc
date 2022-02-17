library initialized_transactions;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/features/user_alerts/views/screens/user_alerts_screen.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/models/initializedTransactionB64.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/shared_components/models/user_alerts_response.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/selected_project.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:paylinc/shared_components/today_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/get_profile.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';

import 'package:paylinc/shared_components/models/profile.dart';
import 'package:paylinc/shared_components/models/initialized_transactions_response.dart';
import 'package:paylinc/shared_components/profile_tile.dart';
import 'package:paylinc/utils/helpers/is_text_an_integer.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';
// binding
part '../../bindings/initialized_transactions_binding.dart';

// controller
part '../../controllers/initialized_transactions_controller.dart';

class InitializedTransactionsScreen
    extends GetView<InitializedTransactionsController> {
  const InitializedTransactionsScreen({Key? key}) : super(key: key);

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
    // MediaQueryData mediaQuery = MediaQuery.of(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(onPressedMenu: () => controller.openDrawer()),
          Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transactions",
                  style: kTitleStyle,
                ),
                SizedBox(height: 8.0),
                Text(
                  'view your most recent initialized transactions.',
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
                        _PaymentTransactions(),
                        _WalletsTransactions(),
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
              child: Header(
            todayText: TodayText(message: "Initiailized Transactions"),
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

class _PaymentTransactions extends StatelessWidget {
  const _PaymentTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InitializedTransactionsController uITC = Get.find();
    return SingleChildScrollView(child: Obx(() {
      if (uITC.paymentTransactionsList.isEmpty) {
        return Center(child: Text("Empty"));
      }

      final List fixedList =
          Iterable<int>.generate(uITC.paymentTransactionsList.length).toList();

      final List<Widget> paymentTiles = fixedList.map((idx) {
        return _PaymentTransactionListItem(
          selectedIndex: idx,
          transactionAmount: "${uITC.paymentTransactionsList[idx]?.amount}",
          transactionCurrency:
              "${uITC.paymentTransactionsList[idx]?.sender?.country?.currencyAbr}",
          senderPaytag: "${uITC.paymentTransactionsList[idx]?.sender?.paytag}",
          walletPaytag:
              "${uITC.paymentTransactionsList[idx]?.wallet?.walletPaytag}",
          createdAt: Jiffy('${uITC.paymentTransactionsList[idx]?.createdAt}')
              .fromNow()
              .toString(),
          status:
              uITC.paymentTransactionsList[idx]?.initializedTransactionStatus ??
                  0,
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

class _PaymentTransactionDescription extends StatelessWidget {
  final alrtAmountStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    // color: themeContext.textTheme.caption?.color,
  );

  _PaymentTransactionDescription({
    Key? key,
    required this.transactionAmount,
    required this.transactionCurrency,
    required this.senderPaytag,
    required this.walletPaytag,
    required this.createdAt,
    required this.status,
  }) : super(key: key);

  final String transactionAmount;
  final String transactionCurrency;
  final String senderPaytag;
  final String walletPaytag;
  final String createdAt;
  final int status;

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
                    child: Icon(EvaIcons.diagonalArrowRightUp,
                        size: 12.0, color: themeCtx.colorScheme.secondary),
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

class _PaymentTransactionListItem extends StatelessWidget {
  _PaymentTransactionListItem({
    Key? key,
    required this.selectedIndex,
    required this.transactionAmount,
    required this.transactionCurrency,
    required this.senderPaytag,
    required this.walletPaytag,
    required this.createdAt,
    required this.status,
  }) : super(key: key);

  final int selectedIndex;
  final String transactionAmount;
  final String transactionCurrency;
  final String senderPaytag;
  final String walletPaytag;
  final String createdAt;
  final int status;

  final InitializedTransactionsController uITC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            uITC.viewInititalizedTransaction(
                selectedIndex: selectedIndex,
                selectedType: AlertTagType.PAYMENT,
                initializedTransaction:
                    uITC.paymentTransactionsList[selectedIndex]);
          },
          child: SizedBox(
            height: 85.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
                    child: _PaymentTransactionDescription(
                      transactionAmount: transactionAmount,
                      transactionCurrency: transactionCurrency,
                      senderPaytag: senderPaytag,
                      walletPaytag: walletPaytag,
                      createdAt: createdAt,
                      status: status,
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

class _WalletsTransactions extends StatelessWidget {
  const _WalletsTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InitializedTransactionsController uITC = Get.find();
    return SingleChildScrollView(child: Obx(() {
      if (uITC.walletTransactionsList.isEmpty) {
        return Center(child: Text("Empty"));
      }

      final List fixedList =
          Iterable<int>.generate(uITC.walletTransactionsList.length).toList();

      final List<Widget> walletTiles = fixedList.map((idx) {
        return _WalletTransactionListItem(
          selectedIndex: idx,
          transactionAmount: "${uITC.walletTransactionsList[idx]?.amount}",
          transactionCurrency:
              "${uITC.walletTransactionsList[idx]?.sender?.country?.currencyAbr}",
          senderPaytag: "${uITC.walletTransactionsList[idx]?.sender?.paytag}",
          walletPaytag:
              "${uITC.walletTransactionsList[idx]?.wallet?.walletPaytag}",
          createdAt: Jiffy('${uITC.walletTransactionsList[idx]?.createdAt}')
              .fromNow()
              .toString(),
          status:
              uITC.walletTransactionsList[idx]?.initializedTransactionStatus ??
                  0,
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

class _WalletTransactionDescription extends StatelessWidget {
  final alrtAmountStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    // color: themeContext.textTheme.caption?.color,
  );

  _WalletTransactionDescription({
    Key? key,
    required this.transactionAmount,
    required this.transactionCurrency,
    required this.senderPaytag,
    required this.walletPaytag,
    required this.createdAt,
    required this.status,
  }) : super(key: key);

  final String transactionAmount;
  final String transactionCurrency;
  final String senderPaytag;
  final String walletPaytag;
  final String createdAt;
  final int status;

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
                      color: themeCtx.colorScheme.secondary,
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

class _WalletTransactionListItem extends StatelessWidget {
  _WalletTransactionListItem({
    Key? key,
    required this.selectedIndex,
    required this.transactionAmount,
    required this.transactionCurrency,
    required this.senderPaytag,
    required this.walletPaytag,
    required this.createdAt,
    required this.status,
  }) : super(key: key);

  final int selectedIndex;
  final String transactionAmount;
  final String transactionCurrency;
  final String senderPaytag;
  final String walletPaytag;
  final String createdAt;
  final int status;
  final InitializedTransactionsController uITC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 1.0,
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            uITC.viewInititalizedTransaction(
                selectedIndex: selectedIndex,
                selectedType: AlertTagType.WALLETS,
                initializedTransaction:
                    uITC.paymentTransactionsList[selectedIndex]);
          },
          child: SizedBox(
            height: 90.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
                    child: _WalletTransactionDescription(
                      transactionAmount: transactionAmount,
                      transactionCurrency: transactionCurrency,
                      senderPaytag: senderPaytag,
                      walletPaytag: walletPaytag,
                      createdAt: createdAt,
                      status: status,
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
