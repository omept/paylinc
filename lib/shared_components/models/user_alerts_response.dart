part of models;

class UserAlertResponse {
  IncomingAlerts? incomingAlerts;
  OutgoingAlerts? outgoingAlerts;
  UserAlertResponse({
    this.incomingAlerts,
    this.outgoingAlerts,
  });

  UserAlertResponse copyWith({
    IncomingAlerts? incomingAlerts,
    OutgoingAlerts? outgoingAlerts,
  }) {
    return UserAlertResponse(
      incomingAlerts: incomingAlerts ?? this.incomingAlerts,
      outgoingAlerts: outgoingAlerts ?? this.outgoingAlerts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'incoming_alerts': incomingAlerts?.toMap(),
      'outgoing_alerts': outgoingAlerts?.toMap(),
    };
  }

  factory UserAlertResponse.fromMap(Map<dynamic, dynamic> map) {
    return UserAlertResponse(
      incomingAlerts: map['incoming_alerts'] != null
          ? IncomingAlerts.fromMap(map['incoming_alerts'])
          : null,
      outgoingAlerts: map['outgoing_alerts'] != null
          ? OutgoingAlerts.fromMap(map['outgoing_alerts'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAlertResponse.fromJson(String source) =>
      UserAlertResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserAlertResponse(incomingAlerts: $incomingAlerts, outgoingAlerts: $outgoingAlerts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserAlertResponse &&
        other.incomingAlerts == incomingAlerts &&
        other.outgoingAlerts == outgoingAlerts;
  }

  @override
  int get hashCode => incomingAlerts.hashCode ^ outgoingAlerts.hashCode;
}

class IncomingAlerts {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;
  List<IncomingAlertsData>? incomingAlertsData;
  IncomingAlerts({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
    this.incomingAlertsData,
  });

  IncomingAlerts copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
    List<IncomingAlertsData>? incomingAlertsData,
  }) {
    return IncomingAlerts(
      currentPage: currentPage ?? this.currentPage,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      links: links ?? this.links,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      to: to ?? this.to,
      total: total ?? this.total,
      incomingAlertsData: incomingAlertsData ?? this.incomingAlertsData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_page': currentPage,
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links?.map((x) => x.toMap()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
      'data': incomingAlertsData?.map((x) => x.toMap()).toList(),
    };
  }

  factory IncomingAlerts.fromMap(Map<String, dynamic> map) {
    return IncomingAlerts(
      currentPage: map['current_page']?.toInt(),
      firstPageUrl: map['first_page_url'],
      from: map['from']?.toInt(),
      lastPage: map['last_page']?.toInt(),
      lastPageUrl: map['last_page_url'],
      links: map['links'] != null
          ? List<Links>.from(map['links']?.map((x) => Links.fromMap(x)))
          : null,
      nextPageUrl: map['next_page_url'],
      path: map['path'],
      perPage: map['per_page']?.toInt(),
      prevPageUrl: map['prev_page_url'],
      to: map['to']?.toInt(),
      total: map['total']?.toInt(),
      incomingAlertsData: map['data'] != null
          ? List<IncomingAlertsData>.from(
              map['data']?.map((x) => IncomingAlertsData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomingAlerts.fromJson(String source) =>
      IncomingAlerts.fromMap(json.decode(source));

  @override
  String toString() {
    return 'IncomingAlerts(currentPage: $currentPage, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total, incomingAlertsData: $incomingAlertsData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IncomingAlerts &&
        other.currentPage == currentPage &&
        other.firstPageUrl == firstPageUrl &&
        other.from == from &&
        other.lastPage == lastPage &&
        other.lastPageUrl == lastPageUrl &&
        listEquals(other.links, links) &&
        other.nextPageUrl == nextPageUrl &&
        other.path == path &&
        other.perPage == perPage &&
        other.prevPageUrl == prevPageUrl &&
        other.to == to &&
        other.total == total &&
        listEquals(other.incomingAlertsData, incomingAlertsData);
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        firstPageUrl.hashCode ^
        from.hashCode ^
        lastPage.hashCode ^
        lastPageUrl.hashCode ^
        links.hashCode ^
        nextPageUrl.hashCode ^
        path.hashCode ^
        perPage.hashCode ^
        prevPageUrl.hashCode ^
        to.hashCode ^
        total.hashCode ^
        incomingAlertsData.hashCode;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;
  Links({
    this.url,
    this.label,
    this.active,
  });

  Links copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return Links(
      url: url ?? this.url,
      label: label ?? this.label,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }

  factory Links.fromMap(Map<String, dynamic> map) {
    return Links(
      url: map['url'],
      label: map['label'],
      active: map['active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Links.fromJson(String source) => Links.fromMap(json.decode(source));

  @override
  String toString() => 'Links(url: $url, label: $label, active: $active)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Links &&
        other.url == url &&
        other.label == label &&
        other.active == active;
  }

  @override
  int get hashCode => url.hashCode ^ label.hashCode ^ active.hashCode;
}

class IncomingAlertsData {
  int? alertId;
  String? alertTag;
  User? sender;
  int? referenceId;
  InitializedTransaction? initializedTransaction;
  int? amount;
  int? status;
  String? createdAt;
  bool? readStatus;
  IncomingAlertsData({
    this.alertId,
    this.alertTag,
    this.sender,
    this.referenceId,
    this.initializedTransaction,
    this.amount,
    this.status,
    this.createdAt,
    this.readStatus,
  });

  IncomingAlertsData copyWith({
    int? alertId,
    String? alertTag,
    User? sender,
    int? referenceId,
    InitializedTransaction? initializedTransaction,
    int? amount,
    int? status,
    String? createdAt,
    bool? readStatus,
  }) {
    return IncomingAlertsData(
      alertId: alertId ?? this.alertId,
      alertTag: alertTag ?? this.alertTag,
      sender: sender ?? this.sender,
      referenceId: referenceId ?? this.referenceId,
      initializedTransaction:
          initializedTransaction ?? this.initializedTransaction,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      readStatus: readStatus ?? this.readStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alert_id': alertId,
      'alert_tag': alertTag,
      'sender': sender?.toMap(),
      'reference_id': referenceId,
      'initialized_transaction': initializedTransaction?.toMap(),
      'amount': amount,
      'status': status,
      'created_at': createdAt,
      'read_status': readStatus,
    };
  }

  factory IncomingAlertsData.fromMap(Map<String, dynamic> map) {
    return IncomingAlertsData(
      alertId: map['alert_id']?.toInt(),
      alertTag: map['alert_tag'],
      sender: map['sender'] != null ? User.fromMap(map['sender']) : null,
      referenceId: map['reference_id']?.toInt(),
      initializedTransaction: map['initialized_transaction'] != null
          ? InitializedTransaction.fromMap(map['initialized_transaction'])
          : null,
      amount: map['amount']?.toInt(),
      status: map['status']?.toInt(),
      createdAt: map['created_at'],
      readStatus: map['read_status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomingAlertsData.fromJson(String source) =>
      IncomingAlertsData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'IncomingAlertsData(alertId: $alertId, alertTag: $alertTag, sender: $sender, referenceId: $referenceId, initializedTransaction: $initializedTransaction, amount: $amount, status: $status, createdAt: $createdAt, readStatus: $readStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IncomingAlertsData &&
        other.alertId == alertId &&
        other.alertTag == alertTag &&
        other.sender == sender &&
        other.referenceId == referenceId &&
        other.initializedTransaction == initializedTransaction &&
        other.amount == amount &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.readStatus == readStatus;
  }

  @override
  int get hashCode {
    return alertId.hashCode ^
        alertTag.hashCode ^
        sender.hashCode ^
        referenceId.hashCode ^
        initializedTransaction.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        readStatus.hashCode;
  }
}

class InitializedTransaction {
  int? id;
  int? initializedTransactionStatus;
  String? initializedTransactionDescription;
  String? initializedTransactionDeclinationReason;
  String? initializedTransactionConflictReason;
  User? recipient;
  User? sender;
  int? amount;
  String? createdAt;
  String? transactionCheckoutUrl;
  String? transactionMediationUrl;
  Wallet? wallet;
  TransactionPromoCode? promoCode;
  TransactionaActivityLogs? transactionaActivityLogs;
  InitializedTransaction({
    this.id,
    this.initializedTransactionStatus,
    this.initializedTransactionDescription,
    this.initializedTransactionDeclinationReason,
    this.initializedTransactionConflictReason,
    this.recipient,
    this.sender,
    this.amount,
    this.createdAt,
    this.transactionCheckoutUrl,
    this.transactionMediationUrl,
    this.wallet,
    this.promoCode,
    this.transactionaActivityLogs,
  });

  // InitializedTransaction copyWith({
  //   int? id,
  //   int? initializedTransactionStatus,
  //   String? initializedTransactionDescription,
  //   String? initializedTransactionDeclinationReason,
  //   String? initializedTransactionConflictReason,
  //   User? recipient,
  //   User? sender,
  //   int? amount,
  //   String? createdAt,
  //   Wallet? wallet,
  //   TransactionPromoCode? promoCode,
  // }) {
  //   return InitializedTransaction(
  //     id: id ?? this.id,
  //     initializedTransactionStatus:
  //         initializedTransactionStatus ?? this.initializedTransactionStatus,
  //     initializedTransactionDescription: initializedTransactionDescription ??
  //         this.initializedTransactionDescription,
  //     initializedTransactionDeclinationReason:
  //         initializedTransactionDeclinationReason ??
  //             this.initializedTransactionDeclinationReason,
  //     initializedTransactionConflictReason:
  //         initializedTransactionConflictReason ??
  //             this.initializedTransactionConflictReason,
  //     recipient: recipient ?? this.recipient,
  //     sender: sender ?? this.sender,
  //     amount: amount ?? this.amount,
  //     createdAt: createdAt ?? this.createdAt,
  //     transactionCheckoutUrl:
  //         transactionCheckoutUrl ?? this.transactionCheckoutUrl,
  //     transactionMediationUrl:
  //         transactionMediationUrl ?? this.transactionMediationUrl,
  //     wallet: wallet ?? this.wallet,
  //     promoCode: promoCode ?? this.promoCode,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'initialized_transaction_status': initializedTransactionStatus,
      'initialized_transaction_description': initializedTransactionDescription,
      'initialized_transaction_declination_reason':
          initializedTransactionDeclinationReason,
      'initialized_transaction_conflict_reason':
          initializedTransactionConflictReason,
      'recipient': recipient?.toMap(),
      'sender': sender?.toMap(),
      'amount': amount,
      'created_at': createdAt,
      'transaction_checkout_url': transactionCheckoutUrl,
      'transaction_mediation_url': transactionMediationUrl,
      'wallet': wallet?.toMap(),
      'promo_code': promoCode?.toMap(),
      'transactiona_ctivity_logs': transactionaActivityLogs?.toMap(),
    };
  }

  factory InitializedTransaction.fromMap(Map<String, dynamic> map) {
    return InitializedTransaction(
      id: map['id']?.toInt(),
      initializedTransactionStatus:
          map['initialized_transaction_status']?.toInt(),
      initializedTransactionDescription:
          map['initialized_transaction_description'],
      initializedTransactionDeclinationReason:
          map['initialized_transaction_declination_reason'],
      initializedTransactionConflictReason:
          map['initialized_transaction_conflict_reason'],
      recipient:
          map['recipient'] != null ? User.fromMap(map['recipient']) : null,
      sender: map['sender'] != null ? User.fromMap(map['sender']) : null,
      amount: map['amount']?.toInt(),
      createdAt: map['created_at']?.toString() ?? '',
      transactionCheckoutUrl: map['transaction_checkout_url']?.toString() ?? '',
      transactionMediationUrl:
          map['transaction_mediation_url']?.toString() ?? '',
      wallet: map['wallet'] != null
          ? Wallet.fromMap(TransactionWallet.fromMap(map['wallet']).toMap())
          : null,
      promoCode: map['promo_code'] != null
          ? TransactionPromoCode.fromMap(map['promo_code'])
          : null,
      transactionaActivityLogs: map['transaction_activity_logs'] != null
          ? TransactionaActivityLogs.fromMap(map['transaction_activity_logs'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InitializedTransaction.fromJson(String source) =>
      InitializedTransaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InitializedTransaction(id: $id, initializedTransactionStatus: $initializedTransactionStatus, initializedTransactionDescription: $initializedTransactionDescription, initializedTransactionDeclinationReason: $initializedTransactionDeclinationReason, initializedTransactionConflictReason: $initializedTransactionConflictReason, recipient: $recipient, sender: $sender, amount: $amount, createdAt: $createdAt,  transactionCheckoutUrl: $transactionCheckoutUrl, transactionMediationUrl: $transactionMediationUrl, wallet: $wallet, promoCode: $promoCode transactionaActivityLogs: $transactionaActivityLogs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InitializedTransaction &&
        other.id == id &&
        other.initializedTransactionStatus == initializedTransactionStatus &&
        other.initializedTransactionDescription ==
            initializedTransactionDescription &&
        other.initializedTransactionDeclinationReason ==
            initializedTransactionDeclinationReason &&
        other.initializedTransactionConflictReason ==
            initializedTransactionConflictReason &&
        other.recipient == recipient &&
        other.sender == sender &&
        other.amount == amount &&
        other.createdAt == createdAt &&
        other.wallet == wallet &&
        other.promoCode == promoCode &&
        other.transactionaActivityLogs == transactionaActivityLogs;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        initializedTransactionStatus.hashCode ^
        initializedTransactionDescription.hashCode ^
        initializedTransactionDeclinationReason.hashCode ^
        initializedTransactionConflictReason.hashCode ^
        recipient.hashCode ^
        sender.hashCode ^
        amount.hashCode ^
        createdAt.hashCode ^
        wallet.hashCode ^
        promoCode.hashCode ^
        transactionaActivityLogs.hashCode ^
        transactionCheckoutUrl.hashCode ^
        transactionMediationUrl.hashCode;
  }
}

class OutgoingAlerts {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;
  List<OutgoingAlertsData>? outgoingAlertsData;
  OutgoingAlerts({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
    this.outgoingAlertsData,
  });

  OutgoingAlerts copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
    List<OutgoingAlertsData>? outgoingAlertsData,
  }) {
    return OutgoingAlerts(
      currentPage: currentPage ?? this.currentPage,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      links: links ?? this.links,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      to: to ?? this.to,
      total: total ?? this.total,
      outgoingAlertsData: outgoingAlertsData ?? this.outgoingAlertsData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_page': currentPage,
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links?.map((x) => x.toMap()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
      'data': outgoingAlertsData?.map((x) => x.toMap()).toList(),
    };
  }

  factory OutgoingAlerts.fromMap(Map<String, dynamic> map) {
    return OutgoingAlerts(
      currentPage: map['current_page']?.toInt(),
      firstPageUrl: map['first_page_url'],
      from: map['from']?.toInt(),
      lastPage: map['last_page']?.toInt(),
      lastPageUrl: map['last_page_url'],
      links: map['links'] != null
          ? List<Links>.from(map['links']?.map((x) => Links.fromMap(x)))
          : null,
      nextPageUrl: map['next_page_url'],
      path: map['path'],
      perPage: map['per_page']?.toInt(),
      prevPageUrl: map['prev_page_url'],
      to: map['to']?.toInt(),
      total: map['total']?.toInt(),
      outgoingAlertsData: map['data'] != null
          ? List<OutgoingAlertsData>.from(
              map['data']?.map((x) => OutgoingAlertsData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OutgoingAlerts.fromJson(String source) =>
      OutgoingAlerts.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OutgoingAlerts(currentPage: $currentPage, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total, outgoingAlertsData: $outgoingAlertsData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OutgoingAlerts &&
        other.currentPage == currentPage &&
        other.firstPageUrl == firstPageUrl &&
        other.from == from &&
        other.lastPage == lastPage &&
        other.lastPageUrl == lastPageUrl &&
        listEquals(other.links, links) &&
        other.nextPageUrl == nextPageUrl &&
        other.path == path &&
        other.perPage == perPage &&
        other.prevPageUrl == prevPageUrl &&
        other.to == to &&
        other.total == total &&
        listEquals(other.outgoingAlertsData, outgoingAlertsData);
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        firstPageUrl.hashCode ^
        from.hashCode ^
        lastPage.hashCode ^
        lastPageUrl.hashCode ^
        links.hashCode ^
        nextPageUrl.hashCode ^
        path.hashCode ^
        perPage.hashCode ^
        prevPageUrl.hashCode ^
        to.hashCode ^
        total.hashCode ^
        outgoingAlertsData.hashCode;
  }
}

class OutgoingAlertsDataList {
  List<OutgoingAlertsData>? outgoingAlertsData;
  OutgoingAlertsDataList({
    this.outgoingAlertsData,
  });

  OutgoingAlertsDataList copyWith({
    List<OutgoingAlertsData>? outgoingAlertsData,
  }) {
    return OutgoingAlertsDataList(
      outgoingAlertsData: outgoingAlertsData ?? this.outgoingAlertsData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': outgoingAlertsData?.map((x) => x.toMap()).toList(),
    };
  }

  factory OutgoingAlertsDataList.fromMap(Map<String, dynamic> map) {
    return OutgoingAlertsDataList(
      outgoingAlertsData: map['data'] != null
          ? List<OutgoingAlertsData>.from(
              map['data']?.map((x) => OutgoingAlertsData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OutgoingAlertsDataList.fromJson(String source) =>
      OutgoingAlertsDataList.fromMap(json.decode(source));

  @override
  String toString() =>
      'OutgoingAlertsDataList(outgoingAlertsData: $outgoingAlertsData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OutgoingAlertsDataList &&
        listEquals(other.outgoingAlertsData, outgoingAlertsData);
  }

  @override
  int get hashCode => outgoingAlertsData.hashCode;
}

class OutgoingAlertsData {
  int? alertId;
  String? alertTag;
  User? sender;
  int? referenceId;
  InitializedTransaction? initializedTransaction;
  int? amount;
  int? status;
  String? createdAt;
  bool? readStatus;
  OutgoingAlertsData({
    this.alertId,
    this.alertTag,
    this.sender,
    this.referenceId,
    this.initializedTransaction,
    this.amount,
    this.status,
    this.createdAt,
    this.readStatus,
  });

  OutgoingAlertsData copyWith({
    int? alertId,
    String? alertTag,
    User? sender,
    int? referenceId,
    InitializedTransaction? initializedTransaction,
    int? amount,
    int? status,
    String? createdAt,
    bool? readStatus,
  }) {
    return OutgoingAlertsData(
      alertId: alertId ?? this.alertId,
      alertTag: alertTag ?? this.alertTag,
      sender: sender ?? this.sender,
      referenceId: referenceId ?? this.referenceId,
      initializedTransaction:
          initializedTransaction ?? this.initializedTransaction,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      readStatus: readStatus ?? this.readStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alert_id': alertId,
      'alert_tag': alertTag,
      'sender': sender?.toMap(),
      'reference_id': referenceId,
      'initialized_transaction': initializedTransaction?.toMap(),
      'amount': amount,
      'status': status,
      'created_at': createdAt,
      'read_status': readStatus,
    };
  }

  factory OutgoingAlertsData.fromMap(Map<String, dynamic> map) {
    return OutgoingAlertsData(
      alertId: map['alert_id']?.toInt(),
      alertTag: map['alert_tag'],
      sender: map['sender'] != null ? User.fromMap(map['sender']) : null,
      referenceId: map['reference_id']?.toInt(),
      initializedTransaction: map['initialized_transaction'] != null
          ? InitializedTransaction.fromMap(map['initialized_transaction'])
          : null,
      amount: map['amount']?.toInt(),
      status: map['status']?.toInt(),
      createdAt: map['created_at'],
      readStatus: map['read_status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OutgoingAlertsData.fromJson(String source) =>
      OutgoingAlertsData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OutgoingAlertsData(alertId: $alertId, alertTag: $alertTag, sender: $sender, referenceId: $referenceId, initializedTransaction: $initializedTransaction, amount: $amount, status: $status, createdAt: $createdAt, readStatus: $readStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OutgoingAlertsData &&
        other.alertId == alertId &&
        other.alertTag == alertTag &&
        other.sender == sender &&
        other.referenceId == referenceId &&
        other.initializedTransaction == initializedTransaction &&
        other.amount == amount &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.readStatus == readStatus;
  }

  @override
  int get hashCode {
    return alertId.hashCode ^
        alertTag.hashCode ^
        sender.hashCode ^
        referenceId.hashCode ^
        initializedTransaction.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        readStatus.hashCode;
  }
}

class TransactionWallet {
  int? id;
  String? walletPaytag;
  TransactionWallet({
    this.id,
    this.walletPaytag,
  });

  TransactionWallet copyWith({
    int? id,
    String? walletPaytag,
  }) {
    return TransactionWallet(
      id: id ?? this.id,
      walletPaytag: walletPaytag ?? this.walletPaytag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wallet_paytag': walletPaytag,
      'paytag': walletPaytag,
    };
  }

  factory TransactionWallet.fromMap(Map<String, dynamic> map) {
    return TransactionWallet(
      id: map['id']?.toInt(),
      walletPaytag: map['wallet_paytag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionWallet.fromJson(String source) =>
      TransactionWallet.fromMap(json.decode(source));

  @override
  String toString() =>
      'TransactionWallet(id: $id, walletPaytag: $walletPaytag)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionWallet &&
        other.id == id &&
        other.walletPaytag == walletPaytag;
  }

  @override
  int get hashCode => id.hashCode ^ walletPaytag.hashCode;
}

class TransactionPromoCode {
  int? id;
  String? promoCode;
  TransactionPromoCode({
    this.id,
    this.promoCode,
  });

  TransactionPromoCode copyWith({
    int? id,
    String? promoCode,
  }) {
    return TransactionPromoCode(
      id: id ?? this.id,
      promoCode: promoCode ?? this.promoCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'promo_code': promoCode,
    };
  }

  factory TransactionPromoCode.fromMap(Map<String, dynamic> map) {
    return TransactionPromoCode(
      id: map['id']?.toInt(),
      promoCode: map['promo_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionPromoCode.fromJson(String source) =>
      TransactionPromoCode.fromMap(json.decode(source));

  @override
  String toString() => 'TransactionPromoCode(id: $id, promoCode: $promoCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionPromoCode &&
        other.id == id &&
        other.promoCode == promoCode;
  }

  @override
  int get hashCode => id.hashCode ^ promoCode.hashCode;
}

class TransactionaActivityLogs {
  List<Incoming?>? incoming;
  List<Outgiong?>? outgoing;
  TransactionaActivityLogs({
    this.incoming,
    this.outgoing,
  });

  TransactionaActivityLogs copyWith({
    List<Incoming?>? incoming,
    List<Outgiong?>? outgoing,
  }) {
    return TransactionaActivityLogs(
      incoming: incoming ?? this.incoming,
      outgoing: outgoing ?? this.outgoing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'incoming': incoming?.map((x) => x?.toMap()).toList(),
      'outgoing': outgoing?.map((x) => x?.toMap()).toList(),
    };
  }

  factory TransactionaActivityLogs.fromMap(Map<String, dynamic> map) {
    return TransactionaActivityLogs(
      incoming: List<Incoming?>.from(
          map['incoming']?.map((x) => Incoming.fromMap(x))),
      outgoing: List<Outgiong?>.from(
          map['outgoing']?.map((x) => Outgiong.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionaActivityLogs.fromJson(String source) =>
      TransactionaActivityLogs.fromMap(json.decode(source));

  @override
  String toString() =>
      'TransactionaActivityLogs(incoming: $incoming, outgoing: $outgoing)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionaActivityLogs &&
        listEquals(other.incoming, incoming) &&
        listEquals(other.outgoing, outgoing);
  }

  @override
  int get hashCode => incoming.hashCode ^ outgoing.hashCode;
}

class TransactionLogStructure {
  int? userTransactionActivityLogId;
  int? initializedTransactionId;
  int? senderId;
  int? recipientId;
  String? activityTag;
  String? createdAt;
}

class Incoming implements TransactionLogStructure {
  @override
  int? userTransactionActivityLogId;
  @override
  int? initializedTransactionId;
  @override
  int? senderId;
  @override
  int? recipientId;
  @override
  String? activityTag;
  @override
  String? createdAt;
  Incoming({
    this.userTransactionActivityLogId,
    this.initializedTransactionId,
    this.senderId,
    this.recipientId,
    this.activityTag,
    this.createdAt,
  });

  Incoming copyWith({
    int? userTransactionActivityLogId,
    int? initializedTransactionId,
    int? senderId,
    int? recipientId,
    String? activityTag,
    String? createdAt,
  }) {
    return Incoming(
      userTransactionActivityLogId:
          userTransactionActivityLogId ?? this.userTransactionActivityLogId,
      initializedTransactionId:
          initializedTransactionId ?? this.initializedTransactionId,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      activityTag: activityTag ?? this.activityTag,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_transaction_activity_log_id': userTransactionActivityLogId,
      'initialized_transaction_id': initializedTransactionId,
      'sender_id': senderId,
      'recipient_id': recipientId,
      'activity_tag': activityTag,
      'created_at': createdAt,
    };
  }

  factory Incoming.fromMap(Map<String, dynamic> map) {
    return Incoming(
      userTransactionActivityLogId:
          map['user_transaction_activity_log_id']?.toInt(),
      initializedTransactionId: map['initialized_transaction_id']?.toInt(),
      senderId: map['sender_id']?.toInt(),
      recipientId: map['recipient_id']?.toInt(),
      activityTag: map['activity_tag'],
      createdAt: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Incoming.fromJson(String source) =>
      Incoming.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Incoming(userTransactionActivityLogId: $userTransactionActivityLogId, initializedTransactionId: $initializedTransactionId, senderId: $senderId, recipientId: $recipientId, activityTag: $activityTag, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Incoming &&
        other.userTransactionActivityLogId == userTransactionActivityLogId &&
        other.initializedTransactionId == initializedTransactionId &&
        other.senderId == senderId &&
        other.recipientId == recipientId &&
        other.activityTag == activityTag &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return userTransactionActivityLogId.hashCode ^
        initializedTransactionId.hashCode ^
        senderId.hashCode ^
        recipientId.hashCode ^
        activityTag.hashCode ^
        createdAt.hashCode;
  }
}

class Outgiong implements TransactionLogStructure {
  @override
  int? userTransactionActivityLogId;
  @override
  int? initializedTransactionId;
  @override
  int? senderId;
  @override
  int? recipientId;
  @override
  String? activityTag;
  @override
  String? createdAt;
  Outgiong({
    this.userTransactionActivityLogId,
    this.initializedTransactionId,
    this.senderId,
    this.recipientId,
    this.activityTag,
    this.createdAt,
  });

  Outgiong copyWith({
    int? userTransactionActivityLogId,
    int? initializedTransactionId,
    int? senderId,
    int? recipientId,
    String? activityTag,
    String? createdAt,
  }) {
    return Outgiong(
      userTransactionActivityLogId:
          userTransactionActivityLogId ?? this.userTransactionActivityLogId,
      initializedTransactionId:
          initializedTransactionId ?? this.initializedTransactionId,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      activityTag: activityTag ?? this.activityTag,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_transaction_activity_log_id': userTransactionActivityLogId,
      'initialized_transaction_id': initializedTransactionId,
      'sender_id': senderId,
      'recipient_id': recipientId,
      'activity_tag': activityTag,
      'created_at': createdAt,
    };
  }

  factory Outgiong.fromMap(Map<String, dynamic> map) {
    return Outgiong(
      userTransactionActivityLogId:
          map['user_transaction_activity_log_id']?.toInt(),
      initializedTransactionId: map['initialized_transaction_id']?.toInt(),
      senderId: map['sender_id']?.toInt(),
      recipientId: map['recipient_id']?.toInt(),
      activityTag: map['activity_tag'],
      createdAt: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Outgiong.fromJson(String source) =>
      Outgiong.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Outgiong(userTransactionActivityLogId: $userTransactionActivityLogId, initializedTransactionId: $initializedTransactionId, senderId: $senderId, recipientId: $recipientId, activityTag: $activityTag, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Outgiong &&
        other.userTransactionActivityLogId == userTransactionActivityLogId &&
        other.initializedTransactionId == initializedTransactionId &&
        other.senderId == senderId &&
        other.recipientId == recipientId &&
        other.activityTag == activityTag &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return userTransactionActivityLogId.hashCode ^
        initializedTransactionId.hashCode ^
        senderId.hashCode ^
        recipientId.hashCode ^
        activityTag.hashCode ^
        createdAt.hashCode;
  }
}
