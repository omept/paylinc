class User {
  int? userId;
  String? name;
  String? profilePicUrl;
  String? email;
  String? paytag;
  int? stashBalance;
  Country? country;
  List<Wallet>? wallets;
  String? createdAt;
  static final empty = User();

  User(
      {this.userId,
      this.name,
      this.profilePicUrl,
      this.email,
      this.paytag,
      this.stashBalance,
      this.country,
      this.wallets,
      this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    profilePicUrl = json['profile_pic_url'];
    email = json['email'];
    paytag = json['paytag'];
    stashBalance = json['stash_balance'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    if (json['wallets'] != null) {
      // wallets = List<Wallet>(3, generator);
      json['wallets'].forEach((v) {
        wallets?.add(new Wallet.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] != null ? map['userId'] : null,
      name: map['name'] != null ? map['name'] : null,
      profilePicUrl: map['profilePicUrl'] != null ? map['profilePicUrl'] : null,
      email: map['email'] != null ? map['email'] : null,
      paytag: map['paytag'] != null ? map['paytag'] : null,
      stashBalance: map['stashBalance'] != null ? map['stashBalance'] : null,
      country: map['country'] != null ? Country.fromMap(map['country']) : null,
      wallets: map['wallets'] != null
          ? List<Wallet>.from(map['wallets']?.map((x) => Wallet.fromMap(x)))
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['profile_pic_url'] = this.profilePicUrl;
    data['email'] = this.email;
    data['paytag'] = this.paytag;
    data['stash_balance'] = this.stashBalance;
    if (this.country != null) {
      data['country'] = this.country?.toJson();
    }
    if (this.wallets != null) {
      data['wallets'] = this.wallets?.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Country {
  String? currencyAbr;
  String? currencyName;
  int? countryId;
  String? countryName;

  Country(
      {this.currencyAbr, this.currencyName, this.countryId, this.countryName});

  Country.fromJson(Map<String, dynamic> json) {
    currencyAbr = json['currency_abr'];
    currencyName = json['currency_name'];
    countryId = json['country_id'];
    countryName = json['country_name'];
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      currencyAbr: map['currencyAbr'] != null ? map['currencyAbr'] : null,
      currencyName: map['currencyName'] != null ? map['currencyName'] : null,
      countryId: map['countryId'] != null ? map['countryId'] : null,
      countryName: map['countryName'] != null ? map['countryName'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_abr'] = this.currencyAbr;
    data['currency_name'] = this.currencyName;
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    return data;
  }
}

class Wallet {
  String? walletPaytag;
  double? balance;

  Wallet({this.walletPaytag, this.balance});

  Wallet.fromJson(Map<String, dynamic> json) {
    walletPaytag = json['wallet_paytag'];
    balance = json['balance'];
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      walletPaytag: map['walletPaytag'] != null ? map['walletPaytag'] : null,
      balance: map['balance'] != null ? map['balance'] : null,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_paytag'] = this.walletPaytag;
    data['balance'] = this.balance;
    return data;
  }
}
