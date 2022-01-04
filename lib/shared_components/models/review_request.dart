import 'dart:convert';

import 'package:user_repository/user_repository.dart';

enum TransactionType {
  SEND_MONEY,
  REQUEST_MONEY,
}

extension FromTransactionType on String {
  TransactionType fromTransactionTypeString() {
    return this.toString() == 'SEND_MONEY'
        ? TransactionType.SEND_MONEY
        : TransactionType.REQUEST_MONEY;
  }
}

extension ToStringValue on TransactionType {
  String toStringValue() {
    return "${this}" == 'SEND_MONEY' ? 'SEND_MONEY' : "REQUEST_MONEY";
  }
}

class ReviewRequest {
  final User? recipient;
  final User? sender;
  final int? amount;
  final String? purpose;
  final TransactionType? transactionType;
  final bool? promoApplied;
  final String? promoCode;
  final double? providerChargeLoc;
  final double? providerChargeInt;
  final double? appCharge;
  final double? appChargePromo;
  final double? remitableAmountInt;
  final double? remitableAmountLoc;
  final double? promoRemitableAmountInt;
  final double? promoRemitableAmountLoc;
  final String? paymentProviderName;
  final double? refundChargeOnSender;
  final double? appliedPromoCodeDeduction;
  ReviewRequest({
    this.recipient,
    this.sender,
    this.amount,
    this.purpose,
    this.transactionType,
    this.promoApplied,
    this.promoCode,
    this.providerChargeLoc,
    this.providerChargeInt,
    this.appCharge,
    this.appChargePromo,
    this.remitableAmountInt,
    this.remitableAmountLoc,
    this.promoRemitableAmountInt,
    this.promoRemitableAmountLoc,
    this.paymentProviderName,
    this.refundChargeOnSender,
    this.appliedPromoCodeDeduction,
  });

  ReviewRequest copyWith({
    User? recipient,
    User? sender,
    int? amount,
    String? purpose,
    TransactionType? transactionType,
    bool? promoApplied,
    String? promoCode,
    double? providerChargeLoc,
    double? providerChargeInt,
    double? appCharge,
    double? appChargePromo,
    double? remitableAmountInt,
    double? remitableAmountLoc,
    double? promoRemitableAmountInt,
    double? promoRemitableAmountLoc,
    String? paymentProviderName,
    double? refundChargeOnSender,
    double? appliedPromoCodeDeduction,
  }) {
    return ReviewRequest(
      recipient: recipient ?? this.recipient,
      sender: sender ?? this.sender,
      amount: amount ?? this.amount,
      purpose: purpose ?? this.purpose,
      transactionType: transactionType ?? this.transactionType,
      promoApplied: promoApplied ?? this.promoApplied,
      promoCode: promoCode ?? this.promoCode,
      providerChargeLoc: providerChargeLoc ?? this.providerChargeLoc,
      providerChargeInt: providerChargeInt ?? this.providerChargeInt,
      appCharge: appCharge ?? this.appCharge,
      appChargePromo: appChargePromo ?? this.appChargePromo,
      remitableAmountInt: remitableAmountInt ?? this.remitableAmountInt,
      remitableAmountLoc: remitableAmountLoc ?? this.remitableAmountLoc,
      promoRemitableAmountInt:
          promoRemitableAmountInt ?? this.promoRemitableAmountInt,
      promoRemitableAmountLoc:
          promoRemitableAmountLoc ?? this.promoRemitableAmountLoc,
      paymentProviderName: paymentProviderName ?? this.paymentProviderName,
      refundChargeOnSender: refundChargeOnSender ?? this.refundChargeOnSender,
      appliedPromoCodeDeduction:
          appliedPromoCodeDeduction ?? this.appliedPromoCodeDeduction,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recipient': recipient?.toMap(),
      'sender': sender?.toMap(),
      'amount': amount,
      'purpose': purpose,
      'transactionType': transactionType?.toStringValue(),
      'promoApplied': promoApplied,
      'promoCode': promoCode,
      'providerChargeLoc': providerChargeLoc,
      'providerChargeInt': providerChargeInt,
      'appCharge': appCharge,
      'appChargePromo': appChargePromo,
      'remitableAmountInt': remitableAmountInt,
      'remitableAmountLoc': remitableAmountLoc,
      'promoRemitableAmountInt': promoRemitableAmountInt,
      'promoRemitableAmountLoc': promoRemitableAmountLoc,
      'paymentProviderName': paymentProviderName,
      'refundChargeOnSender': refundChargeOnSender,
      'appliedPromoCodeDeduction': appliedPromoCodeDeduction,
    };
  }

