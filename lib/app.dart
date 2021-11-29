import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:paylinc/config/authentication/bloc/authentication_bloc.dart';
import 'package:paylinc/features/forgot_password/view/forgot_password_page.dart';
import 'package:paylinc/features/home/view/home_page.dart';
import 'package:paylinc/features/login/view/login_page.dart';
import 'package:paylinc/features/onboarding/onboarding.dart';
import 'package:paylinc/features/sign_up/sign_up.dart';
import 'package:paylinc/features/splash/view/splash_page.dart';
import 'package:paylinc/features/validate_otp/validate_otp.dart';
import 'package:user_repository/user_repository.dart';

class Paylinc extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const Paylinc(
      {Key? key,
      required this.authenticationRepository,
      required this.userRepository})
      : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authenticationRepository),
          RepositoryProvider.value(value: userRepository),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
          ),
        ], child: AppView()));
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.unknown:
                _navigator.pushAndRemoveUntil<void>(
                  OnboardingPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.signup:
                _navigator.pushAndRemoveUntil<void>(
                  SignUpPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                // Get.to(HomePage());
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.forgot_password:
                _navigator.pushAndRemoveUntil<void>(
                  ForgotPasswordPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.validate_otp:
                _navigator.pushAndRemoveUntil<void>(
                  ValidateOtpPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
