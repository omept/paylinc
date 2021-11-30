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
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const dashboard = '/dashboard';
  static const wallets = '/wallets';
  static const settings = '/settings';
  static const splash = '/splash';
  static const initialized_transactions = '/initialized-transactions';
  static const admin_dashboard = '/admin-dashboard';
  static const user_alerts = '/user-alerts';
  static const feed_back = '/feed-back';

  // Example :
  // static const index = '/';
  // static const splash = '/splash';
  // static const product = '/product';
}