  factory ReviewRequest.fromMap(Map<dynamic, dynamic> map) {
    return ReviewRequest(
      recipient:
          map['recipient'] != null ? User.fromMap(map['recipient']) : null,
      sender: map['sender'] != null ? User.fromMap(map['sender']) : null,
      amount: int.parse(map['amount'].toString()),
      purpose: map['purpose'],
      transactionType: map['transaction_type'] != null
          ? map['transaction_type'].toString().fromTransactionTypeString()
          : null,
      promoApplied: map['promo_applied'],
      promoCode: map['promo_code'],
      providerChargeLoc: map['provider_charge_loc'] == null
          ? 0
          : double.parse(map['provider_charge_loc'].toString()),
      providerChargeInt: map['provider_charge_int'] == null
          ? 0
          : double.parse(map['provider_charge_int'].toString()),
      appCharge: map['app_charge'] == null
          ? 0
          : double.parse(map['app_charge'].toString()),
      appChargePromo: map['app_charge_promo'] == null
          ? 0
          : double.parse(map['app_charge_promo'].toString()),
      remitableAmountInt: map['remitable_amount_int'] == null
          ? 0
          : double.parse(map['remitable_amount_int'].toString()),
      remitableAmountLoc: map['remitable_amount_loc'] == null
          ? 0
          : double.parse(map['remitable_amount_loc'].toString()),
      promoRemitableAmountInt: map['promo_remitable_amount_int'] == null
          ? 0
          : double.parse(map['promo_remitable_amount_int'].toString()),
      promoRemitableAmountLoc: map['promo_remitable_amount_loc'] == null
          ? 0
          : double.parse(map['promo_remitable_amount_loc'].toString()),
      paymentProviderName: map['payment_provider_name'].toString(),
      refundChargeOnSender: map['refund_charge_on_sender'] == null
          ? 0
          : double.parse(map['refund_charge_on_sender'].toString()),
      appliedPromoCodeDeduction: map['applied_promo_code_deduction'] == null
          ? 0
          : double.parse(map['applied_promo_code_deduction'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewRequest.fromJson(String source) =>
      ReviewRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReviewRequest(recipient: $recipient, sender: $sender, amount: $amount, purpose: $purpose, transactionType: $transactionType, promoApplied: $promoApplied, promoCode: $promoCode, providerChargeLoc: $providerChargeLoc, providerChargeInt: $providerChargeInt, appCharge: $appCharge, appChargePromo: $appChargePromo, remitableAmountInt: $remitableAmountInt, remitableAmountLoc: $remitableAmountLoc, promoRemitableAmountInt: $promoRemitableAmountInt, promoRemitableAmountLoc: $promoRemitableAmountLoc, paymentProviderName: $paymentProviderName, refundChargeOnSender: $refundChargeOnSender, appliedPromoCodeDeduction: $appliedPromoCodeDeduction)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewRequest &&
        other.recipient == recipient &&
        other.sender == sender &&
        other.amount == amount &&
        other.purpose == purpose &&
        other.transactionType == transactionType &&
        other.promoApplied == promoApplied &&
        other.promoCode == promoCode &&
        other.providerChargeLoc == providerChargeLoc &&
        other.providerChargeInt == providerChargeInt &&
        other.appCharge == appCharge &&
        other.appChargePromo == appChargePromo &&
        other.remitableAmountInt == remitableAmountInt &&
        other.remitableAmountLoc == remitableAmountLoc &&
        other.promoRemitableAmountInt == promoRemitableAmountInt &&
        other.promoRemitableAmountLoc == promoRemitableAmountLoc &&
        other.paymentProviderName == paymentProviderName &&
        other.refundChargeOnSender == refundChargeOnSender &&
        other.appliedPromoCodeDeduction == appliedPromoCodeDeduction;
  }

  @override
  int get hashCode {
    return recipient.hashCode ^
        sender.hashCode ^
        amount.hashCode ^
        purpose.hashCode ^
        transactionType.hashCode ^
        promoApplied.hashCode ^
        promoCode.hashCode ^
        providerChargeLoc.hashCode ^
        providerChargeInt.hashCode ^
        appCharge.hashCode ^
        appChargePromo.hashCode ^
        remitableAmountInt.hashCode ^
        remitableAmountLoc.hashCode ^
        promoRemitableAmountInt.hashCode ^
        promoRemitableAmountLoc.hashCode ^
        paymentProviderName.hashCode ^
        refundChargeOnSender.hashCode ^
        appliedPromoCodeDeduction.hashCode;
  }
}
