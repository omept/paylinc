import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:paylinc/shared_components/shared_components.dart';
import 'package:paylinc/utils/utils.dart';
import 'package:user_repository/user_repository.dart';

/// contains all service to get data from local
class LocalStorageServices {
  static final LocalStorageServices _localStorageServices =
      LocalStorageServices._internal();

  factory LocalStorageServices() {
    return _localStorageServices;
  }
  LocalStorageServices._internal();

  Future<void> saveToken(String token) async {
    // save auth status for hive storage
    var authTokBox = await Hive.openBox('auth_token');
    authTokBox.put('token', token);
  }

  Future<String> getToken() async {
    // Get auth status from hive storage
    var authTokBox = await Hive.openBox('auth_token');
    return authTokBox.get('token', defaultValue: "");
  }

  Future<User> saveUserFromMap(data) async {
    User user = User.fromMap(data);
    var authTokBox = await Hive.openBox('auth_user');
    authTokBox.put('user', user.toJson());
    return user;
  }

  Future<void> saveUserAlertResponse(UserAlertResponse map) async {
    var userARBox = await Hive.openBox('auth_user_alerts');
    userARBox.put('alerts', map.toJson());
  }

  Future<UserAlertResponse?> getUserAlertResponse() async {
    var userARBox = await Hive.openBox('auth_user_alerts');
    var bxData = userARBox.get('alerts');
    if (bxData != null) {
      return UserAlertResponse.fromMap(json.decode(bxData));
    }
    return null;
  }

  Future<InitializedTransactionsResponse?>
      getInitializedTransactionsResponse() async {
    var userITBox = await Hive.openBox('auth_user_intlzd_trnzcts');
    var bxData = userITBox.get('initialized_tranransactions');
    if (bxData != null) {
      return InitializedTransactionsResponse.fromMap(json.decode(bxData));
    }
    return null;
  }

  Future<void> saveInitializedTransactionsResponse(
      InitializedTransactionsResponse map) async {
    var userITBox = await Hive.openBox('auth_user_intlzd_trnzcts');
    userITBox.put('initialized_tranransactions', map.toJson());
  }

  Future<WalletLogsResponse?> getWalletLogsResponse() async {
    var userITBox = await Hive.openBox('auth_user_wll_lgs');
    var bxData = userITBox.get('wallet_logs');
    if (bxData != null) {
      return WalletLogsResponse.fromMap(json.decode(bxData));
    }
    return null;
  }

  Future<void> saveWalletLogsResponse(WalletLogsResponse map) async {
    var userITBox = await Hive.openBox('auth_user_wll_lgs');
    userITBox.put('wallet_logs', map.toJson());
  }

  Future<StashLogsResponse?> getStashLogsResponse() async {
    var userITBox = await Hive.openBox('auth_user_stsh_lgs');
    var bxData = userITBox.get('stash_logs');
    if (bxData != null) {
      return StashLogsResponse.fromMap(json.decode(bxData));
    }
    return null;
  }

  Future<void> saveStashLogsResponse(StashLogsResponse map) async {
    var userITBox = await Hive.openBox('auth_user_stsh_lgs');
    userITBox.put('stash_logs', map.toJson());
  }

  Future<UserStatistics> saveUserStatisticsFromMap(
      Map<String, dynamic> data) async {
    UserStatistics userStatistics = UserStatistics.fromMap(data);
    var authTokBox = await Hive.openBox('auth_user');
    authTokBox.put('user_statistics', userStatistics.toJson());
    return userStatistics;
  }

  Future<User> getUser() async {
    // Get auth status from hive storage
    var authTokBox = await Hive.openBox('auth_user');
    var userjson = authTokBox.get('user', defaultValue: null);
    return userjson != null ? User.fromJson(userjson) : User();
  }

  Future<UserStatistics> getUserStatistics() async {
    // Get auth status from hive storage
    var authTokBox = await Hive.openBox('auth_user');
    var userStatJson = authTokBox.get('user_statistics', defaultValue: null);
    return userStatJson != null
        ? UserStatistics.fromJson(userStatJson)
        : UserStatistics();
  }

  Future<void> saveInitializedTransactionB64({
    required InitializedTransactionB64 initializedTransactionB64,
  }) async {
    var box = await Hive.openBox('intialized_transaction');
    box.put(
        'initializedTransactionB64', initializedTransactionB64.toBase64Str());
  }

  Future<String?> getInitializedTransactionB64() async {
    var box = await Hive.openBox('intialized_transaction');
    return box.get('initializedTransactionB64', defaultValue: null);
  }

  void saveBiometricSettings(bool value) async {
    var box = await Hive.openBox('applock_biometric_settings');
    return box.put('biometrics_enabled', value);
  }

  Future<bool> getBiometricSettings() async {
    var box = await Hive.openBox('applock_biometric_settings');
    return box.get('biometrics_enabled', defaultValue: false);
  }

  void saveApplockSettings(bool value) async {
    var box = await Hive.openBox('applock_biometric_settings');
    return box.put('applock_enabled', value);
  }

  Future<bool> getApplockSettings() async {
    var box = await Hive.openBox('applock_biometric_settings');
    return box.get('applock_enabled', defaultValue: false);
  }

  void saveAppInactiveAt() async {
    var box = await Hive.openBox('app_inactive');
    box.put('inactive_at', DateTime.now().millisecondsSinceEpoch);
  }

  Future<int?> getAppInactiveAt() async {
    var box = await Hive.openBox('app_inactive');
    return box.get('inactive_at');
  }

  Future<void> saveAppBanks(AppBanks data) async {
    var userITBox = await Hive.openBox('app_settings');
    userITBox.put('app_banks', data.toJson());
  }
}
