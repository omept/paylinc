part of models;

class InitializedTransactionsResponse {
  List<InitializedTransaction?>? incomingInitializedTransactions;
  List<InitializedTransaction?>? outgoingInitializedTransactions;
  InitializedTransactionsResponse({
    this.incomingInitializedTransactions,
    this.outgoingInitializedTransactions,
  });

  InitializedTransactionsResponse copyWith({
    List<InitializedTransaction?>? incomingInitializedTransactions,
    List<InitializedTransaction?>? outgoingInitializedTransactions,
  }) {
    return InitializedTransactionsResponse(
      incomingInitializedTransactions: incomingInitializedTransactions ??
          this.incomingInitializedTransactions,
      outgoingInitializedTransactions: outgoingInitializedTransactions ??
          this.outgoingInitializedTransactions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'incoming_initialized_transactions':
          incomingInitializedTransactions?.map((x) => x?.toMap()).toList(),
      'outgoing_initialized_transactions':
          outgoingInitializedTransactions?.map((x) => x?.toMap()).toList(),
    };
  }

  factory InitializedTransactionsResponse.fromMap(Map<dynamic, dynamic> map) {
    return InitializedTransactionsResponse(
      incomingInitializedTransactions:
          map['incoming_initialized_transactions'] != null
              ? List<InitializedTransaction?>.from(
                  map['incoming_initialized_transactions']
                      ?.map((x) => InitializedTransaction?.fromMap(x)))
              : null,
      outgoingInitializedTransactions:
          map['outgoing_initialized_transactions'] != null
              ? List<InitializedTransaction?>.from(
                  map['outgoing_initialized_transactions']
                      ?.map((x) => InitializedTransaction?.fromMap(x)))
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InitializedTransactionsResponse.fromJson(String source) =>
      InitializedTransactionsResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'InitializedTransactionsResponse(incomingInitializedTransactions: $incomingInitializedTransactions, outgoingInitializedTransactions: $outgoingInitializedTransactions)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InitializedTransactionsResponse &&
        listEquals(other.incomingInitializedTransactions,
            incomingInitializedTransactions) &&
        listEquals(other.outgoingInitializedTransactions,
            outgoingInitializedTransactions);
  }

  @override
  int get hashCode =>
      incomingInitializedTransactions.hashCode ^
      outgoingInitializedTransactions.hashCode;
}
