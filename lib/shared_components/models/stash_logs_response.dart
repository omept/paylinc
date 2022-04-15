part of models;

class StashLogsResponse {
  List<StashLogData?>? stashLogsData;
  StashLogsResponse({
    this.stashLogsData,
  });

  StashLogsResponse copyWith({
    List<StashLogData?>? stashLogsData,
  }) {
    return StashLogsResponse(
      stashLogsData: stashLogsData ?? this.stashLogsData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stash_logs': stashLogsData?.map((x) => x?.toMap()).toList(),
    };
  }

  factory StashLogsResponse.fromMap(Map<dynamic, dynamic> map) {
    return StashLogsResponse(
      stashLogsData: map['stash_logs'] != null
          ? List<StashLogData?>.from(
              map['stash_logs']?.map((x) => StashLogData?.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StashLogsResponse.fromJson(String source) =>
      StashLogsResponse.fromMap(json.decode(source));

  @override
  String toString() => 'StashLogsResponse(stashLogsData: $stashLogsData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StashLogsResponse &&
        listEquals(other.stashLogsData, stashLogsData);
  }

  @override
  int get hashCode => stashLogsData.hashCode;
}

class StashLogData {
  String? createdAt;
  String? action;
  String? accountNumber;
  String? accountName;
  Bank? bank;
  Wallet? wallet;
  double? amount;
  StashLogData({
    this.createdAt,
    this.action,
    this.bank,
    this.wallet,
    this.amount,
    this.accountNumber,
    this.accountName,
  });

  StashLogData copyWith({
    String? createdAt,
    String? action,
    String? accountNumber,
    String? accountName,
    Bank? bank,
    Wallet? wallet,
    double? amount,
  }) {
    return StashLogData(
      createdAt: createdAt ?? this.createdAt,
      action: action ?? this.action,
      bank: bank ?? this.bank,
      wallet: wallet ?? this.wallet,
      amount: amount ?? this.amount,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'action': action,
      'bank': bank?.toMap(),
      'wallet': wallet?.toMap(),
      'amount': amount,
      'account_number': accountNumber,
      'account_name': accountName,
    };
  }

  factory StashLogData.fromMap(Map<String, dynamic> map) {
    return StashLogData(
      createdAt: map['created_at'],
      action: map['action'],
      accountNumber: map['account_number'],
      accountName: map['account_name'],
      bank: map['bank'] != null ? Bank.fromMap(map['bank']) : null,
      wallet: map['wallet'] != null ? Wallet.fromMap(map['wallet']) : null,
      amount: toDouble(map['amount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StashLogData.fromJson(String source) =>
      StashLogData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StashLogData(createdAt: $createdAt, action: $action,  accountNumber: $accountNumber,  accountName: $accountName, bank: $bank, wallet: $wallet, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StashLogData &&
        other.createdAt == createdAt &&
        other.action == action &&
        other.bank == bank &&
        other.wallet == wallet &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        action.hashCode ^
        bank.hashCode ^
        wallet.hashCode ^
        amount.hashCode;
  }
}
