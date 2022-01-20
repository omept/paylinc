import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';

class UserAlertResonse {
  IncomingAlerts? incomingAlerts;
  OutgoingAlerts? outgoingAlerts;
  UserAlertResonse({
    this.incomingAlerts,
    this.outgoingAlerts,
  });

  UserAlertResonse copyWith({
    IncomingAlerts? incomingAlerts,
    OutgoingAlerts? outgoingAlerts,
  }) {
    return UserAlertResonse(
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

  factory UserAlertResonse.fromMap(Map<dynamic, dynamic> map) {
    return UserAlertResonse(
      incomingAlerts: map['incoming_alerts'] != null
          ? IncomingAlerts.fromMap(map['incoming_alerts'])
          : null,
      outgoingAlerts: map['outgoing_alerts'] != null
          ? OutgoingAlerts.fromMap(map['outgoing_alerts'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAlertResonse.fromJson(String source) =>
      UserAlertResonse.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserAlertResonse(incomingAlerts: $incomingAlerts, outgoingAlerts: $outgoingAlerts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserAlertResonse &&
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
      alertId: map['alert_dd']?.toInt(),
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
  });

  InitializedTransaction copyWith({
    int? id,
    int? initializedTransactionStatus,
    String? initializedTransactionDescription,
    String? initializedTransactionDeclinationReason,
    String? initializedTransactionConflictReason,
    User? recipient,
    User? sender,
    int? amount,
    String? createdAt,
  }) {
    return InitializedTransaction(
      id: id ?? this.id,
      initializedTransactionStatus:
          initializedTransactionStatus ?? this.initializedTransactionStatus,
      initializedTransactionDescription: initializedTransactionDescription ??
          this.initializedTransactionDescription,
      initializedTransactionDeclinationReason:
          initializedTransactionDeclinationReason ??
              this.initializedTransactionDeclinationReason,
      initializedTransactionConflictReason:
          initializedTransactionConflictReason ??
              this.initializedTransactionConflictReason,
      recipient: recipient ?? this.recipient,
      sender: sender ?? this.sender,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

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
      'createdAt': createdAt,
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
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InitializedTransaction.fromJson(String source) =>
      InitializedTransaction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InitializedTransaction(id: $id, initializedTransactionStatus: $initializedTransactionStatus, initializedTransactionDescription: $initializedTransactionDescription, initializedTransactionDeclinationReason: $initializedTransactionDeclinationReason, initializedTransactionConflictReason: $initializedTransactionConflictReason, recipient: $recipient, sender: $sender, amount: $amount, createdAt: $createdAt)';
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
        other.createdAt == createdAt;
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
        createdAt.hashCode;
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
