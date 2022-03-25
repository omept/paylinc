import 'package:paylinc/features/admin_dashboard/views/screens/admin_dashboard_screen.dart';
import 'package:paylinc/features/confirm_forgot_password/confirm_forgot_password.dart';
import 'package:paylinc/features/create_wallet/view/create_wallet_screen.dart';
import 'package:paylinc/features/feed_back/views/screens/feed_back_screen.dart';
import 'package:paylinc/features/forgot_password/forgot_password.dart';
import 'package:paylinc/features/initialized_transaction/views/screens/initialized_transaction_screen.dart';
import 'package:paylinc/features/initialized_transactions/views/screens/initialized_transactions_screen.dart';
import 'package:paylinc/features/lock_screen/views/screens/lock_screen.dart';
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
import 'package:paylinc/utils/middlewares/check_locked.dart';
import 'package:paylinc/utils/utils.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.splash;

  static final routes = [
    GetPage(name: _Paths.splash, page: () => SplashPage()),
    GetPage(
      name: _Paths.welcome,
      page: () => OnboardingPage(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: _Paths.login,
      middlewares: [GuestMiddleware()],
      page: () => LoginPage(),
    ),
    GetPage(
      name: _Paths.signUp,
      page: () => SignUpPage(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: _Paths.forgotPassword,
      page: () => ForgotPasswordPage(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: _Paths.confirmForgotPassword,
      page: () => ConfirmForgotPasswordPage(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
        name: _Paths.validateOtp,
        page: () => ValidateOtpPage(),
        middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()]),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.wallets,
      page: () => WalletsScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: WalletsBinding(),
    ),
    GetPage(
      name: _Paths.viewWallet,
      page: () => ViewWalletScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: ViewWalletBinding(),
    ),
    GetPage(
      name: _Paths.viewStash,
      page: () => ViewStashScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: ViewStashBinding(),
    ),
    GetPage(
      name: _Paths.adminDashboard,
      page: () => const AdminDashboardScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.requestMoney,
      page: () => const RequestMoneyScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: RequestMoneyBindings(),
    ),
    GetPage(
      name: _Paths.sendMoney,
      page: () => const SendMoneyScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: SendMoneyBindings(),
    ),
    GetPage(
      name: _Paths.createWallet,
      page: () => const CreateWalletScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: CreateWalletBindings(),
    ),
    GetPage(
      name: _Paths.userAlerts,
      page: () => const UserAlertsScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: UserAlertsBinding(),
    ),
    GetPage(
      name: _Paths.initializedTransactions,
      page: () => const InitializedTransactionsScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: InitializedTransactionsBinding(),
    ),
    GetPage(
      name: _Paths.initializedTransaction,
      page: () => const InitializedTransactionScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: InitializedTransactionBinding(),
      transition: Transition.cupertinoDialog,
      fullscreenDialog: true,
    ),
    GetPage(
      name: _Paths.initializedTransactionNoId,
      page: () => const InitializedTransactionScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: InitializedTransactionBinding(),
      transition: Transition.cupertinoDialog,
      fullscreenDialog: true,
    ),
    GetPage(
      name: _Paths.transfer,
      page: () => const TransferScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: TransferBinding(),
      transition: Transition.cupertinoDialog,
      fullscreenDialog: true,
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.passwordUpdate,
      page: () => const PasswordUpdateScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: PasswordUpdateBindings(),
    ),
    GetPage(
      name: _Paths.lockScreen,
      page: () => LockScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: LockScreenBinding(),
    ),
    GetPage(
      name: _Paths.pinUpdate,
      page: () => const PinUpdateScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: PinUpdateBindings(),
    ),
    GetPage(
      name: _Paths.feedBack,
      page: () => const FeedBackScreen(),
      middlewares: [AuthenticatedMiddleware(), CheckLockedMiddleware()],
      binding: FeedBackBinding(),
    )
  ];
}
