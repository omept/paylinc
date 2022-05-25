part of app_helpers;

Future<User?> onAuthenticated(ResponseModel loginRes,
    AuthenticationRepository authenticationRepository) async {
  try {
    AuthController authController = Get.find();
    var locStorageServ = LocalStorageServices();
    await locStorageServ.saveToken(loginRes.data?['access_token']);
    var bankTrnsferCharge = loginRes.data?['transfer_charge'] ?? 0;
    User _user = await locStorageServ.saveUserFromMap(loginRes.data?['user']);

    AppBanks appBanks = AppBanks.fromMap(loginRes.data!);
    locStorageServ.saveAppBanks(appBanks);

    locStorageServ.saveUserStatisticsFromMap(loginRes.data?['statistics']);

    authController.user.value = _user;
    authController.token.value = await locStorageServ.getToken();
    authController.userStatistics.value =
        await locStorageServ.getUserStatistics();
    authController.isAuthenticated = true;
    authController.appBanks.value = appBanks;
    authController.bankTransferCharge.value = bankTrnsferCharge;

    if (_user.otpVerified != true) {
      authenticationRepository.shouldValidateOtp();
      return null;
    }

    if ((_user.userId is int) && (_user.userId! > 0)) {
      authenticationRepository.setLoggedIn();
    }

    authController.updateUserOnsignalId();

    return _user;
  } catch (e) {
    return User();
  }
}

class AppBanks {
  List<Bank?>? appBanksList;
  AppBanks({
    this.appBanksList,
  });

  AppBanks copyWith({
    List<Bank?>? appBanksList,
  }) {
    return AppBanks(
      appBanksList: appBanksList ?? this.appBanksList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'app_banks': appBanksList?.map((x) => x?.toMap()).toList(),
    };
  }

  factory AppBanks.fromMap(Map<dynamic, dynamic> map) {
    return AppBanks(
      appBanksList: map['app_banks'] != null
          ? List<Bank?>.from(map['app_banks']?.map((x) => Bank?.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppBanks.fromJson(String source) =>
      AppBanks.fromMap(json.decode(source));

  @override
  String toString() => 'AppBanks(appBanksList: $appBanksList)';
}
