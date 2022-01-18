library user_alerts;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/chatting_card.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/today_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// binding
part '../../bindings/user_alerts_binding.dart';

// controller
part '../../controllers/user_alerts_controller.dart';

// models
part '../../models/profile.dart';

// component
part '../components/profile_tile.dart';

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
              _buildProfile(data: controller.getProfil()),
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
      data: controller.getSelectedProject(),
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
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

  Widget _buildProfile({required _Profile data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: _ProfilTile(
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
    return SingleChildScrollView(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (bcontext, index) {
          return Card(
            child: ListTile(
              leading: Text("Leading $index"),
              title: Text("This is a payment"),
              subtitle: Text("This is subtitle"),
            ),
          );
        },
        itemCount: 22,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

class _WalletsAlerts extends StatelessWidget {
  const _WalletsAlerts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (bcontext, index) {
          return Card(
            child: ListTile(
              leading: Text("Leading $index"),
              title: Text("This is a wallet alert"),
              subtitle: Text("This is subtitle"),
            ),
          );
        },
        itemCount: 22,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
