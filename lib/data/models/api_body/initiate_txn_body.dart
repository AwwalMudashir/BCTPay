// To parse this JSON data, do
//
//     final initiateTxnBody = initiateTxnBodyFromJson(jsonString);

import 'package:bctpay/lib.dart';

InitiateTxnBody initiateTxnBodyFromJson(String str) =>
    InitiateTxnBody.fromJson(json.decode(str));

String initiateTxnBodyToJson(InitiateTxnBody data) =>
    json.encode(data.toJson());

class InitiateTxnBody {
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
  final String? transferType;
  final int? requestedAmount;
  final String? receiverType;
  final String? userType;
  final String? merchantId;
  final String? requestedId;
  final String? senderPaymentType;
  final String? eventId;
  final List<TicketData>? ticketdata;
  final String? amount;
  final String? eventRefNumber;
  final String? invoiceNumber;
  final String? subscriptionId;
  final List<PlanInfo>? planList;
  final String? receiverId;

  InitiateTxnBody({
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
    this.transferType,
    this.requestedAmount,
    this.receiverType,
    this.userType,
    this.merchantId,
    this.requestedId,
    this.senderPaymentType,
    this.eventId,
    this.ticketdata,
    this.amount,
    this.eventRefNumber,
    this.invoiceNumber,
    this.subscriptionId,
    this.planList,
    this.receiverId,
  });

  InitiateTxnBody copyWith({
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
    String? transferType,
    int? requestedAmount,
    String? receiverType,
    String? userType,
    String? merchantId,
    String? requestedId,
    String? senderPaymentType,
    String? eventId,
    List<TicketData>? ticketdata,
    String? amount,
    String? eventRefNumber,
    String? invoiceNumber,
    String? subscriptionId,
    List<PlanInfo>? planList,
    String? receiverId,
  }) =>
      InitiateTxnBody(
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
        transferType: transferType ?? this.transferType,
        requestedAmount: requestedAmount ?? this.requestedAmount,
        receiverType: receiverType ?? this.receiverType,
        userType: userType ?? this.userType,
        merchantId: merchantId ?? this.merchantId,
        requestedId: requestedId ?? this.requestedId,
        senderPaymentType: senderPaymentType ?? this.senderPaymentType,
        eventId: eventId ?? this.eventId,
        ticketdata: ticketdata ?? this.ticketdata,
        amount: amount ?? this.amount,
        eventRefNumber: eventRefNumber ?? this.eventRefNumber,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        subscriptionId: subscriptionId ?? this.subscriptionId,
        planList: planList ?? this.planList,
        receiverId: receiverId ?? this.receiverId,
      );

  factory InitiateTxnBody.fromJson(Map<String, dynamic> json) =>
      InitiateTxnBody(
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
        transferType: json["transfer_type"],
        requestedAmount: json["requested_amount"],
        receiverType: json["receiver_type"],
        userType: json["user_type"],
        merchantId: json["merchantId"],
        requestedId: json["requested_id"],
        senderPaymentType: json["sender_payment_type"],
        eventId: json["event_id"],
        ticketdata: json["ticketdata"] == null
            ? []
            : List<TicketData>.from(
                json["ticketdata"]!.map((x) => TicketData.fromJson(x))),
        amount: json["amount"],
        eventRefNumber: json["event_ref_number"],
        invoiceNumber: json["invoice_number"],
        subscriptionId: json["subscription_id"],
        planList: json["plan_list"] == null
            ? []
            : List<PlanInfo>.from(
                json["plan_list"]!.map((x) => PlanInfo.fromJson(x))),
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
      "transfer_type": transferType,
      "requested_amount": requestedAmount,
      "receiver_type": receiverType,
      "user_type": userType,
      "merchantId": merchantId,
      "sender_payment_type": senderPaymentType,
      "amount": amount,
    };

    if (requestedId?.isNotEmpty ?? false) {
      body["requested_id"] = requestedId;
    }

    //ticket
    if (ticketdata?.isNotEmpty ?? false) {
      body["ticketdata"] = ticketdata?.map((e) => e.toJson()).toList();
    }
    if (eventId?.isNotEmpty ?? false) {
      body["event_id"] = eventId;
    }
    if (eventRefNumber?.isNotEmpty ?? false) {
      body["event_ref_number"] = eventRefNumber;
    }
    if (eventId?.isNotEmpty ?? false) {
      body["live_mode"] = "false";
    }
    if (eventId?.isNotEmpty ?? false) {
      body["currency"] = selectedCountry?.currencyCode;
    }

    //invoice
    if (invoiceNumber?.isNotEmpty ?? false) {
      body["invoice_number"] = invoiceNumber;
    }

    //subscription
    if (subscriptionId?.isNotEmpty ?? false) {
      body["subscription_id"] = subscriptionId;
    }
    if (planList?.isNotEmpty ?? false) {
      body["plan_list"] = List<dynamic>.from(planList!.map((x) => x.toJson()));
    }
    if (receiverId?.isNotEmpty ?? false) {
      body["receiverId"] = receiverId;
    }
    return body;
  }
}
