import 'package:paylinc/features/admin_dashboard/views/screens/admin_dashboard_screen.dart';
import 'package:paylinc/features/feed_back/views/screens/feed_back_screen.dart';
import 'package:paylinc/features/forgot_password/forgot_password.dart';
import 'package:paylinc/features/initialized_transactions/views/screens/initialized_transactions_screen.dart';
import 'package:paylinc/features/login/login.dart';
import 'package:paylinc/features/onboarding/view/onboarding_page.dart';
import 'package:paylinc/features/settings/views/screens/settings_screen.dart';
import 'package:paylinc/features/sign_up/view/sign_up_page.dart';
import 'package:paylinc/features/splash/splash.dart';
import 'package:paylinc/features/user_alerts/views/screens/user_alerts_screen.dart';
import 'package:paylinc/features/validate_otp/view/validate_otp_page.dart';
import 'package:paylinc/features/wallets/views/screens/wallets_screen.dart';

import 'package:paylinc/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.wallets,
      page: () => const WalletsScreen(),
      binding: WalletsBinding(),
    ),
    GetPage(
      name: _Paths.admin_dashboard,
      page: () => const AdminDashboardScreen(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.user_alerts,
      page: () => const UserAlertsScreen(),
      binding: UserAlertsBinding(),
    ),
    GetPage(
      name: _Paths.initialized_transactions,
      page: () => const InitializedTransactionsScreen(),
      binding: InitializedTransactionsBinding(),
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.feed_back,
      page: () => const FeedBackScreen(),
      binding: FeedBackBinding(),
    ),
    GetPage(name: _Paths.splash, page: () => SplashPage()),
    GetPage(name: _Paths.welcome, page: () => OnboardingPage()),
    GetPage(name: _Paths.login, page: () => LoginPage()),
    GetPage(name: _Paths.sign_up, page: () => SignUpPage()),
    GetPage(name: _Paths.forgot_password, page: () => ForgotPasswordPage()),
    GetPage(name: _Paths.validate_otp, page: () => ValidateOtpPage()),
  ];
}
