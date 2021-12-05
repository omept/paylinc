library wallets;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:paylinc/features/wallets/bloc/wallets_bloc.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/chatting_card.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/task_card.dart';
import 'package:paylinc/shared_components/today_text.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// binding
part '../../bindings/wallets_binding.dart';

// controller
part '../../controllers/wallets_controller.dart';

// models
part '../../models/profile.dart';

// component
part '../components/profile_tile.dart';

class WalletsScreen extends GetView<WalletsController> {
  const WalletsScreen({Key? key}) : super(key: key);

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
                  data: controller.getSelectedProject(),
                  initialSelected: 2,
                ),
              ),
            ),
      body: SingleChildScrollView(
          child: ResponsiveBuilder(
        mobileBuilder: _walletsMobileScreenWidget,
        tabletBuilder: _walletsTabletScreenWidget,
        desktopBuilder: _walletsDesktopScreenWidget,
      )),
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
                data: controller.getSelectedProject(),
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
              _buildProfile(data: controller.getProfil()),
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
    return Column(children: [
      const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
      _buildHeader(onPressedMenu: () => controller.openDrawer()),
      const SizedBox(height: kSpacing / 2),
      const Divider(),
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
            todayText: TodayText(message: "Wallets"),
          )),
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
