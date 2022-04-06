part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const String dashboard = _Paths.dashboard;
  static const String wallets = _Paths.wallets;
  static const String settings = _Paths.settings;
  static const String passwordUpdate = _Paths.passwordUpdate;
  static const String pinUpdate = _Paths.pinUpdate;
  static const String splash = _Paths.splash;
  static const String initializedTransactions = _Paths.initializedTransactions;
  static const String initializedTransaction = _Paths.initializedTransaction;
  static const String initializedTransactionNoId =
      _Paths.initializedTransactionNoId;
  static const String adminDashboard = _Paths.adminDashboard;
  static const String addBank = _Paths.addBank;
  static const String userBanks = _Paths.userBanks;
  static const String userAlerts = _Paths.userAlerts;
  static const String feedBack = _Paths.feedBack;
  static const String welcome = _Paths.welcome;
  static const String login = _Paths.login;
  static const String signUp = _Paths.signUp;
  static const String forgotPassword = _Paths.forgotPassword;
  static const String confirmForgotPassword = _Paths.confirmForgotPassword;
  static const String validateOtp = _Paths.validateOtp;
  static const String lockScreen = _Paths.lockScreen;

  static const String requestMoney = _Paths.requestMoney;
  static const String sendMoney = _Paths.sendMoney;

  static const String createWallet = _Paths.createWallet;
  static const String viewWallet = _Paths.viewWallet;
  static const String viewStash = _Paths.viewStash;
  static const String transfer = _Paths.transfer;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const String dashboard = '/dashboard';
  static const String wallets = '/wallets';
  static const String viewWallet = '/view-wallet';
  static const String viewStash = '/view-stash';
  static const String settings = '/settings';
  static const String passwordUpdate = '/password-update';
  static const String pinUpdate = '/pin-update';
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String confirmForgotPassword = '/confirm-forgot-password';
  static const String validateOtp = '/validate-otp';
  static const String initializedTransactions = '/initialized-transactions';
  static const String initializedTransaction =
      '/initialized-transaction/:b64UrlStr';
  static const String initializedTransactionNoId = '/initialized-transaction';
  static const String adminDashboard = '/admin-dashboard';
  static const String userBanks = '/user-banks';
  static const String addBank = '/add-bank';
  static const String userAlerts = '/user-alerts';
  static const String transfer = '/transfer';
  static const String feedBack = '/feed-back';
  static const String requestMoney = '/request-money';
  static const String sendMoney = '/send-money';
  static const String createWallet = '/create-wallet';
  static const String lockScreen = '/lock-screen';
}
