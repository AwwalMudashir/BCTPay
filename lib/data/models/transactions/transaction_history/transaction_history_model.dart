// class TransactionHistoryResponse {
//   final int code;
//   final TransactionHistoryData? data;
//   final String message;
//   final bool? success;

//   TransactionHistoryResponse({
//     required this.code,
//     required this.data,
//     required this.message,
//     required this.success,
//   });

//   factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) =>
//       TransactionHistoryResponse(
//         code: json["code"],
//         data: json["data"] == null
//             ? null
//             : TransactionHistoryData.fromJson(json["data"]),
//         message: json["message"],
//         success: json["success"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "data": data?.toJson(),
//         "message": message,
//         "success": success,
//       };
// }

// class TransactionHistoryData {
//   final List<Transaction> list;
//   final int count;

//   TransactionHistoryData({
//     required this.list,
//     required this.count,
//   });

//   factory TransactionHistoryData.fromJson(Map<String, dynamic> json) =>
//       TransactionHistoryData(
//         list: List<Transaction>.from(
//             json["list"].map((x) => Transaction.fromJson(x))),
//         count: json["count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "list": List<dynamic>.from(list.map((x) => x.toJson())),
//         "count": count,
//       };
// }

// class Transaction {
//   final String id;
//   final String senderId;
//   final String senderBctpayId;
//   final String senderName;
//   final String senderRole;
//   final String senderAccountNumber;
//   final String senderAccountType;
//   final String senderCountryId;
//   final String senderCountryName;
//   final String senderCountryCode;
//   final String senderCountryFlag;
//   final String senderAmount;
//   final String senderCurrency;
//   final String senderCurrencySymbol;
//   final String? receiverId;
//   final String receiverName;
//   final String receiverAccountNumber;
//   final String receiverAccountType;
//   final String receiverAmount;
//   final String receiverCurrency;
//   final String receiverCurrencySymbol;
//   final String couponCodeApplyStatus;
//   final dynamic couponDetails;
//   final String commissionFee;
//   final String commissionFeeType;
//   final String paybleCommissionFeeAmount;
//   final String transactionFee;
//   final String transactionFeeType;
//   final String transactionFeeServiceType;
//   final String paybleTransactionFeeAmount;
//   final String exchangeRate;
//   final String transactionNote;
//   final String transactionStep;
//   final String transactionMode;
//   final String transactionType;
//   final String requestedAmount;
//   final String transactionLogo;
//   final String transactionBctpayRefrenceNumber;
//   final String paybleTotalAmount;
//   final String systemIp;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;
//   final String? thirdPartyTransctionRefrenceNumberWithSender;
//   final String? transactionStepWithSender;
//   final String? thirdPartyTransctionRefrenceNumberWithReceiver;
//   final String? transactionStepWithReceiver;
//   final String? transactionQrCode;

//   Transaction({
//     required this.id,
//     required this.senderId,
//     required this.senderBctpayId,
//     required this.senderName,
//     required this.senderRole,
//     required this.senderAccountNumber,
//     required this.senderAccountType,
//     required this.senderCountryId,
//     required this.senderCountryName,
//     required this.senderCountryCode,
//     required this.senderCountryFlag,
//     required this.senderAmount,
//     required this.senderCurrency,
//     required this.senderCurrencySymbol,
//     required this.receiverId,
//     required this.receiverName,
//     required this.receiverAccountNumber,
//     required this.receiverAccountType,
//     required this.receiverAmount,
//     required this.receiverCurrency,
//     required this.receiverCurrencySymbol,
//     required this.couponCodeApplyStatus,
//     required this.couponDetails,
//     required this.commissionFee,
//     required this.commissionFeeType,
//     required this.paybleCommissionFeeAmount,
//     required this.transactionFee,
//     required this.transactionFeeType,
//     required this.transactionFeeServiceType,
//     required this.paybleTransactionFeeAmount,
//     required this.exchangeRate,
//     required this.transactionNote,
//     required this.transactionStep,
//     required this.transactionMode,
//     required this.transactionType,
//     required this.requestedAmount,
//     required this.transactionLogo,
//     required this.transactionBctpayRefrenceNumber,
//     required this.paybleTotalAmount,
//     required this.systemIp,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.thirdPartyTransctionRefrenceNumberWithSender,
//     required this.transactionStepWithSender,
//     required this.thirdPartyTransctionRefrenceNumberWithReceiver,
//     required this.transactionStepWithReceiver,
//     required this.transactionQrCode,
//   });

