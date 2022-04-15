import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:user_repository/src/extra/type_helper.dart';

class User {
  int? userId;
  String? name;
  String? profilePicUrl;
  String? email;
  String? paytag;
  int? stashBalance;
  bool? otpVerified;
  bool? customerVerified;
  Country? country;
  List<Wallet?>? wallets;
  List<UserBank?>? userBanks;
  String? createdAt;
  String? passwordUpdatedAt;
  User({
    this.userId,
    this.name,
    this.profilePicUrl,
    this.email,
    this.paytag,
    this.stashBalance,
    this.otpVerified,
    this.customerVerified,
    this.country,
    this.wallets,
    this.userBanks,
    this.createdAt,
    this.passwordUpdatedAt,
  });
  static final empty = User();

  User copyWith({
    int? userId,
    String? name,
    String? profilePicUrl,
    String? email,
    String? paytag,
    int? stashBalance,
    bool? otpVerified,
    bool? customerVerified,
    Country? country,
    List<Wallet?>? wallets,
    List<UserBank?>? userBanks,
    String? createdAt,
    String? passwordUpdatedAt,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      email: email ?? this.email,
      paytag: paytag ?? this.paytag,
      stashBalance: stashBalance ?? this.stashBalance,
      otpVerified: otpVerified ?? this.otpVerified,
      customerVerified: customerVerified ?? this.customerVerified,
      country: country ?? this.country,
      wallets: wallets ?? this.wallets,
      userBanks: userBanks ?? this.userBanks,
      createdAt: createdAt ?? this.createdAt,
      passwordUpdatedAt: passwordUpdatedAt ?? this.passwordUpdatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'profile_pic_url': profilePicUrl,
      'email': email,
      'paytag': paytag,
      'stash_balance': stashBalance,
      'otp_verified': otpVerified,
      'customer_verified': customerVerified,
      'country': country?.toMap(),
      'wallets': wallets?.map((x) => x?.toMap()).toList(),
      'user_banks': userBanks?.map((x) => x?.toMap()).toList(),
      'created_at': createdAt,
      'password_updated_at': passwordUpdatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: toInt(map['user_id']),
      name: map['name'],
      profilePicUrl: map['profile_pic_url'],
      email: map['email'],
      paytag: map['paytag'],
      stashBalance: toInt(map['stash_balance']),
      otpVerified: map['otp_verified'].toString() == "true",
      customerVerified: map['customer_verified'].toString() == "true",
      country: map['country'] != null ? Country.fromMap(map['country']) : null,
      wallets: map['wallets'] != null
          ? List<Wallet?>.from(map['wallets']?.map((x) => Wallet?.fromMap(x)))
          : null,
      userBanks: map['user_banks'] != null
          ? List<UserBank?>.from(
              map['user_banks']?.map((x) => UserBank?.fromMap(x)))
          : null,
      createdAt: map['created_at'],
      passwordUpdatedAt: map['password_updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromDynamic(source) {
    return User().copyWith(
      userId: source?['user_id'],
      name: source?['name'],
      profilePicUrl: source?['profile_pic_url'],
      email: source?['email'],
      paytag: source?['paytag'],
    );
  }

  @override
  String toString() {
    return 'User(userId: $userId, name: $name, profilePicUrl: $profilePicUrl, email: $email, paytag: $paytag, stashBalance: $stashBalance, otpVerified: $otpVerified,  customerVerified: $customerVerified, country: $country, wallets: $wallets, userBanks: $userBanks, createdAt: $createdAt  password_updated_at: $passwordUpdatedAt )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    Function eq = const ListEquality().equals;
    return other is User &&
        other.userId == userId &&
        other.name == name &&
        other.profilePicUrl == profilePicUrl &&
        other.email == email &&
        other.paytag == paytag &&
        other.stashBalance == stashBalance &&
        other.otpVerified == otpVerified &&
        other.customerVerified == customerVerified &&
        other.country == country &&
        other.createdAt == createdAt &&
        other.passwordUpdatedAt == passwordUpdatedAt &&
        eq(other.wallets, wallets);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        profilePicUrl.hashCode ^
        email.hashCode ^
        paytag.hashCode ^
        stashBalance.hashCode ^
        otpVerified.hashCode ^
        customerVerified.hashCode ^
        country.hashCode ^
        wallets.hashCode ^
        createdAt.hashCode ^
        passwordUpdatedAt.hashCode;
  }
}

class Country {
  final String? currencyAbr;
  final String? currencyName;
  final int? countryId;
  final String? countryName;
  const Country({
    this.currencyAbr,
    this.currencyName,
    this.countryId,
    this.countryName,
  });

  Country copyWith({
    String? currencyAbr,
    String? currencyName,
    int? countryId,
    String? countryName,
  }) {
    return Country(
      currencyAbr: currencyAbr ?? this.currencyAbr,
      currencyName: currencyName ?? this.currencyName,
      countryId: countryId ?? this.countryId,
      countryName: countryName ?? this.countryName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currency_abr': currencyAbr,
      'currency_name': currencyName,
      'country_id': countryId,
      'country_name': countryName,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      currencyAbr: map['currency_abr'],
      currencyName: map['currency_name'],
      countryId: toInt(map['country_id']),
      countryName: map['country_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Country(currencyAbr: $currencyAbr, currencyName: $currencyName, countryId: $countryId, countryName: $countryName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.currencyAbr == currencyAbr &&
        other.currencyName == currencyName &&
        other.countryId == countryId &&
        other.countryName == countryName;
  }

  @override
  int get hashCode {
    return currencyAbr.hashCode ^
        currencyName.hashCode ^
        countryId.hashCode ^
        countryName.hashCode;
  }
}

class Wallet {
  String? walletPaytag;
  double? balance;
  Wallet({
    this.walletPaytag,
    this.balance,
  });

  Wallet copyWith({
    String? walletPaytag,
    double? balance,
  }) {
    return Wallet(
      walletPaytag: walletPaytag ?? this.walletPaytag,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wallet_paytag': walletPaytag,
      'balance': balance,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      walletPaytag: map['wallet_paytag'],
      balance: toDouble(map['balance']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) => Wallet.fromMap(json.decode(source));

  @override
  String toString() => 'Wallet(walletPaytag: $walletPaytag, balance: $balance)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wallet &&
        other.walletPaytag == walletPaytag &&
        other.balance == balance;
  }

  @override
  int get hashCode => walletPaytag.hashCode ^ balance.hashCode;
}

class UserBank {
  int? id;
  Bank? bank;
  String? accountNumber;
  String? accountName;
  UserBank({
    this.id,
    this.bank,
    this.accountNumber,
    this.accountName,
  });

  UserBank copyWith({
    int? id,
    Bank? bank,
    String? accountNumber,
    String? accountName,
  }) {
    return UserBank(
      id: id ?? this.id,
      bank: bank ?? this.bank,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bank': bank?.toMap(),
      'account_number': accountNumber,
      'account_name': accountName,
    };
  }

  factory UserBank.fromMap(Map<String, dynamic> map) {
    return UserBank(
      id: toInt(map['id']),
      bank: map['bank'] != null
          ? Bank?.fromMap(map['bank'] as Map<String, dynamic>)
          : null,
      accountNumber: map['account_number'],
      accountName: map['account_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBank.fromJson(String source) =>
      UserBank.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserBank(id: $id, bank: $bank, accountNumber: $accountNumber, accountName: $accountName)';
  }
}

class Bank {
  int? id;
  String? name;
  String? logoUrl;
  Bank({
    this.id,
    this.name,
    this.logoUrl,
  });

  Bank copyWith({
    int? id,
    String? name,
    String? logoUrl,
  }) {
    return Bank(
      id: id ?? this.id,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo_url': logoUrl,
    };
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      id: toInt(map['id']),
      name: map['name'],
      logoUrl: map['logo_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source));

  @override
  String toString() => 'Bank(id: $id, name: $name, logoUrl: $logoUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bank &&
        other.id == id &&
        other.name == name &&
        other.logoUrl == logoUrl;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logoUrl.hashCode;
}
