import 'dart:convert';

import 'package:paylinc/features/user_alerts/views/screens/user_alerts_screen.dart';
import 'package:paylinc/shared_components/models/user_alerts_response.dart';
import 'package:paylinc/utils/helpers/app_helpers.dart';

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
      'alertTagType': alertTagType?.toString(),
      'alertId': alertId,
      'initializedTransaction': initializedTransaction?.toMap(),
    };
  }

  factory InitializedTransactionB64.fromMap(Map<String, dynamic> map) {
    return InitializedTransactionB64(
      alertTagType: map['alertTagType'] != null
          ? (map['alertTagType'].toString() == "${AlertTagType.PAYMENT}"
              ? AlertTagType.PAYMENT
              : AlertTagType.WALLETS)
          : null,
      alertId: map['alertId']?.toInt(),
      initializedTransaction: map['initializedTransaction'] != null
          ? InitializedTransaction.fromMap(map['initializedTransaction'])
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
    return B64Encoder.base64Encode(this.toJson());
  }

  InitializedTransactionB64 fromBase64Str(String intlzdTrnsctnB64Str) {
    return InitializedTransactionB64.fromJson(
        B64Encoder.base64Decode(intlzdTrnsctnB64Str));
  }

  String toBase64UrlStr() {
    return B64Encoder.base64UrlEncode(this.toJson());
  }

  InitializedTransactionB64 fromBase64UrlStr(String intlzdTrnsctnB64Str) {
    return InitializedTransactionB64.fromJson(
        B64Encoder.base64UrlDecode(intlzdTrnsctnB64Str));
  }
}
