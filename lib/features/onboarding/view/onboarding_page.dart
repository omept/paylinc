import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/onboarding/onboarding.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/shared_components/today_text.dart';

class OnboardingPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => OnboardingPage(), settings: routeSettings);
  }

  static final RouteSettings routeSettings = RouteSettings(name: "/welcome");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: _onboardingPageMobileScreenWidget,
          tabletBuilder: _onboardingPageTabletScreenWidget,
          desktopBuilder: _onboardingPageDesktopScreenWidget,
        ),
      ),
      // }
    );
  }

  Widget _onboardingPageDesktopScreenWidget(context, constraints) {
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
              child: Container()),
        ),
        Flexible(
          flex: 9,
          child: Column(
            children: [
              const SizedBox(height: kSpacing),
              _buildHeader(context: context),
              const SizedBox(height: kSpacing * 2),
              const Padding(padding: EdgeInsets.all(12)),
              Text('Onboarding'),
              const Padding(padding: EdgeInsets.all(12)),
              _RequestLoginButton(),
              const Padding(padding: EdgeInsets.all(12)),
              _RequestSignUpButton(),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: kSpacing / 2),
              Text('Welcome Page'),
              const Divider(thickness: 1),
              const SizedBox(height: kSpacing),
            ],
          ),
        )
      ],
    );

    // return Container();
  }

  ProjectCardData getSelectedProject() {
    return ProjectCardData(
      percent: .3,
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Paylinc",
      releaseTime: DateTime.now(),
    );
  }

  Widget _onboardingPageTabletScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: (constraints.maxWidth < 950) ? 6 : 9,
          child: Column(
            children: [
              const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
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

  Widget _onboardingPageMobileScreenWidget(context, constraints) {
    return Column(children: [
      const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
      const SizedBox(height: kSpacing / 2),
      const Divider(),
    ]);
  }

  Widget _buildHeader({Function()? onPressedMenu, context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          Row(
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
                todayText: TodayText(message: "Welcome Page"),
              )),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                child: const Text('middle column '),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RequestLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      // buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return ElevatedButton(
            child: const Text('Request Login'),
            onPressed: () {
              context
                  .read<OnboardingBloc>()
                  .add(const OnboardingRequestLogin());
            });
      },
    );
  }
}

class _RequestSignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      // buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return ElevatedButton(
          child: const Text('Request Sign up'),
          onPressed: () {
            context.read<OnboardingBloc>().add(const OnboardingRequestSignUp());
          },
        );
      },
    );
  }
}