//   factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
//         id: json["_id"],
//         senderId: json["sender_id"],
//         senderBctpayId: json["sender_bctpay_id"],
//         senderName: json["sender_name"],
//         senderRole: json["sender_role"],
//         senderAccountNumber: json["sender_account_number"],
//         senderAccountType: json["sender_account_type"],
//         senderCountryId: json["sender_country_id"],
//         senderCountryName: json["sender_country_name"],
//         senderCountryCode: json["sender_country_code"],
//         senderCountryFlag: json["sender_country_flag"],
//         senderAmount: json["sender_amount"],
//         senderCurrency: json["sender_currency"],
//         senderCurrencySymbol: json["sender_currency_symbol"],
//         receiverId: json["receiver_id"],
//         receiverName: json["receiver_name"],
//         receiverAccountNumber: json["receiver_account_number"],
//         receiverAccountType: json["receiver_account_type"],
//         receiverAmount: json["receiver_amount"],
//         receiverCurrency: json["receiver_currency"],
//         receiverCurrencySymbol: json["receiver_currency_symbol"],
//         couponCodeApplyStatus: json["coupon_code_apply_status"],
//         couponDetails: json["coupon_details"],
//         commissionFee: json["commission_fee"],
//         commissionFeeType: json["commission_fee_type"],
//         paybleCommissionFeeAmount: json["payble_commission_fee_amount"],
//         transactionFee: json["transaction_fee"],
//         transactionFeeType: json["transaction_fee_type"],
//         transactionFeeServiceType: json["transaction_fee_service_type"],
//         paybleTransactionFeeAmount: json["payble_transaction_fee_amount"],
//         exchangeRate: json["exchange_rate"],
//         transactionNote: json["transaction_note"],
//         transactionStep: json["transaction_step"],
//         transactionMode: json["transaction_mode"],
//         transactionType: json["transaction_type"],
//         requestedAmount: json["requested_amount"],
//         transactionLogo: json["transaction_logo"],
//         transactionBctpayRefrenceNumber:
//             json["transaction_bctpay_refrence_number"],
//         paybleTotalAmount: json["payble_total_amount"],
//         systemIp: json["system_ip"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         thirdPartyTransctionRefrenceNumberWithSender:
//             json["third_party_transction_refrence_number_with_sender"],
//         transactionStepWithSender: json["transaction_step_with_sender"],
//         thirdPartyTransctionRefrenceNumberWithReceiver:
//             json["third_party_transction_refrence_number_with_receiver"],
//         transactionStepWithReceiver: json["transaction_step_with_receiver"],
//         transactionQrCode: json["transaction_qr_code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "sender_id": senderId,
//         "sender_bctpay_id": senderBctpayId,
//         "sender_name": senderName,
//         "sender_role": senderRole,
//         "sender_account_number": senderAccountNumber,
//         "sender_account_type": senderAccountType,
//         "sender_country_id": senderCountryId,
//         "sender_country_name": senderCountryName,
//         "sender_country_code": senderCountryCode,
//         "sender_country_flag": senderCountryFlag,
//         "sender_amount": senderAmount,
//         "sender_currency": senderCurrency,
//         "sender_currency_symbol": senderCurrencySymbol,
//         "receiver_id": receiverId,
//         "receiver_name": receiverName,
//         "receiver_account_number": receiverAccountNumber,
//         "receiver_account_type": receiverAccountType,
//         "receiver_amount": receiverAmount,
//         "receiver_currency": receiverCurrency,
//         "receiver_currency_symbol": receiverCurrencySymbol,
//         "coupon_code_apply_status": couponCodeApplyStatus,
//         "coupon_details": couponDetails,
//         "commission_fee": commissionFee,
//         "commission_fee_type": commissionFeeType,
//         "payble_commission_fee_amount": paybleCommissionFeeAmount,
//         "transaction_fee": transactionFee,
//         "transaction_fee_type": transactionFeeType,
//         "transaction_fee_service_type": transactionFeeServiceType,
//         "payble_transaction_fee_amount": paybleTransactionFeeAmount,
//         "exchange_rate": exchangeRate,
//         "transaction_note": transactionNote,
//         "transaction_step": transactionStep,
//         "transaction_mode": transactionMode,
//         "transaction_type": transactionType,
//         "requested_amount": requestedAmount,
//         "transaction_logo": transactionLogo,
//         "transaction_bctpay_refrence_number": transactionBctpayRefrenceNumber,
//         "payble_total_amount": paybleTotalAmount,
//         "system_ip": systemIp,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "third_party_transction_refrence_number_with_sender":
//             thirdPartyTransctionRefrenceNumberWithSender,
//         "transaction_step_with_sender": transactionStepWithSender,
//         "third_party_transction_refrence_number_with_receiver":
//             thirdPartyTransctionRefrenceNumberWithReceiver,
//         "transaction_step_with_receiver": transactionStepWithReceiver,
//         "transaction_qr_code": transactionQrCode,
//       };
// }

