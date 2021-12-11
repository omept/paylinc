class UserStatistics {
  late int? totalTransactions;
  late double? sent;
  late String? sentInWords;
  late double? received;
  late String? receivedInWords;

  UserStatistics(this.totalTransactions, this.sent, this.sentInWords,
      this.received, this.receivedInWords);

  UserStatistics.fromMap(Map<String, dynamic> map) {
    totalTransactions = int.parse(map['total_transactions'].toString());
    sent = double.parse(map['sent'].toString());
    sentInWords = map['sent_in_words'].toString();
    received = double.parse(map['received'].toString());
    receivedInWords = map['rapeceived_in_words'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_transactions'] = totalTransactions;
    data['sent'] = sent;
    data['sent_in_words'] = sentInWords;
    data['received'] = received;
    data['rapeceived_in_words'] = receivedInWords;
    return data;
  }
}
