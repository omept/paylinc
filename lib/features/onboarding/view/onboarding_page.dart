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
import 'package:paylinc/features/onboarding/view/components/sponsors.dart';
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
    return MobileOnBoarding();
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

class MobileOnBoarding extends StatefulWidget {
  MobileOnBoarding({Key? key}) : super(key: key);

  @override
  _MobileOnBoardingState createState() => _MobileOnBoardingState();
}

class _MobileOnBoardingState extends State<MobileOnBoarding> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final kTitleStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'CM Sans Serif',
    fontSize: 26.0,
    height: 1.5,
  );

  final kSubtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    height: 1.2,
  );
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Container(
  //     color: Colors.blue,
  //     height: context.height,
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     stops: [0.1, 0.4, 0.7, 0.9],
      //     colors: [
      //       Color(0xFF3594DD),
      //       Color(0xFF4563DB),
      //       Color(0xFF5036D5),
      //       Color(0xFF5B16D0),
      //     ],
      //   ),
      // ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kSpacing * 2, vertical: kSpacing / 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => print('Skip'),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    _pageOneOnboarding(),
                    _pageOneOnboarding(),
                    _pageOneOnboarding(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: kSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ),
            _currentPage != _numPages - 1
                ? Container(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: kSpacing * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Center _pageOneOnboarding() {
    return Center(
      child: Container(
        height: 450.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSpacing * 2),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/raster/onboarding0.png',
                    ),
                    height: 300.0,
                    width: 300.0,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  '0 Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                  style: kSubtitleStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
