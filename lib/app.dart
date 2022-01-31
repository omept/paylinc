import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/authentication/bloc/authentication_bloc.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/config/themes/app_theme.dart';
import 'package:paylinc/features/confirm_forgot_password/cubit/confirm_forgot_password_cubit.dart';
import 'package:paylinc/features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:paylinc/features/login/login.dart';
import 'package:paylinc/features/onboarding/onboarding.dart';
import 'package:paylinc/features/sign_up/sign_up.dart';
import 'package:paylinc/features/validate_otp/validate_otp.dart';
import 'package:paylinc/utils/controllers/auth_controller.dart';

class Paylinc extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const Paylinc({Key? key, required this.authenticationRepository})
      : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // register controllers
    Get.put(AuthController(authenticationRepository: authenticationRepository));
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authenticationRepository),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider(create: (context) {
            return ForgotPasswordCubit();
          }),
          BlocProvider(create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          }),
          BlocProvider(create: (context) {
            return SignUpBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          }),
          BlocProvider(create: (context) {
            return OnboardingBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          }),
          BlocProvider(create: (context) {
            return ValidateOtpCubit();
          }),
          BlocProvider(create: (context) {
            return ConfirmForgotPasswordCubit();
          })
        ], child: AppView()));
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.unknown:
                Get.offNamed(Routes.welcome);
                break;
              case AuthenticationStatus.signup:
                Get.offNamed(Routes.sign_up);
                break;
              case AuthenticationStatus.authenticated:
                Get.offNamed(Routes.dashboard);
                break;
              case AuthenticationStatus.unauthenticated:
                Get.offNamed(Routes.login);
                break;
              case AuthenticationStatus.forgot_password:
                Get.offNamed(Routes.forgot_password);
                break;
              case AuthenticationStatus.validate_otp:
                Get.offNamed(Routes.validate_otp);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      theme: AppTheme.basic,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      transitionDuration: Duration(milliseconds: 700),
    );
  }
}
