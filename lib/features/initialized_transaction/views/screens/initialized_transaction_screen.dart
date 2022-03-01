library initialized_transaction;

import 'dart:convert';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/models/initializedTransactionB64.dart';
import 'package:paylinc/shared_components/models/user_alerts_response.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/helpers/get_profile.dart';

import 'package:paylinc/shared_components/models/profile.dart';
import 'package:paylinc/utils/services/local_storage_services.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';
import 'package:paylinc/shared_components/shared_components.dart';

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
        return ctrl.pageStatus.value == FormzStatus.submissionInProgress
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
                              Routes.initialized_transactions,
                              Routes.view_wallet,
                            ];
                            if (canGoBack.contains(prvRoute)) {
                              Get.back();
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
                              _TransactionActivityLogs(),
                              _TransactionActivityAction(),
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

class _TransactionActivityLogs extends StatelessWidget {
  const _TransactionActivityLogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InitializedTransactionController ctrl = Get.find();
    return SingleChildScrollView(child: Obx(() {
      var initializedTransaction = ctrl.initializedTransaction.value;
      var authC = ctrl.authController;
      var incoming =
          initializedTransaction.transactionaActivityLogs?.incoming ?? [];
      var outgoing =
          initializedTransaction.transactionaActivityLogs?.outgoing ?? [];

      if (incoming.isEmpty &&
          authC.user.userId == initializedTransaction.recipient?.userId) {
        return Center(child: Text("No incoming activity yet"));
      } else if (outgoing.isEmpty &&
          authC.user.userId == initializedTransaction.sender?.userId) {
        return Center(child: Text("No outgoing activity yet"));
      }
      List<TransactionLogStructure?> trnsDt;
      if (incoming.isNotEmpty &&
          authC.user.userId == initializedTransaction.recipient?.userId) {
        trnsDt = incoming;
      } else if (outgoing.isNotEmpty &&
          authC.user.userId == initializedTransaction.sender?.userId) {
        trnsDt = outgoing;
      } else {
        return Center(child: Text("No activity"));
      }
      return renderList(trnsDt);
    }));
  }

  renderList(List<TransactionLogStructure?> data) {
    final List fixedList = Iterable<int>.generate(data.length).toList();
    final List<Widget> activityTiles = fixedList.map((idx) {
      return _ActivityListItem(
          selectedIndex: idx,
          alertTagMessage: data[idx]?.activityTag ?? '',
          createdAt: data[idx]?.createdAt ?? '');
    }).toList();

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: activityTiles.length > 0 ? activityTiles : <Widget>[],
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 5.0),
    );
  }
}

