class BillPaymentResponse {
  final int code;
  final Bill? data;
  final String message;
  final bool? success;

  BillPaymentResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory BillPaymentResponse.fromJson(Map<String, dynamic> json) =>
      BillPaymentResponse(
        code: json["code"],
        data: json["data"] == null ? null : Bill.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data!.toJson(),
        "message": message,
        "success": success,
      };
}

class Bill {
  final String? customerId;
  final String? payerRole;
  final String? payerName;
  final String? payerMobile;
  final String? payerAmount;
  final String? payerCurrency;
  final String? payerCurrencySymbol;
  final String? payerAccount;
  final String? payerAccountId;
  final String? receiverRole;
  final String? receiverName;
  final String? receiverMobile;
  final String? receiverAmount;
  final String? receiverCurrency;
  final String? receiverCurrencySymbol;
  final String? receiverAccount;
  final String? receiverAccountId;
  final String? transactionRefrenceNo;
  final String? transactionId;
  final String? orderRefrenceNo;
  final String? orderId;
  final String? paymentMode;
  final String? payableAmount;
  final String? fintechFee;
  final String? paymentStatus;
  final String? senderNotes;
  final String? systemIp;
  final String? externalTrasactionId;
  final String? paymentComingfrom;
  final String? paymentGoingto;
  final String? payerTransactionlogo;
  final String? customerPaymenttype;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  //error data
  final List<dynamic>? items;
  final int? resultCode;
  final List<ErrorCode>? errorCodes;

  Bill({
    required this.customerId,
    required this.payerRole,
    required this.payerName,
    required this.payerMobile,
    required this.payerAmount,
    required this.payerCurrency,
    required this.payerCurrencySymbol,
    required this.payerAccount,
    required this.payerAccountId,
    required this.receiverRole,
    required this.receiverName,
    required this.receiverMobile,
    required this.receiverAmount,
    required this.receiverCurrency,
    required this.receiverCurrencySymbol,
    required this.receiverAccount,
    required this.receiverAccountId,
    required this.transactionRefrenceNo,
    required this.transactionId,
    required this.orderRefrenceNo,
    required this.orderId,
    required this.paymentMode,
    required this.payableAmount,
    required this.fintechFee,
    required this.paymentStatus,
    required this.senderNotes,
    required this.systemIp,
    required this.externalTrasactionId,
    required this.paymentComingfrom,
    required this.paymentGoingto,
    required this.payerTransactionlogo,
    required this.customerPaymenttype,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.items,
    required this.resultCode,
    required this.errorCodes,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        customerId: json["customerId"],
        payerRole: json["payerRole"],
        payerName: json["payerName"],
        payerMobile: json["payerMobile"],
        payerAmount: json["payerAmount"],
        payerCurrency: json["payerCurrency"],
        payerCurrencySymbol: json["payer_currency_symbol"],
        payerAccount: json["payer_account"],
        payerAccountId: json["payer_account_id"],
        receiverRole: json["receiverRole"],
        receiverName: json["receiverName"],
        receiverMobile: json["receiverMobile"],
        receiverAmount: json["receiverAmount"],
        receiverCurrency: json["receiverCurrency"],
        receiverCurrencySymbol: json["receiver_currency_symbol"],
        receiverAccount: json["receiver_account"],
        receiverAccountId: json["receiver_account_id"],
        transactionRefrenceNo: json["TransactionRefrenceNo"],
        transactionId: json["TransactionID"],
        orderRefrenceNo: json["OrderRefrenceNo"],
        orderId: json["orderId"],
        paymentMode: json["paymentMode"],
        payableAmount: json["payable_amount"],
        fintechFee: json["fintech_fee"],
        paymentStatus: json["payment_status"],
        senderNotes: json["sender_notes"],
        systemIp: json["system_ip"],
        externalTrasactionId: json["external_trasaction_id"],
        paymentComingfrom: json["payment_comingfrom"],
        paymentGoingto: json["payment_goingto"],
        payerTransactionlogo: json["payer_transactionlogo"],
        customerPaymenttype: json["customer_paymenttype"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
        v: json["__v"],
        items: json["Items"] == null
            ? null
            : List<dynamic>.from(json["Items"].map((x) => x)),
        resultCode: json["ResultCode"],
        errorCodes: json["ErrorCodes"] == null
            ? null
            : List<ErrorCode>.from(
                json["ErrorCodes"].map((x) => ErrorCode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "payerRole": payerRole,
        "payerName": payerName,
        "payerMobile": payerMobile,
        "payerAmount": payerAmount,
        "payerCurrency": payerCurrency,
        "payer_currency_symbol": payerCurrencySymbol,
        "payer_account": payerAccount,
        "payer_account_id": payerAccountId,
        "receiverRole": receiverRole,
        "receiverName": receiverName,
        "receiverMobile": receiverMobile,
        "receiverAmount": receiverAmount,
        "receiverCurrency": receiverCurrency,
        "receiver_currency_symbol": receiverCurrencySymbol,
        "receiver_account": receiverAccount,
        "receiver_account_id": receiverAccountId,
        "TransactionRefrenceNo": transactionRefrenceNo,
        "TransactionID": transactionId,
        "OrderRefrenceNo": orderRefrenceNo,
        "orderId": orderId,
        "paymentMode": paymentMode,
        "payable_amount": payableAmount,
        "fintech_fee": fintechFee,
        "payment_status": paymentStatus,
        "sender_notes": senderNotes,
        "system_ip": systemIp,
        "external_trasaction_id": externalTrasactionId,
        "payment_comingfrom": paymentComingfrom,
        "payment_goingto": paymentGoingto,
        "payer_transactionlogo": payerTransactionlogo,
        "customer_paymenttype": customerPaymenttype,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class ErrorCode {
  final String code;

  ErrorCode({
    required this.code,
  });

  factory ErrorCode.fromJson(Map<String, dynamic> json) => ErrorCode(
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
      };
}
