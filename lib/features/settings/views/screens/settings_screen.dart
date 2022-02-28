library settings;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/models/response_model.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/selected_project.dart';
import 'package:paylinc/shared_components/sidebar.dart';
import 'package:paylinc/shared_components/today_text.dart';
import 'package:paylinc/shared_components/models/profile.dart';
import 'package:paylinc/shared_components/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:paylinc/utils/helpers/app_helpers.dart';
import 'package:paylinc/utils/helpers/get_profile.dart';
import 'package:paylinc/utils/services/rest_api_services.dart';

// binding
part '../../bindings/settings_binding.dart';

// controller
part '../../controllers/settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  kFHeadingTextStyle(ThemeData td) => TextStyle(
        fontSize: 14,
        // fontWeight: FontWeight.w600,
        color: td.textTheme.caption?.color,
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
        mobileBuilder: _settingsMobileScreenWidget,
        tabletBuilder: _settingsTabletScreenWidget,
        desktopBuilder: _settingsDesktopScreenWidget,
      )),
    );
  }

  Widget _settingsDesktopScreenWidget(context, constraints) {
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

  Widget _settingsTabletScreenWidget(context, constraints) {
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

  Widget _settingsMobileScreenWidget(context, constraints) {
    ThemeData td = Theme.of(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
          _buildHeader(onPressedMenu: () => controller.openDrawer()),
          const SizedBox(height: kSpacing / 2),
          const Divider(),
          const SizedBox(height: kSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing),
            child: Text("Account", style: kFHeadingTextStyle(td)),
          ),
          _settingsBtn(
            iconData: EvaIcons.person,
            data: "Profile",
            onTap: () => null,
          ),
          _settingsBtn(
            iconData: EvaIcons.npm,
            data: "Banks",
            onTap: () => null,
          ),
          const SizedBox(height: kSpacing + 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing),
            child: Text("Security", style: kFHeadingTextStyle(td)),
          ),
          const SizedBox(height: kSpacing / 2.5),
          _settingsBtn(
            iconData: EvaIcons.personDoneOutline,
            data: "Verification",
            subData: controller.authCtrl.user.customerVerified == true
                ? "Verified"
                : "Not verified",
            subDataColor: td.textTheme.caption?.color,
            onTap: () {
              if (controller.authCtrl.user.customerVerified != true)
                controller.customerVerification();
            },
          ),
          const SizedBox(height: kSpacing / 2.5),
          _settingsBtn(
            iconData: EvaIcons.moreHorizontal,
            data: "PIN",
            subData: "Update your transaction PIN",
            subDataColor: td.textTheme.caption?.color,
            onTap: () => null,
          ),
          const SizedBox(height: kSpacing / 2.5),
          _settingsBtn(
            iconData: EvaIcons.hardDriveOutline,
            data: "2FA",
            subData: "Two-factor authentication",
            subDataColor: td.textTheme.caption?.color,
            onTap: () => null,
          ),
          const SizedBox(height: kSpacing / 2.5),
          _settingsBtn(
            iconData: EvaIcons.shield,
            data: "Password",
            subData: "Last updated on: 22/12/2021",
            subDataColor: td.textTheme.caption?.color,
            onTap: () => controller.authCtrl.toggleBiometricSettings(),
          ),
          const SizedBox(height: kSpacing / 2.5),
          Obx(() => _settingsBtn(
                iconData: EvaIcons.eye,
                data: "Biometric",
                subData: "Unlock app and confirm transactions",
                subDataColor: td.textTheme.caption?.color,
                useRadioBtn: true,
                radioSelected: controller.authCtrl.enableBiometric.value,
                onTap: () => controller.authCtrl.toggleBiometricSettings(),
              )),
          Obx(() => _settingsBtn(
              iconData: EvaIcons.lock,
              data: "App Lock",
              subData: "Lock app when not in use",
              subDataColor: td.textTheme.caption?.color,
              useRadioBtn: true,
              radioSelected: controller.authCtrl.enableAppLock.value,
              onTap: () => controller.authCtrl.toggleAppLockSettings())),
          Divider(),
          _settingsBtn(
            iconData: EvaIcons.logOut,
            data: "Log Out",
            onTap: () => controller.authCtrl.logout(),
          ),
          const SizedBox(height: kSpacing * 1.7),
          appVersion(td),
        ]);
  }

  Widget _settingsBtn(
      {required IconData iconData,
      required String data,
      required Function onTap,
      String? subData,
      Color? subDataColor,
      bool useRadioBtn = false,
      bool radioSelected = false}) {
    return Stack(
      children: [
        SizedBox(
          height: !useRadioBtn ? 50.0 : 70.0,
          child: InkWell(
            onTap: () => onTap(),
            // borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpacing + 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _icon(iconData),
                      const SizedBox(width: kSpacing / 2),
                      _labelText(data,
                          subData: subData, subDataColor: subDataColor),
                    ],
                  ),
                  if (!useRadioBtn) Icon(EvaIcons.arrowRight)
                ],
              ),
            ),
          ),
        ),
        if (useRadioBtn)
          Align(
            alignment: Alignment.centerRight,
            child: _switchIcon(radioSelected, onTap),
          )
      ],
    );
  }

  _switchIcon(bool radioSelected, Function onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: kSpacing),
      child: Switch(
        value: radioSelected,
        onChanged: (val) {
          onTap();
        },
      ),
    );
  }

  Widget _icon(IconData iconData) {
    return Icon(
      iconData,
      size: 25,
    );
  }

  Widget _labelText(String data, {String? subData, Color? subDataColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          data,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            letterSpacing: .8,
            fontSize: 16,
          ),
        ),
        if (subData != null)
          Text(
            subData,
            style: TextStyle(
              color: subDataColor,
              fontSize: 13,
            ),
          ),
      ],
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
          const Expanded(
              child: Header(
            todayText: TodayText(message: "Settings"),
          )),
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
