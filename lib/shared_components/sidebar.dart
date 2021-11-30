import 'dart:developer';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/selection_button.dart';
import 'package:paylinc/shared_components/upgrade_premium_card.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    required this.data,
    required this.initialSelected,
    Key? key,
  }) : super(key: key);

  final ProjectCardData data;
  final int initialSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kSpacing),
              child: ProjectCard(
                data: data,
              ),
            ),
            const Divider(thickness: 1),
            SelectionButton(
              initialSelected: initialSelected,
              data: [
                SelectionButtonData(
                  activeIcon: EvaIcons.grid,
                  icon: EvaIcons.gridOutline,
                  label: "Dashboard",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.grid,
                  icon: EvaIcons.gridOutline,
                  label: "Admin Dashboard",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.archive,
                  icon: EvaIcons.archiveOutline,
                  label: "Wallets",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.calendar,
                  icon: EvaIcons.calendarOutline,
                  label: "User Alert",
                  totalNotif: 20,
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.email,
                  icon: EvaIcons.emailOutline,
                  label: "Transactions",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "Settings",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.messageCircleOutline,
                  icon: EvaIcons.messageSquareOutline,
                  label: "Feed Back",
                )
              ],
              onSelected: (index, value) {
                if (value.label == "Dashboard") {
                  // 0
                  Get.offNamed(Routes.dashboard);
                } else if (value.label == "Admin Dashboard") {
                  // 1
                  Get.offNamed(Routes.admin_dashboard);
                } else if (value.label == "Wallets") {
                  // 2
                  Get.offNamed(Routes.wallets);
                } else if (value.label == "User Alert") {
                  // 3
                  Get.offNamed(Routes.user_alerts);
                } else if (value.label == "Transactions") {
                  // 4
                  Get.offNamed(Routes.initialized_transactions);
                } else if (value.label == "Settings") {
                  // 5
                  Get.offNamed(Routes.settings);
                } else if (value.label == "Feed Back") {
                  // 6
                  Get.offNamed(Routes.feed_back);
                }
                // log("index : $index | label : ${value.label}");
              },
            ),
            const Divider(thickness: 1),
            const SizedBox(height: kSpacing * 2),
            UpgradePremiumCard(
              backgroundColor: Theme.of(context).canvasColor.withOpacity(.4),
              onPressed: () {},
            ),
            const SizedBox(height: kSpacing),
          ],
        ),
      ),
    );
  }
}
