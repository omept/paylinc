library initialized_transaction;

import 'dart:convert';
import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:formz/formz.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/models/initializedTransactionB64.dart';
import 'package:paylinc/shared_components/models/user_alerts_response.dart';
import 'package:paylinc/shared_components/promo_code_tile.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/selected_project.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paylinc/utils/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/helpers/get_profile.dart';

import 'package:paylinc/shared_components/models/profile.dart';
import 'package:paylinc/shared_components/profile_tile.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';
// binding
part '../../bindings/initialized_transaction_binding.dart';

// controller
part '../../controllers/initialized_transaction_controller.dart';

class InitializedTransactionScreen
    extends GetView<InitializedTransactionController> {
  const InitializedTransactionScreen({Key? key}) : super(key: key);

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
        mobileBuilder: _initializedTransactionMobileScreenWidget,
        tabletBuilder: _initializedTransactionTabletScreenWidget,
        desktopBuilder: _initializedTransactionDesktopScreenWidget,
      )),
    );
  }

  Widget _initializedTransactionDesktopScreenWidget(context, constraints) {
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

  Widget _initializedTransactionTabletScreenWidget(context, constraints) {
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

  Widget _initializedTransactionMobileScreenWidget(context, constraints) {
    ThemeData themeCtx = Theme.of(context);
    MediaQueryData mediaQry = MediaQuery.of(context);
    InitializedTransactionController ctrl = Get.find();
    return SafeArea(
      child: Obx(() {
        return ctrl.pageStatus.value != FormzStatus.submissionSuccess
            ? Container(
                height: mediaQry.size.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                      children: [
                        SizedBox(
                          width: kSpacing / 2,
                        ),
                        InkWell(
                          onTap: () {
                            String prvRoute = Get.previousRoute;
                            var canGoBack = [
                              Routes.user_alerts,
                            ];
                            if (canGoBack.contains(prvRoute)) {
                              Get.offNamed(prvRoute);
                            } else {
                              Get.offNamed(Routes.dashboard);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.arrow_back,
                              color: themeCtx.colorScheme.onBackground,
                              size: 30.0,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Initialized Transaction",
                                style: TextStyle(
                                  // color: themeCtx.textTheme.caption?.color,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Obx(() => Text(
                                    "From:  @${ctrl.initializedTransaction.value.sender?.paytag}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: themeCtx.textTheme.caption?.color,
                                      fontSize: 12.0,
                                    ),
                                  )),
                              Obx(() => Text(
                                    "To:  @${ctrl.initializedTransaction.value.recipient?.paytag}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: themeCtx.textTheme.caption?.color,
                                      fontSize: 12.0,
                                    ),
                                  )),
                              Obx(() => Text(
                                    "Wallet:  @${ctrl.initializedTransaction.value.wallet?.walletPaytag ?? ''}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: themeCtx.textTheme.caption?.color,
                                      fontSize: 12.0,
                                    ),
                                  )),
                              Obx(() => Text(
                                    "Date: ${ctrl.initializedTransaction.value.createdAt}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: themeCtx.textTheme.caption?.color,
                                      fontSize: 12.0,
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Amount',
                                      style: TextStyle(
                                        color:
                                            themeCtx.textTheme.caption?.color,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        Obx(() {
                                          return Text(
                                            '${ctrl.initializedTransaction.value.amount?.intHumanFormat()}',
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        }),
                                        Obx(() {
                                          return Text(
                                            '${ctrl.initializedTransaction.value.recipient?.country?.currencyAbr} ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          );
                                        }),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: kSpacing / 2,
                              ),
                              Obx(() {
                                return ctrl.initializedTransaction.value
                                            .promoCode ==
                                        null
                                    ? Container()
                                    : Column(
                                        children: [
                                          Divider(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Promo Code:',
                                                  style: TextStyle(
                                                    color: themeCtx.textTheme
                                                        .caption?.color,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: kSpacing / 2,
                                                ),
                                                PromoCodeTile(
                                                  code: ctrl
                                                          .initializedTransaction
                                                          .value
                                                          .promoCode
                                                          ?.promoCode ??
                                                      '',
                                                  fontSize: 13.5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                        ],
                                      );
                              }),
                              _ActivityLogs(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]);
      }),
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

class _ActivityLogs extends StatelessWidget {
  const _ActivityLogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InitializedTransactionController ctrl = Get.find();
    return SingleChildScrollView(child: Obx(() {
      if (ctrl.activityList.isNotEmpty) {
        // if (ctrl.activityList.isEmpty) {
        return Center(child: Text("No activity yet"));
      }

      // final List fixedList =
      //     Iterable<int>.generate(ctrl.activityList.length).toList();

      final List fixedList = Iterable<int>.generate(8).toList();

      final List<Widget> activityTiles = fixedList.map((idx) {
        return _ActivityListItem(
          selectedIndex: idx,
          alertTagMessage: "sdd",
          transactionAmount: "e43",
          transactionCurrency: "iror",
          senderPaytag: "dsd",
          walletPaytag: "ds",
          createdAt: '434',
          ctrl: ctrl,
        );
      }).toList();

      return ListView(
        physics: NeverScrollableScrollPhysics(),
        children: activityTiles.length > 0 ? activityTiles : <Widget>[],
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5.0),
      );
    }));
  }
}

class _ActivityListItem extends StatelessWidget {
  _ActivityListItem({
    Key? key,
    required this.selectedIndex,
    required this.alertTagMessage,
    required this.transactionAmount,
    required this.transactionCurrency,
    required this.senderPaytag,
    required this.walletPaytag,
    required this.createdAt,
    required this.ctrl,
  }) : super(key: key);

  final String alertTagMessage;
  final int selectedIndex;
  final String transactionAmount;
  final String transactionCurrency;
  final String senderPaytag;
  final String walletPaytag;
  final String createdAt;
  final InitializedTransactionController ctrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        child: SizedBox(
          height: 60.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
                  child: Column(
                    children: [],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
