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
import 'package:paylinc/config/authentication/controllers/auth_controller.dart';

class Paylinc extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const Paylinc({Key? key, required this.authenticationRepository})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // register controllers, blocs, providers, etc
    return serviceRegistrations();
  }

  //
  Widget serviceRegistrations() {
    // Auth Controller
    Get.put(AuthController(authenticationRepository: authenticationRepository));

    // add Blocs
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

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();
  AuthController authController = Get.find();
  List<AppLifecycleState> stateArr = [];
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    stateArr.add(state);

    switch (state) {
      case AppLifecycleState.inactive:
        _inactive(stateArr);
        break;
      case AppLifecycleState.resumed:
        _resumed(stateArr);
        break;
      default:
        break;
    }
  }

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
                Get.offAllNamed(Routes.welcome);
                break;
              case AuthenticationStatus.signup:
                Get.offAllNamed(Routes.signUp);
                break;
              case AuthenticationStatus.authenticated:
                Get.offAllNamed(Routes.dashboard);
                break;
              case AuthenticationStatus.unauthenticated:
                Get.offAllNamed(Routes.login);
                break;
              case AuthenticationStatus.forgotPassword:
                Get.offAllNamed(Routes.forgotPassword);
                break;
              case AuthenticationStatus.validateOtp:
                Get.offAllNamed(Routes.validateOtp);
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

  void _inactive(List<AppLifecycleState> stateArr) {
    authController.appInactive(stateArr);
  }

  void _resumed(List<AppLifecycleState> stateArr) {
    authController.appResumed(stateArr);
  }
}
