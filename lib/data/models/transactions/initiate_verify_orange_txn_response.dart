class InitiateVerifyOrangeTxnResponse {
  final int code;
  final InitialteVerifyOrangeTxnData? data;
  final String message;
  final bool? success;

  InitiateVerifyOrangeTxnResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory InitiateVerifyOrangeTxnResponse.fromJson(Map<String, dynamic> json) =>
      InitiateVerifyOrangeTxnResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : InitialteVerifyOrangeTxnData.fromJson(json["data"]),
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

class InitialteVerifyOrangeTxnData {
  final String id;
  final String? userId;
  final String? userType;
  final String? phoneCode;
  final String? phoneNumber;
  final String? verificationStatus;
  final String? transactionRefNumberToVerify;
  final String? transactionRefNumberToRefund;
  final String? userCountryId;
  final String? userCountryName;
  final String? userCountryCode;
  final String? userCountryFlag;
  final String? userCountryTimezone;
  final String? amount;
  final String? currency;
  final String? currencySymbol;
  final String? omPaymentUrl;
  final String? omNotifToken;
  final String? omPayToken;
  final String? omTransactionRef;
  final String? exchangeRate;
  final String? transactionNoteToVerify;
  final String? transactionNoteToRefund;
  final String? verificationTransactionStep;
  final String? refundTransactionStep;
  final String? transactionModeToVerify;
  final String? transactionModeToRefund;
  final String? paybleTotalAmount;
  final String? thirdPartyTransactionRefrenceNumberWithUser;
  final String? thirdPartyTransactionRefrenceNumberWithBctpay;
  final String? systemIp;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  InitialteVerifyOrangeTxnData({
    required this.id,
    required this.userId,
    required this.userType,
    required this.phoneCode,
    required this.phoneNumber,
    required this.verificationStatus,
    required this.transactionRefNumberToVerify,
    required this.transactionRefNumberToRefund,
    required this.userCountryId,
    required this.userCountryName,
    required this.userCountryCode,
    required this.userCountryFlag,
    required this.userCountryTimezone,
    required this.amount,
    required this.currency,
    required this.currencySymbol,
    required this.omPaymentUrl,
    required this.omNotifToken,
    required this.omPayToken,
    required this.omTransactionRef,
    required this.exchangeRate,
    required this.transactionNoteToVerify,
    required this.transactionNoteToRefund,
    required this.verificationTransactionStep,
    required this.refundTransactionStep,
    required this.transactionModeToVerify,
    required this.transactionModeToRefund,
    required this.paybleTotalAmount,
    required this.thirdPartyTransactionRefrenceNumberWithUser,
    required this.thirdPartyTransactionRefrenceNumberWithBctpay,
    required this.systemIp,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory InitialteVerifyOrangeTxnData.fromJson(Map<String, dynamic> json) =>
      InitialteVerifyOrangeTxnData(
        id: json["_id"],
        userId: json["user_id"],
        userType: json["user_type"],
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
        verificationStatus: json["verification_status"],
        transactionRefNumberToVerify: json["transaction_ref_number_to_verify"],
        transactionRefNumberToRefund: json["transaction_ref_number_to_refund"],
        userCountryId: json["user_country_id"],
        userCountryName: json["user_country_name"],
        userCountryCode: json["user_country_code"],
        userCountryFlag: json["user_country_flag"],
        userCountryTimezone: json["user_country_timezone"],
        amount: json["amount"],
        currency: json["currency"],
        currencySymbol: json["currency_symbol"],
        omPaymentUrl: json["om_payment_url"],
        omNotifToken: json["om_notif_token"],
        omPayToken: json["om_pay_token"],
        omTransactionRef: json["om_transaction_ref"],
        exchangeRate: json["exchange_rate"],
        transactionNoteToVerify: json["transaction_note_to_verify"],
        transactionNoteToRefund: json["transaction_note_to_refund"],
        verificationTransactionStep: json["verification_transaction_step"],
        refundTransactionStep: json["refund_transaction_step"],
        transactionModeToVerify: json["transaction_mode_to_verify"],
        transactionModeToRefund: json["transaction_mode_to_refund"],
        paybleTotalAmount: json["payble_total_amount"],
        thirdPartyTransactionRefrenceNumberWithUser:
            json["third_party_transaction_refrence_number_with_user"],
        thirdPartyTransactionRefrenceNumberWithBctpay:
            json["third_party_transaction_refrence_number_with_bctpay"],
        systemIp: json["system_ip"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "user_type": userType,
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "verification_status": verificationStatus,
        "transaction_ref_number_to_verify": transactionRefNumberToVerify,
        "transaction_ref_number_to_refund": transactionRefNumberToRefund,
        "user_country_id": userCountryId,
        "user_country_name": userCountryName,
        "user_country_code": userCountryCode,
        "user_country_flag": userCountryFlag,
        "user_country_timezone": userCountryTimezone,
        "amount": amount,
        "currency": currency,
        "currency_symbol": currencySymbol,
        "om_payment_url": omPaymentUrl,
        "om_notif_token": omNotifToken,
        "om_pay_token": omPayToken,
        "om_transaction_ref": omTransactionRef,
        "exchange_rate": exchangeRate,
        "transaction_note_to_verify": transactionNoteToVerify,
        "transaction_note_to_refund": transactionNoteToRefund,
        "verification_transaction_step": verificationTransactionStep,
        "refund_transaction_step": refundTransactionStep,
        "transaction_mode_to_verify": transactionModeToVerify,
        "transaction_mode_to_refund": transactionModeToRefund,
        "payble_total_amount": paybleTotalAmount,
        "third_party_transaction_refrence_number_with_user":
            thirdPartyTransactionRefrenceNumberWithUser,
        "third_party_transaction_refrence_number_with_bctpay":
            thirdPartyTransactionRefrenceNumberWithBctpay,
        "system_ip": systemIp,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
