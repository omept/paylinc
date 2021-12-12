part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const dashboard = _Paths.dashboard;
  static const wallets = _Paths.wallets;
  static const settings = _Paths.settings;
  static const splash = _Paths.splash;
  static const initialized_transactions = _Paths.initialized_transactions;
  static const admin_dashboard = _Paths.admin_dashboard;
  static const user_alerts = _Paths.user_alerts;
  static const feed_back = _Paths.feed_back;
  static const welcome = _Paths.welcome;
  static const login = _Paths.login;
  static const sign_up = _Paths.sign_up;
  static const forgot_password = _Paths.forgot_password;
  static const confirm_forgot_password = _Paths.confirm_forgot_password;
  static const validate_otp = _Paths.validate_otp;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const dashboard = '/dashboard';
  static const wallets = '/wallets';
  static const settings = '/settings';
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const login = '/login';
  static const sign_up = '/sign-up';
  static const forgot_password = '/forgot-password';
  static const confirm_forgot_password = '/confirm-forgot-password';
  static const validate_otp = '/validate-otp';
  static const initialized_transactions = '/initialized-transactions';
  static const admin_dashboard = '/admin-dashboard';
  static const user_alerts = '/user-alerts';
  static const feed_back = '/feed-back';

  // Example :
  // static const index = '/';
  // static const splash = '/splash';
  // static const product = '/product';
}
