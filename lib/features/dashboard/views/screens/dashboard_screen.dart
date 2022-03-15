library dashboard;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/shared_components.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paylinc/utils/utils.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

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
                  data: getSelectedProject(),
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
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var maxWidth = 1360;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 4,
          child: Container(
            color: Colors.amberAccent,
            child: Column(
              children: [
                const SizedBox(height: kSpacing / 2),
              ],
            ),
          ),
        ),
        Flexible(
          flex: (mediaQueryData.size.width < maxWidth) ? 4 : 3,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(kBorderRadius),
                bottomRight: Radius.circular(kBorderRadius),
              ),
              child: Sidebar(
                data: getSelectedProject(),
                initialSelected: 0,
              )),
        ),
        Flexible(
          flex: 9,
          child: Column(
            children: [
              const SizedBox(height: kSpacing),
              _dashboardMobileScreenWidget(context, constraints),
              const SizedBox(height: kSpacing * 2),
            ],
          ),
        ),
      ],
    );
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
            Flexible(child: _buildProfile(data: getProfile())),
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
          child: SendMoneyCard(),
        ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: WalletCard(
            onTap: () {
              Get.offNamed(Routes.wallets);
            },
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

  Widget _buildProfile({required Profile data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: ProfilTile(
        data: data,
        onPressedNotification: () {
          Get.offNamed(Routes.user_alerts);
        },
      ),
    );
  }
}
