part of shared_components;

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
    var themeContext = Theme.of(context);
    AuthController authController = Get.find<AuthController>();
    return Container(
      color: themeContext.cardColor,
      child: SafeArea(
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
              RouteButton(
                initialSelected: initialSelected,
                data: [
                  RouteButtonData(
                    activeIcon: EvaIcons.grid,
                    icon: EvaIcons.gridOutline,
                    label: "Dashboard",
                  ),
                  // RouteButtonData(
                  //   activeIcon: EvaIcons.grid,
                  //   icon: EvaIcons.gridOutline,
                  //   label: "Admin Dashboard",
                  // ),
                  RouteButtonData(
                    activeIcon: EvaIcons.archive,
                    icon: EvaIcons.archiveOutline,
                    label: "Wallets",
                  ),
                  RouteButtonData(
                    activeIcon: EvaIcons.calendar,
                    icon: EvaIcons.calendarOutline,
                    label: "Alerts",
                    // totalNotif: 20,
                  ),
                  RouteButtonData(
                    activeIcon: EvaIcons.email,
                    icon: EvaIcons.emailOutline,
                    label: "Transactions",
                  ),
                  RouteButtonData(
                    activeIcon: EvaIcons.settings2,
                    icon: EvaIcons.settings2Outline,
                    label: "Settings",
                  ),
                  // RouteButtonData(
                  //   activeIcon: EvaIcons.messageCircleOutline,
                  //   icon: EvaIcons.messageSquareOutline,
                  //   label: "Feed Back",
                  // ),
                  // RouteButtonData(
                  //   activeIcon: EvaIcons.logOut,
                  //   icon: EvaIcons.logOut,
                  //   label: "Log Out",
                  // )
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
                  } else if (value.label == "Alerts") {
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
                  } else if (value.label == "Log Out") {
                    // 6
                    authController.logout();
                  }
                },
              ),
              // const Divider(thickness: 1),
              const SizedBox(height: kSpacing * 2),
            ],
          ),
        ),
      ),
    );
  }
}
