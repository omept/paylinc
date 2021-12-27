library dashboard;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:paylinc/shared_components/request_money_card.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/wallet_card.dart';
import 'package:paylinc/shared_components/send_money_card%20copy.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/utils/controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// models
part '../../models/profile.dart';

// component
part '../components/profile_tile.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Scaffold(
      key: controller.scaffoldKey,
      // key: controller.scaffoldKey,
      drawer: (!ResponsiveBuilder.isMobile(context))
          ? null
          : Drawer(
              child: Padding(
                padding: const EdgeInsets.only(top: kSpacing),
                child: Sidebar(
                  data: controller.getSelectedProject(),
                  initialSelected: 0,
                ),
              ),
            ),
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        mobileBuilder: _dashboardMobileScreenWidget,
        tabletBuilder: _dashboardTabletScreenWidget,
        desktopBuilder: _dashboardDesktopScreenWidget,
      )),
    );
  }

  Widget _dashboardDesktopScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_dashboardMobileScreenWidget(context, constraints)],
    );

    // return Container();
  }

  Widget _dashboardTabletScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_dashboardMobileScreenWidget(context, constraints)],
    );
  }

  Widget _dashboardMobileScreenWidget(context, constraints) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
        Row(
          children: [
            _menuTogle(onPressedMenu: () => controller.openDrawer()),
            Flexible(child: _buildProfile(data: controller.getProfil())),
          ],
        ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: RequestMoneyCard(),
        ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: SendMoneyCard(onPressed: () {}),
        ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: WalletCard(
            data: WalletCardData(totalWallets: controller.totalWallet),
          ),
        ),
      ]),
    );

    // return Container();
  }

  Widget _menuTogle({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.only(left: kSpacing),
      child: (onPressedMenu != null)
          ? IconButton(
              onPressed: onPressedMenu,
              icon: const Icon(EvaIcons.menu),
              tooltip: "menu",
            )
          : null,
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
