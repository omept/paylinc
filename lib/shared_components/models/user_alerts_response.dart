import 'package:user_repository/user_repository.dart';

class UserAlertResonse {
  IncomingAlerts? incomingAlerts;
  OutgoingAlerts? outgoingAlerts;

  UserAlertResonse({this.incomingAlerts, this.outgoingAlerts});

  UserAlertResonse.fromJson(Map<dynamic, dynamic> json) {
    incomingAlerts = json['incoming_alerts'] != null
        ? new IncomingAlerts.fromJson(json['incoming_alerts'])
        : null;
    outgoingAlerts = json['outgoing_alerts'] != null
        ? new OutgoingAlerts.fromJson(json['outgoing_alerts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.incomingAlerts != null) {
      data['incoming_alerts'] = this.incomingAlerts!.toJson();
    }
    if (this.outgoingAlerts != null) {
      data['outgoing_alerts'] = this.outgoingAlerts!.toJson();
    }
    return data;
  }
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

  IncomingAlerts(
      {this.currentPage,
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
      this.incomingAlertsData});

  IncomingAlerts.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
    if (json['data'] != null) {
      incomingAlertsData = <IncomingAlertsData>[];
      json['data'].forEach((v) {
        incomingAlertsData!.add(new IncomingAlertsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    if (this.incomingAlertsData != null) {
      data['data'] = this.incomingAlertsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
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

  IncomingAlertsData(
      {this.alertId,
      this.alertTag,
      this.sender,
      this.referenceId,
      this.initializedTransaction,
      this.amount,
      this.status,
      this.createdAt,
      this.readStatus});

  IncomingAlertsData.fromJson(Map<String, dynamic> json) {
    alertId = json['alert_id'];
    alertTag = json['alert_tag'];
    sender = json['sender'] != null ? new User.fromJson(json['sender']) : null;
    referenceId = json['reference_id'];
    initializedTransaction = json['initialized_transaction'] != null
        ? new InitializedTransaction.fromJson(json['initialized_transaction'])
        : null;
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    readStatus = json['read_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alert_id'] = this.alertId;
    data['alert_tag'] = this.alertTag;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    data['reference_id'] = this.referenceId;
    if (this.initializedTransaction != null) {
      data['initialized_transaction'] = this.initializedTransaction!.toJson();
    }
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['read_status'] = this.readStatus;
    return data;
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

  InitializedTransaction(
      {this.id,
      this.initializedTransactionStatus,
      this.initializedTransactionDescription,
      this.initializedTransactionDeclinationReason,
      this.initializedTransactionConflictReason,
      this.recipient,
      this.sender,
      this.amount,
      this.createdAt});

  InitializedTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initializedTransactionStatus = json['initialized_transaction_status'];
    initializedTransactionDescription =
        json['initialized_transaction_description'];
    initializedTransactionDeclinationReason =
        json['initialized_transaction_declination_reason'];
    initializedTransactionConflictReason =
        json['initialized_transaction_conflict_reason'];
    recipient =
        json['recipient'] != null ? new User.fromJson(json['recipient']) : null;
    sender = json['sender'] != null ? new User.fromJson(json['sender']) : null;
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['initialized_transaction_status'] = this.initializedTransactionStatus;
    data['initialized_transaction_description'] =
        this.initializedTransactionDescription;
    data['initialized_transaction_declination_reason'] =
        this.initializedTransactionDeclinationReason;
    data['initialized_transaction_conflict_reason'] =
        this.initializedTransactionConflictReason;
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    return data;
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

  OutgoingAlerts(
      {this.currentPage,
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
      this.outgoingAlertsData});

  OutgoingAlerts.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
    if (json['data'] != null) {
      outgoingAlertsData = <OutgoingAlertsData>[];
      json['data'].forEach((v) {
        outgoingAlertsData!.add(new OutgoingAlertsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    if (this.outgoingAlertsData != null) {
      data['data'] = this.outgoingAlertsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutgoingAlertsDataList {
  List<OutgoingAlertsData>? outgoingAlertsData;

  OutgoingAlertsDataList({this.outgoingAlertsData});

  OutgoingAlertsDataList.fromJson(Map<String, dynamic> json) {
    if (json['outgoing_alerts_data'] != null) {
      outgoingAlertsData = <OutgoingAlertsData>[];
      json['outgoing_alerts_data'].forEach((v) {
        outgoingAlertsData!.add(new OutgoingAlertsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.outgoingAlertsData != null) {
      data['outgoing_alerts_data'] =
          this.outgoingAlertsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
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

  OutgoingAlertsData(
      {this.alertId,
      this.alertTag,
      this.sender,
      this.referenceId,
      this.initializedTransaction,
      this.amount,
      this.status,
      this.createdAt,
      this.readStatus});

  OutgoingAlertsData.fromJson(Map<String, dynamic> json) {
    alertId = json['alert_id'];
    alertTag = json['alert_tag'];
    sender = json['sender'] != null ? new User.fromJson(json['sender']) : null;
    referenceId = json['reference_id'];
    initializedTransaction = json['initialized_transaction'] != null
        ? new InitializedTransaction.fromJson(json['initialized_transaction'])
        : null;
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    readStatus = json['read_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alert_id'] = this.alertId;
    data['alert_tag'] = this.alertTag;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    data['reference_id'] = this.referenceId;
    if (this.initializedTransaction != null) {
      data['initialized_transaction'] = this.initializedTransaction!.toJson();
    }
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['read_status'] = this.readStatus;
    return data;
  }
}
