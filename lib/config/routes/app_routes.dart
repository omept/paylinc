part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const dashboard = _Paths.dashboard;
  static const wallets = _Paths.wallets;
  static const settings = _Paths.settings;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const dashboard = '/dashboard';
  static const wallets = '/wallets';
  static const settings = '/settings';

  // Example :
  // static const index = '/';
  // static const splash = '/splash';
  // static const product = '/product';
}
