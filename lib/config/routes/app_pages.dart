import 'package:paylinc/features/admin_dashboard/views/screens/admin_dashboard_screen.dart';
import 'package:paylinc/features/confirm_forgot_password/confirm_forgot_password.dart';
import 'package:paylinc/features/create_wallet/view/create_wallet_screen.dart';
import 'package:paylinc/features/feed_back/views/screens/feed_back_screen.dart';
import 'package:paylinc/features/forgot_password/forgot_password.dart';
import 'package:paylinc/features/initialized_transaction/views/screens/initialized_transaction_screen.dart';
import 'package:paylinc/features/initialized_transactions/views/screens/initialized_transactions_screen.dart';
import 'package:paylinc/features/login/login.dart';
import 'package:paylinc/features/onboarding/view/onboarding_page.dart';
import 'package:paylinc/features/request_money/view/request_money_screen.dart';
import 'package:paylinc/features/send_money/view/send_money_screen.dart';
import 'package:paylinc/features/settings/views/screens/settings_screen.dart';
import 'package:paylinc/features/sign_up/view/sign_up_page.dart';
import 'package:paylinc/features/splash/splash.dart';
import 'package:paylinc/features/user_alerts/views/screens/user_alerts_screen.dart';
import 'package:paylinc/features/validate_otp/view/validate_otp_page.dart';
import 'package:paylinc/features/wallets/views/screens/wallets_screen.dart';

import 'package:paylinc/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:paylinc/utils/middlewares/authenticated.dart';
import 'package:paylinc/utils/middlewares/guest.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.splash;

  static final routes = [
    GetPage(name: _Paths.splash, page: () => SplashPage()),
    GetPage(name: _Paths.welcome, page: () => OnboardingPage()),
    GetPage(
      name: _Paths.login,
      middlewares: [GuestMiddleware()],
      page: () => LoginPage(),
    ),
    GetPage(
      name: _Paths.sign_up,
      page: () => SignUpPage(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: _Paths.forgot_password,
      page: () => ForgotPasswordPage(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: _Paths.confirm_forgot_password,
      page: () => ConfirmForgotPasswordPage(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(name: _Paths.validate_otp, page: () => ValidateOtpPage()),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.wallets,
      page: () => const WalletsScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: WalletsBinding(),
    ),
    GetPage(
      name: _Paths.admin_dashboard,
      page: () => const AdminDashboardScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.request_money,
      page: () => const RequestMoneyScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: RequestMoneyBindings(),
    ),
    GetPage(
      name: _Paths.send_money,
      page: () => const SendMoneyScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: SendMoneyBindings(),
    ),
    GetPage(
      name: _Paths.create_wallet,
      page: () => const CreateWalletScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: CreateWalletBindings(),
    ),
    GetPage(
      name: _Paths.user_alerts,
      page: () => const UserAlertsScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: UserAlertsBinding(),
    ),
    GetPage(
      name: _Paths.initialized_transactions,
      page: () => const InitializedTransactionsScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: InitializedTransactionsBinding(),
    ),
    GetPage(
      name: _Paths.initialized_transaction,
      page: () => const InitializedTransactionScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: InitializedTransactionBinding(),
      transition: Transition.cupertinoDialog,
      fullscreenDialog: true,
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.feed_back,
      page: () => const FeedBackScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: FeedBackBinding(),
    )
  ];
}
