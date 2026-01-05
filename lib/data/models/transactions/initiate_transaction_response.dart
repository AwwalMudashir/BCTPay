import 'dart:convert';

class InitiateTransactionResponse {
  int code;
  InitialteTxnData? data;
  String message;
  bool? success;

  InitiateTransactionResponse({
    required this.code,
    this.data,
    required this.message,
    this.success,
  });

  factory InitiateTransactionResponse.fromMap(Map<String, dynamic> data) {
    return InitiateTransactionResponse(
      code: data['code'],
      data: data['data'] == null
          ? null
          : InitialteTxnData.fromMap(data['data'] as Map<String, dynamic>),
      message: data['message'],
      success: data['success'],
    );
  }

  Map<String, dynamic> toMap() => {
        'code': code,
        'data': data?.toMap(),
        'message': message,
        'success': success,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [InitiateTransactionResponse].
  factory InitiateTransactionResponse.fromJson(String data) {
    return InitiateTransactionResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [InitiateTransactionResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}

class InitialteTxnData {
  String? senderId;
  String? senderBctpayId;
  String? senderName;
  String? senderRole;
  String? senderAccountNumber;
  String? senderAccountType;
  String? senderCountryId;
  String? senderCountryName;
  String? senderCountryCode;
  String? senderCountryFlag;
  String? senderAmount;
  String? senderCurrency;
  String? senderCurrencySymbol;
  String? receiverName;
  String? receiver_account_id;
  String? receiverAccountNumber;
  String? receiverAccountType;
  String? receiverAmount;
  String? receiverCurrency;
  String? receiverCurrencySymbol;
  String? couponCodeApplyStatus;
  dynamic couponDetails;
  String? commissionFee;
  String? commissionFeeType;
  String? paybleCommissionFeeAmount;
  String? transactionFee;
  String? transactionFeeType;
  String? transactionFeeServiceType;
  String? paybleTransactionFeeAmount;
  String? exchangeRate;
  String? transactionNote;
  String? transactionStep;
  String? transactionMode;
  String? transactionType;
  String? transactionLogo;
  String? transactionBctpayRefrenceNumber;
  String? paybleTotalAmount;
  String? thirdPartyTransctionRefrenceNumber;
  String? systemIp;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  final String? omSenderNotifToken;
  final String? omSenderPayToken;
  final String? omSenderPaymentUrl;
  final String? thirdPartyTransctionRefrenceNumberWithSender;
  final String? transactionStepWithSender;
  final String? transactionStepWithReceiver;
  final String? senderEFTCompletionUrl;
  final String? senderEFTCustomerId;
  final String? senderEFTDestinationWalletId;
  final String? senderEFTGatewayTransactionId;
  final String? senderEFTPaymentId;

  InitialteTxnData({
    this.senderId,
    this.senderBctpayId,
    this.senderName,
    this.senderRole,
    this.senderAccountNumber,
    this.senderAccountType,
    this.senderCountryId,
    this.senderCountryName,
    this.senderCountryCode,
    this.senderCountryFlag,
    this.senderAmount,
    this.senderCurrency,
    this.senderCurrencySymbol,
    this.receiverName,
    this.receiver_account_id,
    this.receiverAccountNumber,
    this.receiverAccountType,
    this.receiverAmount,
    this.receiverCurrency,
    this.receiverCurrencySymbol,
    this.couponCodeApplyStatus,
    this.couponDetails,
    this.commissionFee,
    this.commissionFeeType,
    this.paybleCommissionFeeAmount,
    this.transactionFee,
    this.transactionFeeType,
    this.transactionFeeServiceType,
    this.paybleTransactionFeeAmount,
    this.exchangeRate,
    this.transactionNote,
    this.transactionStep,
    this.transactionMode,
    this.transactionType,
    this.transactionLogo,
    this.transactionBctpayRefrenceNumber,
    this.paybleTotalAmount,
    this.thirdPartyTransctionRefrenceNumber,
    this.systemIp,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.omSenderNotifToken,
    this.omSenderPayToken,
    this.omSenderPaymentUrl,
    this.thirdPartyTransctionRefrenceNumberWithSender,
    this.transactionStepWithSender,
    this.transactionStepWithReceiver,
    this.senderEFTCompletionUrl,
    this.senderEFTCustomerId,
    this.senderEFTDestinationWalletId,
    this.senderEFTGatewayTransactionId,
    this.senderEFTPaymentId,
  });

  factory InitialteTxnData.fromMap(Map<String, dynamic> data) =>
      InitialteTxnData(
        senderId: data['sender_id'] as String?,
        senderBctpayId: data['sender_bctpay_id'] as String?,
        senderName: data['sender_name'] as String?,
        senderRole: data['sender_role'] as String?,
        senderAccountNumber: data['sender_account_number'] as String?,
        senderAccountType: data['sender_account_type'] as String?,
        senderCountryId: data['sender_country_id'] as String?,
        senderCountryName: data['sender_country_name'] as String?,
        senderCountryCode: data['sender_country_code'] as String?,
        senderCountryFlag: data['sender_country_flag'] as String?,
        senderAmount: data['sender_amount'] as String?,
        senderCurrency: data['sender_currency'] as String?,
        senderCurrencySymbol: data['sender_currency_symbol'] as String?,
        receiverName: data['receiver_name'] as String?,
        receiver_account_id: data['receiver_account_id'] as String?,
        receiverAccountNumber: data['receiver_account_number'] as String?,
        receiverAccountType: data['receiver_account_type'] as String?,
        receiverAmount: data['receiver_amount'] as String?,
        receiverCurrency: data['receiver_currency'] as String?,
        receiverCurrencySymbol: data['receiver_currency_symbol'] as String?,
        couponCodeApplyStatus: data['coupon_code_apply_status'] as String?,
        couponDetails: data['coupon_details'] as dynamic,
        commissionFee: data['commission_fee'] as String?,
        commissionFeeType: data['commission_fee_type'] as String?,
        paybleCommissionFeeAmount:
            data['payble_commission_fee_amount'] as String?,
        transactionFee: data['transaction_fee'] as String?,
        transactionFeeType: data['transaction_fee_type'] as String?,
        transactionFeeServiceType:
            data['transaction_fee_service_type'] as String?,
        paybleTransactionFeeAmount:
            data['payble_transaction_fee_amount'] as String?,
        exchangeRate: data['exchange_rate'] as String?,
        transactionNote: data['transaction_note'] as String?,
        transactionStep: data['transaction_step'] as String?,
        transactionMode: data['transaction_mode'] as String?,
        transactionType: data['transaction_type'] as String?,
        transactionLogo: data['transaction_logo'] as String?,
        transactionBctpayRefrenceNumber:
            data['transaction_bctpay_refrence_number'] as String?,
        paybleTotalAmount: data['payble_total_amount'] as String?,
        thirdPartyTransctionRefrenceNumber:
            data['third_party_transction_refrence_number'] as String?,
        systemIp: data['system_ip'] as String?,
        id: data['_id'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        v: data['__v'] as int?,
        omSenderNotifToken: data["om_sender_notif_token"],
        omSenderPayToken: data["om_sender_pay_token"],
        omSenderPaymentUrl: data["om_sender_payment_url"],
        thirdPartyTransctionRefrenceNumberWithSender:
            data["third_party_transction_refrence_number_with_sender"],
        transactionStepWithSender: data["transaction_step_with_sender"],
        transactionStepWithReceiver: data["transaction_step_with_receiver"],
        senderEFTCompletionUrl: data["sender_eFT_completion_url"],
        senderEFTCustomerId: data["sender_eFT_customer_id"],
        senderEFTDestinationWalletId: data["sender_eFT_destination_wallet_id"],
        senderEFTGatewayTransactionId:
            data["sender_eFT_gateway_transaction_id"],
        senderEFTPaymentId: data["sender_eFT_payment_id"],
      );

  Map<String, dynamic> toMap() => {
        'sender_id': senderId,
        'sender_bctpay_id': senderBctpayId,
        'sender_name': senderName,
        'sender_role': senderRole,
        'sender_account_number': senderAccountNumber,
        'sender_account_type': senderAccountType,
        'sender_country_id': senderCountryId,
        'sender_country_name': senderCountryName,
        'sender_country_code': senderCountryCode,
        'sender_country_flag': senderCountryFlag,
        'sender_amount': senderAmount,
        'sender_currency': senderCurrency,
        'sender_currency_symbol': senderCurrencySymbol,
        'receiver_name': receiverName,
        'receiver_account_id': receiver_account_id,
        'receiver_account_number': receiverAccountNumber,
        'receiver_account_type': receiverAccountType,
        'receiver_amount': receiverAmount,
        'receiver_currency': receiverCurrency,
        'receiver_currency_symbol': receiverCurrencySymbol,
        'coupon_code_apply_status': couponCodeApplyStatus,
        'coupon_details': couponDetails,
        'commission_fee': commissionFee,
        'commission_fee_type': commissionFeeType,
        'payble_commission_fee_amount': paybleCommissionFeeAmount,
        'transaction_fee': transactionFee,
        'transaction_fee_type': transactionFeeType,
        'transaction_fee_service_type': transactionFeeServiceType,
        'payble_transaction_fee_amount': paybleTransactionFeeAmount,
        'exchange_rate': exchangeRate,
        'transaction_note': transactionNote,
        'transaction_step': transactionStep,
        'transaction_mode': transactionMode,
        'transaction_type': transactionType,
        'transaction_logo': transactionLogo,
        'transaction_bctpay_refrence_number': transactionBctpayRefrenceNumber,
        'payble_total_amount': paybleTotalAmount,
        'third_party_transction_refrence_number':
            thirdPartyTransctionRefrenceNumber,
        'system_ip': systemIp,
        '_id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        "om_sender_notif_token": omSenderNotifToken,
        "om_sender_pay_token": omSenderPayToken,
        "om_sender_payment_url": omSenderPaymentUrl,
        "third_party_transction_refrence_number_with_sender":
            thirdPartyTransctionRefrenceNumberWithSender,
        "transaction_step_with_sender": transactionStepWithSender,
        "transaction_step_with_receiver": transactionStepWithReceiver,
        "sender_eFT_completion_url": senderEFTCompletionUrl,
        "sender_eFT_customer_id": senderEFTCustomerId,
        "sender_eFT_destination_wallet_id": senderEFTDestinationWalletId,
        "sender_eFT_gateway_transaction_id": senderEFTGatewayTransactionId,
        "sender_eFT_payment_id": senderEFTPaymentId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [InitialteTxnData].
  factory InitialteTxnData.fromJson(String data) {
    return InitialteTxnData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [InitialteTxnData] to a JSON string.
  String toJson() => json.encode(toMap());
}
