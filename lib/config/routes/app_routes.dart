part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const String dashboard = _Paths.dashboard;
  static const String wallets = _Paths.wallets;
  static const String settings = _Paths.settings;
  static const String splash = _Paths.splash;
  static const String initialized_transactions =
      _Paths.initialized_transactions;
  static const String initialized_transaction = _Paths.initialized_transaction;
  static const String initialized_transaction_no_id =
      _Paths.initialized_transaction_no_id;
  static const String admin_dashboard = _Paths.admin_dashboard;
  static const String user_alerts = _Paths.user_alerts;
  static const String feed_back = _Paths.feed_back;
  static const String welcome = _Paths.welcome;
  static const String login = _Paths.login;
  static const String sign_up = _Paths.sign_up;
  static const String forgot_password = _Paths.forgot_password;
  static const String confirm_forgot_password = _Paths.confirm_forgot_password;
  static const String validate_otp = _Paths.validate_otp;

  static const String request_money = _Paths.request_money;
  static const String send_money = _Paths.send_money;

  static const String create_wallet = _Paths.create_wallet;
  static const String view_wallet = _Paths.view_wallet;
  static const String view_stash = _Paths.view_stash;
  static const String transfer = _Paths.transfer;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const String dashboard = '/dashboard';
  static const String wallets = '/wallets';
  static const String view_wallet = '/view-wallet';
  static const String view_stash = '/view-stash';
  static const String settings = '/settings';
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String sign_up = '/sign-up';
  static const String forgot_password = '/forgot-password';
  static const String confirm_forgot_password = '/confirm-forgot-password';
  static const String validate_otp = '/validate-otp';
  static const String initialized_transactions = '/initialized-transactions';
  static const String initialized_transaction =
      '/initialized-transaction/:b64UrlStr';
  static const String initialized_transaction_no_id =
      '/initialized-transaction';
  static const String admin_dashboard = '/admin-dashboard';
  static const String user_alerts = '/user-alerts';
  static const String transfer = '/transfer';
  static const String feed_back = '/feed-back';
  static const String request_money = '/request-money';
  static const String send_money = '/send-money';
  static const String create_wallet = '/create-wallet';
}
