import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:paylinc/shared_components/models/initializedTransactionB64.dart';
import 'package:paylinc/shared_components/models/user_alerts_response.dart';
import 'package:paylinc/shared_components/models/user_statistics.dart';
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

  Future<void> saveUserAlertResonse(UserAlertResonse map) async {
    var userARBox = await Hive.openBox('auth_user_alerts');
    userARBox.put('alerts', map.toJson());
  }

  Future<UserAlertResonse?> getUserAlertResonse() async {
    var userARBox = await Hive.openBox('auth_user_alerts');
    var incomingData = userARBox.get('alerts');
    if (incomingData != null) {
      return UserAlertResonse.fromMap(json.decode(incomingData));
    }
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
}
