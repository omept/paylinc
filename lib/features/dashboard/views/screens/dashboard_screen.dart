library dashboard;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:paylinc/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/chatting_card.dart';
import 'package:paylinc/shared_components/get_premium_card.dart';
import 'package:paylinc/shared_components/list_profil_image.dart';
import 'package:paylinc/shared_components/progress_card.dart';
import 'package:paylinc/shared_components/progress_report_card.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/task_card.dart';
import 'package:paylinc/shared_components/today_text.dart';
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
part '../components/active_project_card.dart';
part '../components/overview_header.dart';
part '../components/profile_tile.dart';
part '../components/recent_messages.dart';
part '../components/team_member.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Scaffold(
      key: this.key,
      // key: controller.scaffoldKey,
      drawer: (ResponsiveBuilder.isDesktop(context))
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
              _buildTaskOverview(
                data: controller.getAllTask(),
                crossAxisCount: 6,
                crossAxisCellCount: (constraints.maxWidth < 1360) ? 3 : 2,
              ),
              const SizedBox(height: kSpacing * 2),
              _buildActiveProject(
                data: controller.getActiveProject(),
                crossAxisCount: 6,
                crossAxisCellCount: (constraints.maxWidth < 1360) ? 3 : 2,
              ),
              const SizedBox(height: kSpacing),
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
              _buildTeamMember(data: controller.getMember()),
              const SizedBox(height: kSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: GetPremiumCard(onPressed: () {}),
              ),
              const SizedBox(height: kSpacing),
              const Divider(thickness: 1),
              const SizedBox(height: kSpacing),
              _buildRecentMessages(data: controller.getChatting()),
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
              _buildTaskOverview(
                data: controller.getAllTask(),
                headerAxis: (constraints.maxWidth < 850)
                    ? Axis.vertical
                    : Axis.horizontal,
                crossAxisCount: 6,
                crossAxisCellCount: (constraints.maxWidth < 950)
                    ? 6
                    : (constraints.maxWidth < 1100)
                        ? 3
                        : 2,
              ),
              const SizedBox(height: kSpacing * 2),
              _buildActiveProject(
                data: controller.getActiveProject(),
                crossAxisCount: 6,
                crossAxisCellCount: (constraints.maxWidth < 950)
                    ? 6
                    : (constraints.maxWidth < 1100)
                        ? 3
                        : 2,
              ),
              const SizedBox(height: kSpacing),
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
              _buildTeamMember(data: controller.getMember()),
              const SizedBox(height: kSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                child: GetPremiumCard(onPressed: () {}),
              ),
              const SizedBox(height: kSpacing),
              const Divider(thickness: 1),
              const SizedBox(height: kSpacing),
              _buildRecentMessages(data: controller.getChatting()),
            ],
          ),
        )
      ],
    );
  }

  Widget _dashboardMobileScreenWidget(context, constraints) {
    return Column(children: [
      const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
      _buildHeader(onPressedMenu: () => controller.openDrawer()),
      const SizedBox(height: kSpacing / 2),
      const Divider(),
      _buildProfile(data: controller.getProfil()),
      const SizedBox(height: kSpacing),
      _buildProgress(axis: Axis.vertical),
      const SizedBox(height: kSpacing),
      _buildTeamMember(data: controller.getMember()),
      const SizedBox(height: kSpacing),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: GetPremiumCard(onPressed: () {}),
      ),
      const SizedBox(height: kSpacing * 2),
      _buildTaskOverview(
        data: controller.getAllTask(),
        headerAxis: Axis.vertical,
        crossAxisCount: 6,
        crossAxisCellCount: 6,
      ),
      const SizedBox(height: kSpacing * 2),
      _buildActiveProject(
        data: controller.getActiveProject(),
        crossAxisCount: 6,
        crossAxisCellCount: 6,
      ),
      const SizedBox(height: kSpacing),
      _buildRecentMessages(data: controller.getChatting()),
    ]);

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

  Widget _buildProgress({Axis axis = Axis.horizontal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: (axis == Axis.horizontal)
          ? Row(
              children: [
                Flexible(
                  flex: 5,
                  child: ProgressCard(
                    data: const ProgressCardData(
                      totalUndone: 10,
                      totalTaskInProress: 2,
                    ),
                    onPressedCheck: () {},
                  ),
                ),
                const SizedBox(width: kSpacing / 2),
                const Flexible(
                  flex: 4,
                  child: ProgressReportCard(
                    data: ProgressReportCardData(
                      title: "1st Sprint",
                      doneTask: 5,
                      percent: .3,
                      task: 3,
                      undoneTask: 2,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                ProgressCard(
                  data: const ProgressCardData(
                    totalUndone: 10,
                    totalTaskInProress: 2,
                  ),
                  onPressedCheck: () {},
                ),
                const SizedBox(height: kSpacing / 2),
                const ProgressReportCard(
                  data: ProgressReportCardData(
                    title: "1st Sprint",
                    doneTask: 5,
                    percent: .3,
                    task: 3,
                    undoneTask: 2,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTaskOverview({
    required List<TaskCardData> data,
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
    Axis headerAxis = Axis.horizontal,
  }) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: crossAxisCount,
      itemCount: data.length + 1,
      addAutomaticKeepAlives: false,
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return (index == 0)
            ? Padding(
                padding: const EdgeInsets.only(bottom: kSpacing),
                child: _OverviewHeader(
                  axis: headerAxis,
                  onSelected: (task) {},
                ),
              )
            : TaskCard(
                data: data[index - 1],
                onPressedMore: () {},
                onPressedTask: () {},
                onPressedContributors: () {},
                onPressedComments: () {},
              );
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.fit((index == 0) ? crossAxisCount : crossAxisCellCount),
    );
  }

  Widget _buildActiveProject({
    required List<ProjectCardData> data,
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: _ActiveProjectCard(
        onPressedSeeAll: () {},
        child: StaggeredGridView.countBuilder(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          itemCount: data.length,
          addAutomaticKeepAlives: false,
          mainAxisSpacing: kSpacing,
          crossAxisSpacing: kSpacing,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ProjectCard(data: data[index]);
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(crossAxisCellCount),
        ),
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

  Widget _buildTeamMember({required List<ImageProvider> data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TeamMember(
            totalMember: data.length,
            onPressedAdd: () {},
          ),
          const SizedBox(height: kSpacing / 2),
          ListProfilImage(maxImages: 6, images: data),
        ],
      ),
    );
  }

  Widget _buildRecentMessages({required List<ChattingCardData> data}) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: _RecentMessages(onPressedMore: () {}),
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
