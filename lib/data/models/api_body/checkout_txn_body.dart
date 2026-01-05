// To parse this JSON data, do
//
//     final checkoutTxnBody = checkoutTxnBodyFromJson(jsonString);

import 'dart:convert';

CheckoutTxnBody checkoutTxnBodyFromJson(String str) =>
    CheckoutTxnBody.fromJson(json.decode(str));

String checkoutTxnBodyToJson(CheckoutTxnBody data) =>
    json.encode(data.toJson());

class CheckoutTxnBody {
  final String? receiverAccountId;
  final String? receiverAmount;
  final String? toCurrency;
  final String? senderAccountId;
  final String? senderAmount;
  final String? fromCurrency;
  final String? exchangeRate;
  final String? transactionNote;
  final String? couponCode;
  final String? transactionRefNumber;
  final String? receiverType;
  final String? userType;
  final String? merchantId;
  final String? cardId;
  final String? senderPaymentType;
  final String? returnUrl;
  final String? cancelUrl;
  final String? landingUrl;
  final String? eventRefNumber;
  final String? eventId;
  final String? invoiceNumber;
  final String? subscriptionId;
  final String? subscriberId;
  final String? receiverId;

  CheckoutTxnBody({
    this.receiverAccountId,
    this.receiverAmount,
    this.toCurrency,
    this.senderAccountId,
    this.senderAmount,
    this.fromCurrency,
    this.exchangeRate,
    this.transactionNote,
    this.couponCode,
    this.transactionRefNumber,
    this.receiverType,
    this.userType,
    this.merchantId,
    this.cardId,
    this.senderPaymentType,
    this.returnUrl,
    this.cancelUrl,
    this.landingUrl,
    this.eventRefNumber,
    this.eventId,
    this.invoiceNumber,
    this.subscriptionId,
    this.subscriberId,
    this.receiverId,
  });

  CheckoutTxnBody copyWith({
    String? receiverAccountId,
    String? receiverAmount,
    String? toCurrency,
    String? senderAccountId,
    String? senderAmount,
    String? fromCurrency,
    String? exchangeRate,
    String? transactionNote,
    String? couponCode,
    String? transactionRefNumber,
    String? receiverType,
    String? userType,
    String? merchantId,
    String? cardId,
    String? senderPaymentType,
    String? returnUrl,
    String? cancelUrl,
    String? landingUrl,
    String? eventRefNumber,
    String? eventId,
    String? invoiceNumber,
    String? subscriptionId,
    String? subscriberId,
    String? receiverId,
  }) =>
      CheckoutTxnBody(
        receiverAccountId: receiverAccountId ?? this.receiverAccountId,
        receiverAmount: receiverAmount ?? this.receiverAmount,
        toCurrency: toCurrency ?? this.toCurrency,
        senderAccountId: senderAccountId ?? this.senderAccountId,
        senderAmount: senderAmount ?? this.senderAmount,
        fromCurrency: fromCurrency ?? this.fromCurrency,
        exchangeRate: exchangeRate ?? this.exchangeRate,
        transactionNote: transactionNote ?? this.transactionNote,
        couponCode: couponCode ?? this.couponCode,
        transactionRefNumber: transactionRefNumber ?? this.transactionRefNumber,
        receiverType: receiverType ?? this.receiverType,
        userType: userType ?? this.userType,
        merchantId: merchantId ?? this.merchantId,
        cardId: cardId ?? this.cardId,
        senderPaymentType: senderPaymentType ?? this.senderPaymentType,
        returnUrl: returnUrl ?? this.returnUrl,
        cancelUrl: cancelUrl ?? this.cancelUrl,
        landingUrl: landingUrl ?? this.landingUrl,
        eventRefNumber: eventRefNumber ?? this.eventRefNumber,
        eventId: eventId ?? this.eventId,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        subscriptionId: subscriptionId ?? this.subscriptionId,
        subscriberId: subscriberId ?? this.subscriberId,
        receiverId: receiverId ?? this.receiverId,
      );

  factory CheckoutTxnBody.fromJson(Map<String, dynamic> json) =>
      CheckoutTxnBody(
        receiverAccountId: json["receiver_account_id"],
        receiverAmount: json["receiver_amount"],
        toCurrency: json["to_currency"],
        senderAccountId: json["sender_account_id"],
        senderAmount: json["sender_amount"],
        fromCurrency: json["from_currency"],
        exchangeRate: json["exchange_rate"],
        transactionNote: json["transaction_note"],
        couponCode: json["coupon_code"],
        transactionRefNumber: json["transaction_ref_number"],
        receiverType: json["receiver_type"],
        userType: json["user_type"],
        merchantId: json["merchantId"],
        cardId: json["CardId"],
        senderPaymentType: json["sender_payment_type"],
        returnUrl: json["return_url"],
        cancelUrl: json["cancel_url"],
        landingUrl: json["landing_url"],
        eventRefNumber: json["event_ref_number"],
        eventId: json["event_id"],
        invoiceNumber: json["invoice_number"],
        subscriptionId: json["subscription_id"],
        subscriberId: json["subscriber_id"],
        receiverId: json["receiver_id"],
      );

  Map<String, dynamic> toJson() {
    var body = {
      "receiver_account_id": receiverAccountId,
      "receiver_amount": receiverAmount,
      "to_currency": toCurrency,
      "sender_account_id": senderAccountId,
      "sender_amount": senderAmount,
      "from_currency": fromCurrency,
      "exchange_rate": exchangeRate,
      "transaction_note": transactionNote,
      "coupon_code": couponCode,
      "transaction_ref_number": transactionRefNumber,
      "receiver_type": receiverType,
      "user_type": userType,
    };
    // if (merchantId?.isNotEmpty ?? false) body["merchantId"] = merchantId;
    if (cardId?.isNotEmpty ?? false) body["CardId"] = cardId;
    if (senderPaymentType?.isNotEmpty ?? false) {
      body["sender_payment_type"] = senderPaymentType;
    }
    if (returnUrl?.isNotEmpty ?? false) {
      body["return_url"] = returnUrl;
    }
    if (cancelUrl?.isNotEmpty ?? false) {
      body["cancel_url"] = cancelUrl;
    }
    if (landingUrl?.isNotEmpty ?? false) {
      body["landing_url"] = landingUrl;
    }
    if (eventRefNumber?.isNotEmpty ?? false) {
      body["event_ref_number"] = eventRefNumber;
    }
    if (eventId?.isNotEmpty ?? false) {
      body["event_id"] = eventId;
    }
    if (invoiceNumber?.isNotEmpty ?? false) {
      body["invoice_number"] = invoiceNumber;
    }
    if (subscriptionId?.isNotEmpty ?? false) {
      body["subscription_id"] = subscriptionId;
    }
    if (subscriberId?.isNotEmpty ?? false) {
      body["subscriber_id"] = subscriberId;
    }
    if (receiverId?.isNotEmpty ?? false) {
      body["receiverId"] = receiverId;
    }
    return body;
  }
}
