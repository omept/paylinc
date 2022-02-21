import 'dart:convert';

import 'package:flutter/foundation.dart';

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
  int? initializedTransactionId;
  String? createdAt;
  String? action;
  double? amount;
  StashLogData({
    this.initializedTransactionId,
    this.createdAt,
    this.action,
    this.amount,
  });

  StashLogData copyWith({
    int? initializedTransactionId,
    String? createdAt,
    String? action,
    double? amount,
  }) {
    return StashLogData(
      initializedTransactionId:
          initializedTransactionId ?? this.initializedTransactionId,
      createdAt: createdAt ?? this.createdAt,
      action: action ?? this.action,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'initialized_transaction_\id': initializedTransactionId,
      'created_at': createdAt,
      'action': action,
      'amount': amount,
    };
  }

  factory StashLogData.fromMap(Map<String, dynamic> map) {
    return StashLogData(
      initializedTransactionId: map['initialized_transaction_id']?.toInt(),
      createdAt: map['created_at'],
      action: map['action'],
      amount: map['amount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StashLogData.fromJson(String source) =>
      StashLogData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StashLogData(initializedTransactionId: $initializedTransactionId, createdAt: $createdAt, action: $action, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StashLogData &&
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
