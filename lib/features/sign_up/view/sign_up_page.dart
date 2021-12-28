import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/config/authentication/bloc/authentication_bloc.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/sign_up/sign_up.dart';
import 'package:paylinc/features/sign_up/view/sign_up_form.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/project_card_data.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: _signUpMobileScreenWidget,
          tabletBuilder: _signUpDesktopScreenWidget,
          desktopBuilder: _signUpDesktopScreenWidget,
        ),
      ),
      // }
    );
  }

  Widget _signUpDesktopScreenWidget(context, constraints) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Flexible(
          child: Container(
            height: size.height,
            child: Center(
              child: Container(
                width: 200,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(kSpacing),
                  child: ProjectCard(
                    data: projectCardData(),
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: size.width / 1.5,
                      child: _signUpMobileScreenWidget(context, constraints))
                ],
              ),
            ),
          ),
        ),
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

  Widget _signUpMobileScreenWidget(context, constraints) {
    return MobileSignUp();
  }
}

class MobileSignUp extends StatefulWidget {
  MobileSignUp({Key? key}) : super(key: key);

  @override
  _MobileSignUpState createState() => _MobileSignUpState();
}

class _MobileSignUpState extends State<MobileSignUp> {
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final kTitleStyle = TextStyle(
    fontFamily: 'CM Sans Serif',
    fontSize: 26.0,
    height: 1.5,
  );

  kSubtitleStyle(themeContext) => TextStyle(
        color: themeContext?.textTheme?.caption?.color,
        fontSize: 13.0,
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
    return Builder(builder: (context) {
      var themeContext = Theme.of(context);
      return AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        height: 8.0,
        width: isActive ? 24.0 : 16.0,
        decoration: BoxDecoration(
          color: isActive
              ? themeContext.colorScheme.onBackground
              : themeContext.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var themeContext = Theme.of(context);
    return SafeArea(
      child: Container(
        height: size.height - 60,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kSpacing * 2, vertical: kSpacing / 3),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                      _namePage(themeContext),
                      _paytagPage(themeContext),
                      _emailPage(themeContext),
                      _passwordPage(themeContext),
                      _transferPinPage(themeContext),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage == 0
                      ? Container(
                          child: Builder(builder: (context) {
                            return Align(
                              alignment: FractionalOffset.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(AuthenticationStatusChanged(
                                          AuthenticationStatus
                                              .unauthenticated));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Log in ?',
                                      style: TextStyle(
                                        color: themeContext
                                            .colorScheme.onBackground,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        )
                      : Container(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back,
                                    color:
                                        themeContext.colorScheme.onBackground,
                                    size: 30.0,
                                  ),
                                  SizedBox(width: 10.0),
                                  // Text(
                                  //   'Previous',
                                  //   style: TextStyle(
                                  //     color:
                                  //         themeContext.colorScheme.onBackground,
                                  //     fontSize: 22.0,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  _currentPage == _numPages - 1
                      ? (Expanded(child: _MobileSignUpGetStartedButton()))
                      : Container(),
                  _currentPage == _numPages - 1
                      ? Container()
                      : Container(
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
                                  // Text(
                                  //   'Next',
                                  //   style: TextStyle(
                                  //     color:
                                  //         themeContext.colorScheme.onBackground,
                                  //     fontSize: 22.0,
                                  //   ),
                                  // ),
                                  SizedBox(width: 10.0),
                                  Icon(
                                    Icons.arrow_forward,
                                    color:
                                        themeContext.colorScheme.onBackground,
                                    size: 30.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _countryPage(themeContext) {
  //   return Column(
  //     children: [
  //       Container(
  //         alignment: Alignment.topLeft,
  //         height: 120.0,
  //         child: Padding(
  //           padding: EdgeInsets.all(kSpacing),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(
  //                 "Country",
  //                 style: kTitleStyle,
  //               ),
  //               SizedBox(height: 15.0),
  //               Text(
  //                 'your country has been set. click Next.',
  //                 style: kSubtitleStyle(themeContext),
  //               ),
  //             ],
  //           ),
  //         ),
  //         // ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(kSpacing),
  //         child: CountryInput(),
  //       ),
  //     ],
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   );
  // }

  Widget _emailPage(themeContext) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 120.0,
          child: Padding(
            padding: EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Email",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'enter your email',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: EmailInputField(),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _transferPinPage(themeContext) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 220.0,
          child: Padding(
            padding: EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Transfer Pin",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'set up a 4 digit transfer pin for your account. ',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: TransferPinInput(),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _namePage(themeContext) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 120.0,
          child: Padding(
            padding: EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Name",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Enter your full name.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: NameInput(),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _paytagPage(themeContext) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 120.0,
          child: Padding(
            padding: EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Paytag",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'choose a one time paytag for yourself.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: PaytagInput(),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _passwordPage(themeContext) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 120.0,
          child: Padding(
            padding: EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Password",
                  style: kTitleStyle,
                ),
                SizedBox(height: 15.0),
                Text(
                  'set up your account password.',
                  style: kSubtitleStyle(themeContext),
                ),
              ],
            ),
          ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: PasswordInput(),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}

class _MobileSignUpGetStartedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      // buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: state.status.isSubmissionInProgress
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  )
                : Text(
                    'Get Started',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 22.0,
                    ),
                  ),
            onPressed: () {
              context.read<SignUpBloc>().add(SignUpSubmitted());
            },
          ),
        );
      },
    );
  }
}
