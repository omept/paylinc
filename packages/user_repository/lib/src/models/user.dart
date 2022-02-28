import 'dart:convert';

import 'package:collection/collection.dart';

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
  String? createdAt;
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
    this.createdAt,
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
    String? createdAt,
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
      createdAt: createdAt ?? this.createdAt,
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
      'createdAt': createdAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id']?.toInt(),
      name: map['name'],
      profilePicUrl: map['profile_pic_url'],
      email: map['email'],
      paytag: map['paytag'],
      stashBalance: map['stash_balance']?.toInt(),
      otpVerified: map['otp_verified'].toString() == "true",
      customerVerified: map['customer_verified'].toString() == "true",
      country: map['country'] != null ? Country.fromMap(map['country']) : null,
      wallets: map['wallets'] != null
          ? List<Wallet?>.from(map['wallets']?.map((x) => Wallet?.fromMap(x)))
          : null,
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromDynamic(source) {
    return new User().copyWith(
      userId: source?['user_id'],
      name: source?['name'],
      profilePicUrl: source?['profile_pic_url'],
      email: source?['email'],
      paytag: source?['paytag'],
    );
  }

  @override
  String toString() {
    return 'User(userId: $userId, name: $name, profilePicUrl: $profilePicUrl, email: $email, paytag: $paytag, stashBalance: $stashBalance, otpVerified: $otpVerified,  customerVerified: $customerVerified, country: $country, wallets: $wallets, createdAt: $createdAt)';
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
        eq(other.wallets, wallets) &&
        other.createdAt == createdAt;
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
        createdAt.hashCode;
  }
}

class Country {
  String? currencyAbr;
  String? currencyName;
  int? countryId;
  String? countryName;
  Country({
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
      countryId: map['country_id']?.toInt(),
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

  // Wallet({this.walletPaytag, this.balance});

  // Wallet.fromJson(Map<String, dynamic> json) {
  //   walletPaytag = json['wallet_paytag'];
  //   balance = json['balance'];
  // }

  // factory Wallet.fromMap(Map<String, dynamic> map) {
  //   return Wallet(
  //     walletPaytag: map['walletPaytag'] != null ? map['walletPaytag'] : null,
  //     balance: map['balance'] != null ? map['balance'] : null,
  //   );
  // }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['wallet_paytag'] = this.walletPaytag;
  //   data['balance'] = this.balance;
  //   return data;
  // }

  // @override
  // String toString() => 'Wallet(walletPaytag: $walletPaytag, balance: $balance)';

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
      balance: map['balance']?.toDouble(),
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
