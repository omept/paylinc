library dashboard;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/request_money_card.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/chatting_card.dart';
import 'package:paylinc/shared_components/get_premium_card.dart';
import 'package:paylinc/shared_components/progress_card.dart';
import 'package:paylinc/shared_components/progress_report_card.dart';
import 'package:paylinc/shared_components/send_money_card%20copy.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/task_card.dart';
import 'package:paylinc/shared_components/today_text.dart';
import 'package:paylinc/utils/controllers/auth_controller.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';

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
part '../components/recent_initialized_transaction.dart';

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
                initialSelected: 0,
              )),
        ),
        Flexible(
          flex: 9,
          child: Column(
            children: [
              const SizedBox(height: kSpacing),
              _buildHeader(),
              const SizedBox(height: kSpacing * 2),
              _buildProgress(),
              const SizedBox(height: kSpacing * 2),
              const SizedBox(height: kSpacing * 2)
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
              const SizedBox(height: kSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: GetPremiumCard(onPressed: () {}),
              ),
              const SizedBox(height: kSpacing),
              const Divider(thickness: 1),
              const SizedBox(height: kSpacing),
              // _buildInitializedTransaction(data: controller.getChatting()),
            ],
          ),
        )
      ],
    );

    // return Container();
  }

  Widget _dashboardTabletScreenWidget(context, constraints) {
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
              _buildProgress(
                axis: (constraints.maxWidth < 950)
                    ? Axis.vertical
                    : Axis.horizontal,
              ),
              const SizedBox(height: kSpacing * 2),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: kSpacing * (kIsWeb ? 0.5 : 1.5)),
              _buildProfile(data: controller.getProfil()),
              const Divider(thickness: 1),
              const SizedBox(height: kSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: GetPremiumCard(onPressed: () {}),
              ),
              const SizedBox(height: kSpacing),
              const Divider(thickness: 1),
              const SizedBox(height: kSpacing),
              // _buildInitializedTransaction(data: controller.getChatting()),
            ],
          ),
        )
      ],
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
          child: RequestMoneyCard(onPressed: () {}),
        ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: SendMoneyCard(onPressed: () {}),
        ),
        const SizedBox(height: kSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpacing),
          child: ProgressCard(
            data: const ProgressCardData(totalWallets: 10),
            onPressedCheck: () {},
          ),
        ),
      ]),
    );

    // return Container();
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
            todayText: TodayText(message: "Dashboard"),
          )),
        ],
      ),
    );
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

  Widget _buildProgress({Axis axis = Axis.horizontal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: (axis == Axis.horizontal)
          ? Row(
              children: [
                const Flexible(
                  flex: 4,
                  child: ProgressReportCard(
                    data: ProfileCompletionReportCardData(
                      title: "Your profile",
                      percent: .3,
                    ),
                  ),
                ),
                const SizedBox(width: kSpacing / 2),
                Flexible(
                  flex: 5,
                  child: ProgressCard(
                    data: const ProgressCardData(
                      totalWallets: 10,
                    ),
                    onPressedCheck: () {},
                  ),
                ),
              ],
            )
          : Column(
              children: [
                ProgressCard(
                  data: const ProgressCardData(totalWallets: 10),
                  onPressedCheck: () {},
                ),
                const SizedBox(height: kSpacing / 2),
                const ProgressReportCard(
                  data: ProfileCompletionReportCardData(
                      title: "Your profile", percent: .3),
                ),
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

  Widget _buildInitializedTransaction({required List<ChattingCardData> data}) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: _RecentInitializedTransaction(onPressedMore: () {}),
      ),
      const SizedBox(height: kSpacing / 2),
      ...data
          .map(
            (e) => ChattingCard(data: e, onPressed: () {}),
          )
          .toList(),
    ]);
  }
}
