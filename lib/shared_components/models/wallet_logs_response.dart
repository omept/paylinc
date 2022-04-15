part of models;

class WalletLogsResponse {
  List<WalletLogData?>? walletLogsData;
  WalletLogsResponse({
    this.walletLogsData,
  });

  WalletLogsResponse copyWith({
    List<WalletLogData?>? walletLogsData,
  }) {
    return WalletLogsResponse(
      walletLogsData: walletLogsData ?? this.walletLogsData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wallet_logs': walletLogsData?.map((x) => x?.toMap()).toList(),
    };
  }

  factory WalletLogsResponse.fromMap(Map<dynamic, dynamic> map) {
    return WalletLogsResponse(
      walletLogsData: map['wallet_logs'] != null
          ? List<WalletLogData?>.from(
              map['wallet_logs']?.map((x) => WalletLogData?.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletLogsResponse.fromJson(String source) =>
      WalletLogsResponse.fromMap(json.decode(source));

  @override
  String toString() => 'WalletLogsResponse(walletLogsData: $walletLogsData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletLogsResponse &&
        listEquals(other.walletLogsData, walletLogsData);
  }

  @override
  int get hashCode => walletLogsData.hashCode;
}

class WalletLogData {
  int? initializedTransactionId;
  String? createdAt;
  String? action;
  double? amount;
  WalletLogData({
    this.initializedTransactionId,
    this.createdAt,
    this.action,
    this.amount,
  });

  WalletLogData copyWith({
    int? initializedTransactionId,
    String? createdAt,
    String? action,
    double? amount,
  }) {
    return WalletLogData(
      initializedTransactionId:
          initializedTransactionId ?? this.initializedTransactionId,
      createdAt: createdAt ?? this.createdAt,
      action: action ?? this.action,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'initialized_transaction_id': initializedTransactionId,
      'created_at': createdAt,
      'action': action,
      'amount': amount,
    };
  }

  factory WalletLogData.fromMap(Map<String, dynamic> map) {
    return WalletLogData(
      initializedTransactionId: toInt(map['initialized_transaction_id']),
      createdAt: map['created_at'],
      action: map['action'],
      amount: toDouble(map['amount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletLogData.fromJson(String source) =>
      WalletLogData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletLogData(initializedTransactionId: $initializedTransactionId, createdAt: $createdAt, action: $action, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletLogData &&
        other.initializedTransactionId == initializedTransactionId &&
        other.createdAt == createdAt &&
        other.action == action &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return initializedTransactionId.hashCode ^
        createdAt.hashCode ^
        action.hashCode ^
        amount.hashCode;
  }
}