class _TransactionActivityAction extends StatelessWidget {
  const _TransactionActivityAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeDt = Theme.of(context);
    InitializedTransactionController ctrl = Get.find();
    var initializedTransaction = ctrl.initializedTransaction;
    // var authC = ctrl.authController;
    return SingleChildScrollView(
        child: SizedBox(
      height: 100.0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Obx(() {
              bool showInfo =
                  initializedTransaction.value.initializedTransactionStatus !=
                      null;
              return showInfo
                  ? Row(
                      children: [
                        Text(
                          "Long press  ",
                          style: TextStyle(
                              color: themeDt.textTheme.caption?.color),
                        ),
                        Icon(EvaIcons.infoOutline,
                            size: 12.5,
                            color: themeDt.textTheme.caption?.color),
                      ],
                    )
                  : Container();
            }),
          ),
          statusOptions(initializedTransaction, ctrl, themeDt)
        ],
      ),
    ));
  }

  acceptAndDeclineOpts(Rx<InitializedTransaction> initializedTransaction,
      InitializedTransactionController ctrl, ThemeData themeDt) {
    return Row(
      children: [
        SizedBox(
          width: kSpacing,
        ),
        Expanded(
          child: Obx(() {
            var shwClickable = (initializedTransaction
                        .value.initializedTransactionStatus !=
                    null) &&
                (ctrl.acceptOrDelineable.contains(
                    initializedTransaction.value.initializedTransactionStatus));

            return shwClickable
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kNotifColor,
                    ),
                    onPressed: () {},
                    onLongPress: () {
                      ctrl.acceptTransaction(initializedTransaction.value);
                    },
                    child: Text(
                      "Accept",
                      style: TextStyle(color: themeDt.colorScheme.onBackground),
                    ),
                  )
                : Container();
          }),
        ),
        SizedBox(
          width: kSpacing,
        ),
        Expanded(
          child: Obx(() {
            var shwClickable = (initializedTransaction
                        .value.initializedTransactionStatus !=
                    null) &&
                (ctrl.acceptOrDelineable.contains(
                    initializedTransaction.value.initializedTransactionStatus));
            return shwClickable
                ? ElevatedButton(
                    onPressed: () {},
                    onLongPress: () {
                      ctrl.declineTransaction(initializedTransaction.value);
                    },
                    child: Text(
                      "Decline",
                      style: TextStyle(color: themeDt.colorScheme.onBackground),
                    ),
                  )
                : Container();
          }),
        ),
        SizedBox(
          width: kSpacing,
        )
      ],
    );
  }

  payAndTerminateOpts(Rx<InitializedTransaction> initializedTransaction,
      InitializedTransactionController ctrl, ThemeData themeDt) {
    return Row(
      children: [
        SizedBox(
          width: kSpacing,
        ),
        Expanded(
          child: Obx(() {
            var shwClickable =
                (initializedTransaction.value.initializedTransactionStatus !=
                        null) &&
                    (ctrl.payable.contains(initializedTransaction
                        .value.initializedTransactionStatus)) &&
                    (ctrl.authController.user.userId ==
                        initializedTransaction.value.sender?.userId);

            return shwClickable
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kNotifColor,
                    ),
                    onPressed: () {},
                    onLongPress: () {
                      ctrl.payTransaction(initializedTransaction.value);
                    },
                    child: Text(
                      "Pay",
                      style: TextStyle(color: themeDt.colorScheme.onBackground),
                    ),
                  )
                : Container();
          }),
        ),
        SizedBox(
          width: kSpacing,
        ),
        Expanded(
          child: Obx(() {
            var shwClickable = (initializedTransaction
                        .value.initializedTransactionStatus !=
                    null) &&
                (ctrl.terminatable.contains(
                    initializedTransaction.value.initializedTransactionStatus));
            return shwClickable
                ? ElevatedButton(
                    onPressed: () {},
                    onLongPress: () {
                      ctrl.terminateTransaction(initializedTransaction.value);
                    },
                    child: Text(
                      "Terminate",
                      style: TextStyle(color: themeDt.colorScheme.onBackground),
                    ),
                  )
                : Container();
          }),
        ),
        SizedBox(
          width: kSpacing,
        )
      ],
    );
  }

  Widget statusOptions(Rx<InitializedTransaction> initializedTransaction,
      InitializedTransactionController ctrl, ThemeData themeDt) {
    Widget res;
    int intlzdTrnsctnSts =
        initializedTransaction.value.initializedTransactionStatus ?? -1;
    switch (intlzdTrnsctnSts) {
      case TransactionStatus.pending: // STATUS_PENDING
      case TransactionStatus.requested: // STATUS_REQUESTED
        res = acceptAndDeclineOpts(initializedTransaction, ctrl, themeDt);
        break;
      case TransactionStatus.acceptedNoCard: // STATUS_ACCEPTED_NO_CARD
        res = payAndTerminateOpts(initializedTransaction, ctrl, themeDt);
        break;
      case TransactionStatus.completed: // STATUS_COMPLETE
        res = initializedTransaction.value.sender?.userId ==
                ctrl.authController.user.userId
            ? confrmCompltnAndConflctOpts(initializedTransaction, ctrl, themeDt)
            : refundOpt(initializedTransaction, ctrl, themeDt);
        break;
      case TransactionStatus.completeByPAT: // STATUS_COMPLETE_BY_PAT_COMMAND
        res = initializedTransaction.value.recipient?.userId ==
                ctrl.authController.user.userId
            ? compltAndConflctOpts(initializedTransaction, ctrl, themeDt)
            : conflctOpt(initializedTransaction, ctrl, themeDt);
        break;
      case TransactionStatus.conflict: // STATUS_CONFLICT
        res = refundAndMediateOpts(initializedTransaction, ctrl, themeDt);
        break;
      default:
        res = noOpt(ctrl);
    }
    return res;
  }

  noOpt(InitializedTransactionController ctrl) {
    ctrl.clearTransactionStatus();
    return Container();
  }

  Row confrmCompltnAndConflctOpts(
      Rx<InitializedTransaction> initializedTransaction,
      InitializedTransactionController ctrl,
      ThemeData themeDt) {
    return Row(
      children: [
        SizedBox(
          width: kSpacing,
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kNotifColor,
            ),
            onPressed: () {},
            onLongPress: () {
              ctrl.confirmCompletTransaction(initializedTransaction.value);
            },
            child: Text(
              "Confirm",
              style: TextStyle(color: themeDt.colorScheme.onBackground),
            ),
          ),
        ),
        SizedBox(
          width: kSpacing,
        ),
        conflictBtnTile(ctrl, initializedTransaction, themeDt),
        SizedBox(
          width: kSpacing,
        )
      ],
    );
  }

  Row compltAndConflctOpts(Rx<InitializedTransaction> initializedTransaction,
      InitializedTransactionController ctrl, ThemeData themeDt) {
    return Row(
      children: [
        SizedBox(
          width: kSpacing,
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kNotifColor,
            ),
            onPressed: () {},
            onLongPress: () {
              ctrl.completTransaction(initializedTransaction.value);
            },
            child: Text(
              "Complete",
              style: TextStyle(color: themeDt.colorScheme.onBackground),
            ),
          ),
        ),
        SizedBox(
          width: kSpacing,
        ),
        conflictBtnTile(ctrl, initializedTransaction, themeDt),
        SizedBox(
          width: kSpacing,
        )
      ],
    );
  }

  Row refundAndMediateOpts(Rx<InitializedTransaction> initializedTransaction,
      InitializedTransactionController ctrl, ThemeData themeDt) {
    return Row(
      children: [
        refundTile(ctrl, initializedTransaction, themeDt),
        SizedBox(
          width: kSpacing,
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kNotifColor,
            ),
            onPressed: () {},
            onLongPress: () {
              ctrl.requestTransactionMediation(initializedTransaction.value);
            },
            child: Text(
              "Mediate",
              style: TextStyle(color: themeDt.colorScheme.onBackground),
            ),
          ),
        ),
        SizedBox(
          width: kSpacing,
        )
      ],
    );
  }

  Widget refundTile(InitializedTransactionController ctrl,
      Rx<InitializedTransaction> initializedTransaction, ThemeData themeDt) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kNotifColor,
        ),
        onPressed: () {},
        onLongPress: () {
          ctrl.refundTransaction(initializedTransaction.value);
        },
        child: Text(
          "Refund",
          style: TextStyle(color: themeDt.colorScheme.onBackground),
        ),
      ),
    );
  }

  Expanded conflictBtnTile(InitializedTransactionController ctrl,
      Rx<InitializedTransaction> initializedTransaction, ThemeData themeDt) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        onLongPress: () {
          ctrl.setAsConflictTransaction(initializedTransaction.value);
        },
        child: Text(
          "Confict",
          style: TextStyle(color: themeDt.colorScheme.onBackground),
        ),
      ),
    );
  }

  Row refundOpt(Rx<InitializedTransaction> initializedTransaction,
      InitializedTransactionController ctrl, ThemeData themeDt) {
    return Row(
      children: [
        refundTile(ctrl, initializedTransaction, themeDt),
      ],
    );
  }

  Row conflctOpt(Rx<InitializedTransaction> initializedTransaction,
      InitializedTransactionController ctrl, ThemeData themeDt) {
    return Row(
      children: [
        conflictBtnTile(ctrl, initializedTransaction, themeDt),
      ],
    );
  }
}

class _ActivityListItem extends StatelessWidget {
  _ActivityListItem({
    Key? key,
    required this.selectedIndex,
    required this.alertTagMessage,
    required this.createdAt,
  }) : super(key: key);

  final String alertTagMessage;
  final int selectedIndex;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    ThemeData themeCtx = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        child: SizedBox(
          height: 55.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alertTagMessage.toUpperCase(),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        createdAt,
                        style:
                            TextStyle(color: themeCtx.textTheme.caption?.color),
                      ),
                    ],
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
