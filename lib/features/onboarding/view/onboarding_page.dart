import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/onboarding/view/components/carousel.dart';
import 'package:paylinc/features/onboarding/view/components/cv_section.dart';
import 'package:paylinc/features/onboarding/view/components/education_section.dart';
import 'package:paylinc/features/onboarding/view/components/footer.dart';
import 'package:paylinc/features/onboarding/view/components/ios_app_ad.dart';
import 'package:paylinc/features/onboarding/view/components/portfolio_stats.dart';
import 'package:paylinc/features/onboarding/view/components/skill_section.dart';
import 'package:paylinc/features/onboarding/view/components/sponsors.dart';
import 'package:paylinc/features/onboarding/view/components/testimonial_widget.dart';
import 'package:paylinc/features/onboarding/view/components/website_ad.dart';
import 'package:paylinc/shared_components/header_item.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/project_image.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: _onboardingPageMobileScreenWidget,
          tabletBuilder: _onboardingPageDesktopScreenWidget,
          desktopBuilder: _onboardingPageDesktopScreenWidget,
        ),
      ),
      // }
    );
  }

  final List<HeaderItem> headerItems = [
    HeaderItem(
      title: "Login",
      onTap: () => Get.offNamed(Routes.login),
      isButton: true,
    ),
    HeaderItem(
        title: "Sign up",
        onTap: () {
          Get.offNamed(Routes.sign_up);
        }),
    HeaderItem(
      title: "Learn More",
      onTap: () {},
    ),
  ];

  Widget _onboardingPageDesktopScreenWidget(context, constraints) {
    const carouselSidePadding = kSpacing * 4;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: kSpacing * 3,
              width: kSpacing * 7,
              child: Center(
                child: HeaderLogo(),
              ),
            ),
            Flexible(
              child: Container(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: headerItems
                          .map(
                            (item) => item.isButton
                                ? MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kDangerColor,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5.0),
                                      child: TextButton(
                                        onPressed: item.onTap,
                                        child: Text(
                                          item.title,
                                          style: menuItemTextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                : MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 30.0),
                                      child: GestureDetector(
                                        onTap: item.onTap,
                                        child: Text(
                                          item.title,
                                          style: menuItemButtonStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              carouselSidePadding, 0, carouselSidePadding, 0),
          child: Carousel(),
        ),
        SizedBox(
          height: kSpacing,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              carouselSidePadding, 0, carouselSidePadding, 0),
          child: Column(
            children: [
              CvSection(),
              IosAppAd(),
              SizedBox(
                height: kSpacing * 3,
              ),
              WebsiteAd(),
              SizedBox(
                height: kSpacing * 2,
              ),
              IosAppAd(),
              SizedBox(
                height: kSpacing * 3,
              ),
              EducationSection(),
              SizedBox(
                height: kSpacing * 2,
              ),
              Sponsors(),
              SizedBox(
                height: kSpacing * 2,
              ),
              Footer(),
            ],
          ),
        ),

        // SizedBox(
        //   height: kSpacing * 3,
        // ),
        // EducationSection(),
        // SizedBox(
        //   height: kSpacing * 2,
        // ),
        // SkillSection(),
        // SizedBox(
        //   height: kSpacing * 2,
        // ),
        // Sponsors(),
        // SizedBox(
        //   height: kSpacing * 2,
        // ),
        // TestimonialWidget(),
      ],
    );
  }

  ProjectCardData getSelectedProject() {
    return ProjectCardData(
      percent: .3,
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Paylinc",
      releaseTime: DateTime.now(),
    );
  }

  Widget _onboardingPageMobileScreenWidget(context, constraints) {
    return Column(children: [
      const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
      const SizedBox(height: kSpacing / 2),
      const Divider(),
    ]);
  }
}

// class _RequestSignUpButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<OnboardingBloc, OnboardingState>(
//       // buildWhen: (previous, current) => previous != current,
//       builder: (context, state) {
//         return ElevatedButton(
//           child: const Text('Request Sign up'),
//           onPressed: () {
//             context.read<OnboardingBloc>().add(const OnboardingRequestSignUp());
//           },
//         );
//       },
//     );
//   }
// }

class HeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: kSpacing),
              Expanded(
                child: Center(
                  child: ProjetImage(
                    image: AssetImage(ImageRasterPath.logo1),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Paylinc",
                            style: menuItemTextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // child: RichText(
          //   text: TextSpan(
          //     children: [
          //       TextSpan(
          //         text: "Paylinc",
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}

TextStyle menuItemButtonStyle({required Color color}) {
  return TextStyle(
    color: color,
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
  );
}

TextStyle menuItemTextStyle({required Color color}) {
  return TextStyle(
    color: color,
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
  );
}
