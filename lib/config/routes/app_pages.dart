import 'package:paylinc/features/admin_dashboard/views/screens/admin_dashboard_screen.dart';
import 'package:paylinc/features/confirm_forgot_password/confirm_forgot_password.dart';
import 'package:paylinc/features/create_wallet/view/create_wallet_screen.dart';
import 'package:paylinc/features/feed_back/views/screens/feed_back_screen.dart';
import 'package:paylinc/features/forgot_password/forgot_password.dart';
import 'package:paylinc/features/initialized_transaction/views/screens/initialized_transaction_screen.dart';
import 'package:paylinc/features/initialized_transactions/views/screens/initialized_transactions_screen.dart';
import 'package:paylinc/features/lock_screen/views/screens/lock_screen_screen.dart';
import 'package:paylinc/features/login/login.dart';
import 'package:paylinc/features/onboarding/view/onboarding_page.dart';
import 'package:paylinc/features/password_update/view/password_update_screen.dart';
import 'package:paylinc/features/pin_update/view/pin_update_screen.dart';
import 'package:paylinc/features/request_money/view/request_money_screen.dart';
import 'package:paylinc/features/send_money/view/send_money_screen.dart';
import 'package:paylinc/features/settings/views/screens/settings_screen.dart';
import 'package:paylinc/features/sign_up/view/sign_up_page.dart';
import 'package:paylinc/features/splash/splash.dart';
import 'package:paylinc/features/transfer/view/transfer_screen.dart';
import 'package:paylinc/features/user_alerts/views/screens/user_alerts_screen.dart';
import 'package:paylinc/features/validate_otp/view/validate_otp_page.dart';
import 'package:paylinc/features/view_stash/views/screens/view_stash_screen.dart';
import 'package:paylinc/features/view_wallet/views/screens/view_wallet_screen.dart';
import 'package:paylinc/features/wallets/views/screens/wallets_screen.dart';

import 'package:paylinc/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:paylinc/utils/utils.dart';

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
      page: () => WalletsScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: WalletsBinding(),
    ),
    GetPage(
      name: _Paths.view_wallet,
      page: () => ViewWalletScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: ViewWalletBinding(),
    ),
    GetPage(
      name: _Paths.view_stash,
      page: () => ViewStashScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: ViewStashBinding(),
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
      name: _Paths.initialized_transaction_no_id,
      page: () => const InitializedTransactionScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: InitializedTransactionBinding(),
      transition: Transition.cupertinoDialog,
      fullscreenDialog: true,
    ),
    GetPage(
      name: _Paths.transfer,
      page: () => const TransferScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: TransferBinding(),
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
      name: _Paths.password_update,
      page: () => const PasswordUpdateScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: PasswordUpdateBindings(),
    ),
    GetPage(
      name: _Paths.lock_screen,
      page: () => const LockScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: LockScreenBinding(),
    ),
    GetPage(
      name: _Paths.pin_update,
      page: () => const PinUpdateScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: PinUpdateBindings(),
    ),
    GetPage(
      name: _Paths.feed_back,
      page: () => const FeedBackScreen(),
      middlewares: [AuthenticatedMiddleware()],
      binding: FeedBackBinding(),
    )
  ];
}