// To parse this JSON data, do
//
//     final transactionHistoryResponse = transactionHistoryResponseFromJson(jsonString);

import 'package:bctpay/lib.dart';

TransactionHistoryResponse transactionHistoryResponseFromJson(String str) =>
    TransactionHistoryResponse.fromJson(json.decode(str));

String transactionHistoryResponseToJson(TransactionHistoryResponse data) =>
    json.encode(data.toJson());

class TransactionHistoryResponse {
  final int code;
  final TransactionHistoryData? data;
  final String message;
  final bool? success;

  TransactionHistoryResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : TransactionHistoryData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "message": message,
        "success": success,
      };
}

class TransactionHistoryData {
  final List<TransactionData>? list;
  final int count;

  TransactionHistoryData({
    required this.list,
    required this.count,
  });

  factory TransactionHistoryData.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryData(
        list: json["list"] == null
            ? null
            : List<TransactionData>.from(
                json["list"].map((x) => TransactionData.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "count": count,
      };
}

class TransactionData {
  final UserData? senderDetails;
  final UserData? receiverDetails;
  final Transaction details;
  final Invoice? invoiceDetails;
  final Subscriber? subscriptionDetails;
  final String? wlLogo;

  TransactionData({
    this.senderDetails,
    this.receiverDetails,
    required this.details,
    this.invoiceDetails,
    this.subscriptionDetails,
    this.wlLogo,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      TransactionData(
          senderDetails: json["senderDetails"] == null
              ? null
              : UserData.fromJson(json["senderDetails"]),
          receiverDetails: json["receiverDetails"] == null
              ? null
              : UserData.fromJson(json["receiverDetails"]),
          details: Transaction.fromJson(
              json["details"] ?? json["transaction_details"]),
          invoiceDetails: json["invoice_details"] == null
              ? null
              : Invoice.fromJson(json["invoice_details"]),
          subscriptionDetails: json["subscription_details"] == null
              ? null
              : Subscriber.fromJson(json['subscription_details']),
          wlLogo: json["wl_logo"]);

  Map<String, dynamic> toJson() => {
        "senderDetails": senderDetails?.toJson(),
        "receiverDetails": receiverDetails?.toJson(),
        "details": details.toJson(),
        "invoice_details": invoiceDetails?.toJson(),
        "subscription_details": subscriptionDetails?.toJson(),
        "wl_logo": wlLogo,
      };

  TransactionData copyWith({
    final UserData? senderDetails,
    final UserData? receiverDetails,
    final Transaction? details,
    final Invoice? invoiceDetails,
    final Subscriber? subscriptionDetails,
    final String? wlLogo,
  }) {
    return TransactionData(
      senderDetails: senderDetails ?? this.senderDetails,
      receiverDetails: receiverDetails ?? this.receiverDetails,
      details: details ?? this.details,
      invoiceDetails: invoiceDetails ?? this.invoiceDetails,
      subscriptionDetails: subscriptionDetails ?? this.subscriptionDetails,
      wlLogo: wlLogo ?? this.wlLogo,
    );
  }
}

class Transaction {
  final String id;
  final String transactionBctpayRefrenceNumber;
  final int? v;
  final String commissionFee;
  final String commissionFeeType;
  final String couponCodeApplyStatus;
  final dynamic couponDetails;
  final DateTime createdAt;
  final String exchangeRate;
  final String? invoiceNumber;
  final String mVerifyStatus;
  final String cVerifyStatus;
  final String paybleCommissionFeeAmount;
  final String paybleTotalAmount;
  final String paybleTransactionFeeAmount;
  final String receiverAccountId;
  final String receiverAccountNumber;
  final String receiverAccountType;
  final String receiverAmount;
  final String receiverCurrency;
  final String receiverCurrencySymbol;
  final String? receiverId;
  final String receiverName;
  final String requestedAmount;
  final dynamic requestedId;
  final String senderAccountNumber;
  final String senderAccountType;
  final String senderAmount;
  final String? senderBctpayId;
  final String senderCountryCode;
  final String senderCountryFlag;
  final String? senderCountryId;
  final String senderCountryName;
  final String senderCurrency;
  final String senderCurrencySymbol;
  final String? senderId;
  final String senderName;
  final String senderRole;
  final String systemIp;
  final String? thirdPartyTransctionRefrenceNumberWithReceiver;
  final String? thirdPartyTransctionRefrenceNumberWithSender;
  final String? transactionFee;
  final String transactionFeeServiceType;
  final String? transactionFeeType;
  final String? transactionLogo;
  final String? transactionMode;
  final String? transactionNote;
  final String transactionStep;
  final String? transactionStepWithReceiver;
  final String? transactionStepWithSender;
  final String transactionType;
  final String? transferType;
  final DateTime? updatedAt;
  final String? qrCode;
  final String? qrCodeLink;
  final String? omSenderNotifToken;
  final String? omSenderPayToken;
  final String? omSenderPaymentUrl;
  final String? omSenderTransactionRef;
  final List<PlanInfo>? planInfo;
  final List<TicketData>? ticketdata;
  final String? eventId;
  final String? eventRefNumber;
  final PaymentLinkData? eventdata;
  final Payerdata? payerdata;

  Transaction({
    required this.id,
    required this.transactionBctpayRefrenceNumber,
    required this.v,
    required this.commissionFee,
    required this.commissionFeeType,
    required this.couponCodeApplyStatus,
    required this.couponDetails,
    required this.createdAt,
    required this.exchangeRate,
    required this.invoiceNumber,
    required this.mVerifyStatus,
    required this.cVerifyStatus,
    required this.paybleCommissionFeeAmount,
    required this.paybleTotalAmount,
    required this.paybleTransactionFeeAmount,
    required this.receiverAccountId,
    required this.receiverAccountNumber,
    required this.receiverAccountType,
    required this.receiverAmount,
    required this.receiverCurrency,
    required this.receiverCurrencySymbol,
    required this.receiverId,
    required this.receiverName,
    required this.requestedAmount,
    required this.requestedId,
    required this.senderAccountNumber,
    required this.senderAccountType,
    required this.senderAmount,
    required this.senderBctpayId,
    required this.senderCountryCode,
    required this.senderCountryFlag,
    required this.senderCountryId,
    required this.senderCountryName,
    required this.senderCurrency,
    required this.senderCurrencySymbol,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.systemIp,
    required this.thirdPartyTransctionRefrenceNumberWithReceiver,
    required this.thirdPartyTransctionRefrenceNumberWithSender,
    required this.transactionFee,
    required this.transactionFeeServiceType,
    required this.transactionFeeType,
    required this.transactionLogo,
    required this.transactionMode,
    required this.transactionNote,
    required this.transactionStep,
    required this.transactionStepWithReceiver,
    required this.transactionStepWithSender,
    required this.transactionType,
    required this.transferType,
    required this.updatedAt,
    required this.qrCode,
    required this.qrCodeLink,
    required this.omSenderNotifToken,
    required this.omSenderPayToken,
    required this.omSenderPaymentUrl,
    required this.omSenderTransactionRef,
    this.planInfo,
    this.ticketdata,
    this.eventId,
    this.eventRefNumber,
    this.eventdata,
    this.payerdata,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      id: json["_id"],
      transactionBctpayRefrenceNumber:
          json["transaction_bctpay_refrence_number"],
      v: json["__v"],
      commissionFee: json["commission_fee"],
      commissionFeeType: json["commission_fee_type"],
      couponCodeApplyStatus: json["coupon_code_apply_status"],
      couponDetails: json["coupon_details"],
      createdAt: DateTime.parse(json["createdAt"]),
      exchangeRate: json["exchange_rate"],
      invoiceNumber: json["invoice_number"],
      mVerifyStatus: json["m_verify_status"],
      cVerifyStatus: json["c_verify_status"],
      paybleCommissionFeeAmount: json["payble_commission_fee_amount"],
      paybleTotalAmount: json["payble_total_amount"],
      paybleTransactionFeeAmount: json["payble_transaction_fee_amount"],
      receiverAccountId: json["receiver_account_id"],
      receiverAccountNumber: json["receiver_account_number"],
      receiverAccountType: json["receiver_account_type"],
      receiverAmount: json["receiver_amount"],
      receiverCurrency: json["receiver_currency"],
      receiverCurrencySymbol: json["receiver_currency_symbol"],
      receiverId: json["receiver_id"],
      receiverName: json["receiver_name"],
      requestedAmount: json["requested_amount"],
      requestedId: json["requested_id"],
      senderAccountNumber: json["sender_account_number"],
      senderAccountType: json["sender_account_type"],
      senderAmount: json["sender_amount"],
      senderBctpayId: json["sender_bctpay_id"],
      senderCountryCode: json["sender_country_code"],
      senderCountryFlag: json["sender_country_flag"],
      senderCountryId: json["sender_country_id"],
      senderCountryName: json["sender_country_name"],
      senderCurrency: json["sender_currency"],
      senderCurrencySymbol: json["sender_currency_symbol"],
      senderId: json["sender_id"],
      senderName: json["sender_name"],
      senderRole: json["sender_role"],
      systemIp: json["system_ip"],
      thirdPartyTransctionRefrenceNumberWithReceiver:
          json["third_party_transction_refrence_number_with_receiver"],
      thirdPartyTransctionRefrenceNumberWithSender:
          json["third_party_transction_refrence_number_with_sender"],
      transactionFee: json["transaction_fee"],
      transactionFeeServiceType: json["transaction_fee_service_type"],
      transactionFeeType: json["transaction_fee_type"],
      transactionLogo: json["transaction_logo"],
      transactionMode: json["transaction_mode"],
      transactionNote: json["transaction_note"],
      transactionStep: json["transaction_step"],
      transactionStepWithReceiver: json["transaction_step_with_receiver"],
      transactionStepWithSender: json["transaction_step_with_sender"],
      transactionType: json["transaction_type"],
      transferType: json["transfer_type"],
      updatedAt: DateTime.tryParse(json["updatedAt"]),
      qrCode: json["qr_code"],
      qrCodeLink: json["qr_code_link"],
      omSenderNotifToken: json["om_sender_notif_token"],
      omSenderPayToken: json["om_sender_pay_token"],
      omSenderPaymentUrl: json["om_sender_payment_url"],
      omSenderTransactionRef: json["om_sender_transaction_ref"],
      planInfo: json["plan_info"] == null
          ? []
          : List<PlanInfo>.from(
              json["plan_info"]!.map((x) => PlanInfo.fromJson(x))),
      ticketdata: json["ticketdata"] == null
          ? []
          : List<TicketData>.from(
              json["ticketdata"]!.map((x) => TicketData.fromJson(x))),
      eventId: json["event_id"],
      eventRefNumber: json["event_ref_number"],
      eventdata: json["eventdata"] == null
          ? null
          : PaymentLinkData.fromJson(json["eventdata"]),
      payerdata: json["payerdata"] == null
          ? null
          : Payerdata.fromJson(json["payerdata"]));

  Map<String, dynamic> toJson() => {
        "_id": id,
        "transaction_bctpay_refrence_number": transactionBctpayRefrenceNumber,
        "__v": v,
        "commission_fee": commissionFee,
        "commission_fee_type": commissionFeeType,
        "coupon_code_apply_status": couponCodeApplyStatus,
        "coupon_details": couponDetails,
        "createdAt": createdAt.toIso8601String(),
        "exchange_rate": exchangeRate,
        "invoice_number": invoiceNumber,
        "m_verify_status": mVerifyStatus,
        "c_verify_status": cVerifyStatus,
        "payble_commission_fee_amount": paybleCommissionFeeAmount,
        "payble_total_amount": paybleTotalAmount,
        "payble_transaction_fee_amount": paybleTransactionFeeAmount,
        "receiver_account_id": receiverAccountId,
        "receiver_account_number": receiverAccountNumber,
        "receiver_account_type": receiverAccountType,
        "receiver_amount": receiverAmount,
        "receiver_currency": receiverCurrency,
        "receiver_currency_symbol": receiverCurrencySymbol,
        "receiver_id": receiverId,
        "receiver_name": receiverName,
        "requested_amount": requestedAmount,
        "requested_id": requestedId,
        "sender_account_number": senderAccountNumber,
        "sender_account_type": senderAccountType,
        "sender_amount": senderAmount,
        "sender_bctpay_id": senderBctpayId,
        "sender_country_code": senderCountryCode,
        "sender_country_flag": senderCountryFlag,
        "sender_country_id": senderCountryId,
        "sender_country_name": senderCountryName,
        "sender_currency": senderCurrency,
        "sender_currency_symbol": senderCurrencySymbol,
        "sender_id": senderId,
        "sender_name": senderName,
        "sender_role": senderRole,
        "system_ip": systemIp,
        "third_party_transction_refrence_number_with_receiver":
            thirdPartyTransctionRefrenceNumberWithReceiver,
        "third_party_transction_refrence_number_with_sender":
            thirdPartyTransctionRefrenceNumberWithSender,
        "transaction_fee": transactionFee,
        "transaction_fee_service_type": transactionFeeServiceType,
        "transaction_fee_type": transactionFeeType,
        "transaction_logo": transactionLogo,
        "transaction_mode": transactionMode,
        "transaction_note": transactionNote,
        "transaction_step": transactionStep,
        "transaction_step_with_receiver": transactionStepWithReceiver,
        "transaction_step_with_sender": transactionStepWithSender,
        "transaction_type": transactionType,
        "transfer_type": transferType,
        "updatedAt": updatedAt?.toIso8601String(),
        "qr_code": qrCode,
        "qr_code_link": qrCodeLink,
        "om_sender_notif_token": omSenderNotifToken,
        "om_sender_pay_token": omSenderPayToken,
        "om_sender_payment_url": omSenderPaymentUrl,
        "om_sender_transaction_ref": omSenderTransactionRef,
        "plan_info": planInfo,
        "ticketdata": ticketdata,
        "event_id": eventId,
        "event_ref_number": eventRefNumber,
        "eventdata": eventdata,
        "payerdata": payerdata,
      };
}

class UserData {
  final String? phoneNumber;
  final String? countryFlag;
  final String? phoneCode;
  final String? senderLogo;
  final String? receiverLogo;
  UserData({
    required this.phoneNumber,
    required this.countryFlag,
    required this.phoneCode,
    this.senderLogo,
    this.receiverLogo,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      phoneNumber: json["phone_number"],
      countryFlag: json["country_flag"],
      phoneCode: json["phone_code"],
      senderLogo: json["sender_logo"],
      receiverLogo: json["receiver_logo"]);

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "country_flag": countryFlag,
        "phone_code": phoneCode,
        "sender_logo": senderLogo,
        "receiver_logo": receiverLogo,
      };
}
