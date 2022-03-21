part of models;

class InitializedTransactionB64 {
  final AlertTagType? alertTagType;
  final int? alertId;
  final InitializedTransaction? initializedTransaction;
  InitializedTransactionB64({
    this.alertTagType,
    this.alertId,
    this.initializedTransaction,
  });

  InitializedTransactionB64 copyWith({
    AlertTagType? alertTagType,
    int? alertId,
    InitializedTransaction? initializedTransaction,
  }) {
    return InitializedTransactionB64(
      alertTagType: alertTagType ?? this.alertTagType,
      alertId: alertId ?? this.alertId,
      initializedTransaction:
          initializedTransaction ?? this.initializedTransaction,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alert_tag_type': alertTagType?.toString(),
      'alert_id': alertId,
      'initialized_transaction': initializedTransaction?.toMap(),
    };
  }

  factory InitializedTransactionB64.fromMap(Map<String, dynamic> map) {
    return InitializedTransactionB64(
      alertTagType: map['alert_tag_type'] != null
          ? (map['alert_tag_type'].toString() == "${AlertTagType.payment}"
              ? AlertTagType.payment
              : AlertTagType.wallets)
          : null,
      alertId: map['alert_id']?.toInt(),
      initializedTransaction: map['initialized_transaction'] != null
          ? InitializedTransaction.fromMap(map['initialized_transaction'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InitializedTransactionB64.fromJson(String source) =>
      InitializedTransactionB64.fromMap(json.decode(source));

  @override
  String toString() =>
      'InitializedTransactionB64(alertTagType: $alertTagType, alertId: $alertId, initializedTransaction: $initializedTransaction)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InitializedTransactionB64 &&
        other.alertTagType == alertTagType &&
        other.alertId == alertId &&
        other.initializedTransaction == initializedTransaction;
  }

  @override
  int get hashCode =>
      alertTagType.hashCode ^
      alertId.hashCode ^
      initializedTransaction.hashCode;

  String toBase64Str() {
    return B64Encoder.base64Encode(toJson());
  }

  InitializedTransactionB64 fromBase64Str(String intlzdTrnsctnB64Str) {
    return InitializedTransactionB64.fromJson(
        B64Encoder.base64Decode(intlzdTrnsctnB64Str));
  }

  String toBase64UrlStr() {
    return B64Encoder.base64UrlEncode(toJson());
  }

  InitializedTransactionB64 fromBase64UrlStr(String intlzdTrnsctnB64Str) {
    return InitializedTransactionB64.fromJson(
        B64Encoder.base64UrlDecode(intlzdTrnsctnB64Str));
  }
}
