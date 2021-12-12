import 'dart:convert';

class UserStatistics {
  late int? totalTransactions;
  late double? sent;
  late String? sentInWords;
  late double? received;
  late String? receivedInWords;

  UserStatistics(
      {this.totalTransactions = 0,
      this.sent = 0,
      this.sentInWords = "0",
      this.received = 0,
      this.receivedInWords = "0"});

  UserStatistics.fromMap(Map<String, dynamic> map) {
    totalTransactions = int.parse(map['total_transactions'].toString());
    sent = double.parse(map['sent'].toString());
    sentInWords = map['sent_in_words'].toString();
    received = double.parse(map['received'].toString());
    receivedInWords = map['received_in_words'].toString();
  }
  Map<String, dynamic> toMap() {
    return {
      'total_transactions': totalTransactions,
      'sent': sent,
      'sent_in_words': sentInWords,
      'received': received,
      'received_in_words': receivedInWords,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserStatistics(totalTransactions: $totalTransactions, sent: $sent, sentInWords: $sentInWords, received: $received, receivedInWords: $receivedInWords)';
  }

  factory UserStatistics.fromJson(String source) =>
      UserStatistics.fromMap(json.decode(source));
}
