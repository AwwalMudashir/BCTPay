import 'package:bctpay/globals/index.dart';

class RecentBillTransactionResponse {
  final int code;
  final List<Bill>? data;
  final String message;
  final bool? success;

  RecentBillTransactionResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory RecentBillTransactionResponse.fromJson(Map<String, dynamic> json) =>
      RecentBillTransactionResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<Bill>.from(json["data"].map((x) => Bill.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

// class RechargeData {
//   final String id;
//   final String customerId;
//   final String payerRole;
//   final String payerName;
//   final String payerMobile;
//   final String payerAmount;
//   final String payerCurrency;
//   final String payerCurrencySymbol;
//   final String payerAccount;
//   final String payerAccountId;
//   final String receiverRole;
//   final String receiverName;
//   final String receiverMobile;
//   final String receiverAmount;
//   final String receiverCurrency;
//   final String receiverCurrencySymbol;
//   final String receiverAccount;
//   final String receiverAccountId;
//   final String transactionRefrenceNo;
//   final String transactionId;
//   final String orderRefrenceNo;
//   final String orderId;
//   final String paymentMode;
//   final String payableAmount;
//   final String fintechFee;
//   final String paymentStatus;
//   final String senderNotes;
//   final String systemIp;
//   final String externalTrasactionId;
//   final String paymentComingfrom;
//   final String paymentGoingto;
//   final String? payerTransactionlogo;
//   final String customerPaymenttype;
//   final BillerId? billerId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   RechargeData({
//     required this.id,
//     required this.customerId,
//     required this.payerRole,
//     required this.payerName,
//     required this.payerMobile,
//     required this.payerAmount,
//     required this.payerCurrency,
//     required this.payerCurrencySymbol,
//     required this.payerAccount,
//     required this.payerAccountId,
//     required this.receiverRole,
//     required this.receiverName,
//     required this.receiverMobile,
//     required this.receiverAmount,
//     required this.receiverCurrency,
//     required this.receiverCurrencySymbol,
//     required this.receiverAccount,
//     required this.receiverAccountId,
//     required this.transactionRefrenceNo,
//     required this.transactionId,
//     required this.orderRefrenceNo,
//     required this.orderId,
//     required this.paymentMode,
//     required this.payableAmount,
//     required this.fintechFee,
//     required this.paymentStatus,
//     required this.senderNotes,
//     required this.systemIp,
//     required this.externalTrasactionId,
//     required this.paymentComingfrom,
//     required this.paymentGoingto,
//     required this.payerTransactionlogo,
//     required this.customerPaymenttype,
//     required this.billerId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory RechargeData.fromJson(Map<String, dynamic> json) => RechargeData(
//         id: json["_id"],
//         customerId: json["customerId"],
//         payerRole: json["payerRole"],
//         payerName: json["payerName"],
//         payerMobile: json["payerMobile"],
//         payerAmount: json["payerAmount"],
//         payerCurrency: json["payerCurrency"],
//         payerCurrencySymbol: json["payer_currency_symbol"],
//         payerAccount: json["payer_account"],
//         payerAccountId: json["payer_account_id"],
//         receiverRole: json["receiverRole"],
//         receiverName: json["receiverName"],
//         receiverMobile: json["receiverMobile"],
//         receiverAmount: json["receiverAmount"],
//         receiverCurrency: json["receiverCurrency"],
//         receiverCurrencySymbol: json["receiver_currency_symbol"],
//         receiverAccount: json["receiver_account"],
//         receiverAccountId: json["receiver_account_id"],
//         transactionRefrenceNo: json["TransactionRefrenceNo"],
//         transactionId: json["TransactionID"],
//         orderRefrenceNo: json["OrderRefrenceNo"],
//         orderId: json["orderId"],
//         paymentMode: json["paymentMode"],
//         payableAmount: json["payable_amount"],
//         fintechFee: json["fintech_fee"],
//         paymentStatus: json["payment_status"],
//         senderNotes: json["sender_notes"],
//         systemIp: json["system_ip"],
//         externalTrasactionId: json["external_trasaction_id"],
//         paymentComingfrom: json["payment_comingfrom"],
//         paymentGoingto: json["payment_goingto"],
//         payerTransactionlogo: json["payer_transactionlogo"],
//         customerPaymenttype: json["customer_paymenttype"],
//         billerId: json["billerId"] == null
//             ? null
//             : BillerId.fromJson(json["billerId"]),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "customerId": customerId,
//         "payerRole": payerRole,
//         "payerName": payerName,
//         "payerMobile": payerMobile,
//         "payerAmount": payerAmount,
//         "payerCurrency": payerCurrency,
//         "payer_currency_symbol": payerCurrencySymbol,
//         "payer_account": payerAccount,
//         "payer_account_id": payerAccountId,
//         "receiverRole": receiverRole,
//         "receiverName": receiverName,
//         "receiverMobile": receiverMobile,
//         "receiverAmount": receiverAmount,
//         "receiverCurrency": receiverCurrency,
//         "receiver_currency_symbol": receiverCurrencySymbol,
//         "receiver_account": receiverAccount,
//         "receiver_account_id": receiverAccountId,
//         "TransactionRefrenceNo": transactionRefrenceNo,
//         "TransactionID": transactionId,
//         "OrderRefrenceNo": orderRefrenceNo,
//         "orderId": orderId,
//         "paymentMode": paymentMode,
//         "payable_amount": payableAmount,
//         "fintech_fee": fintechFee,
//         "payment_status": paymentStatus,
//         "sender_notes": senderNotes,
//         "system_ip": systemIp,
//         "external_trasaction_id": externalTrasactionId,
//         "payment_comingfrom": paymentComingfrom,
//         "payment_goingto": paymentGoingto,
//         "payer_transactionlogo": payerTransactionlogo,
//         "customer_paymenttype": customerPaymenttype,
//         "billerId": billerId!.toJson(),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }

// class BillerId {
//   final String id;
//   final String? customerId;
//   final String providerCode;
//   final String productCode;
//   final String regionCode;
//   final String customerAccountNumber;
//   final String distributerRef;
//   final String billRef;
//   final String settings;
//   final String payerRole;
//   final String payerName;
//   final String payerMobile;
//   final String payerAmount;
//   final String payerCurrency;
//   final String payerCurrencySymbol;
//   final String payerAccount;
//   final String payerAccountId;
//   final String receiverName;
//   final String receiverAmount;
//   final String receiverCurrency;
//   final String receiverCurrencySymbol;
//   final String? transactionRef;
//   final String? transactionId;
//   final String? orderRef;
//   final String? orderId;
//   final String? paymentMode;
//   final String? payableAmount;
//   final String? fintechFee;
//   final String? paymentStatus;
//   final String? senderNotes;
//   final String? systemIp;
//   final String? externalTrasactionId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   BillerId({
//     required this.id,
//     required this.customerId,
//     required this.providerCode,
//     required this.productCode,
//     required this.regionCode,
//     required this.customerAccountNumber,
//     required this.distributerRef,
//     required this.billRef,
//     required this.settings,
//     required this.payerRole,
//     required this.payerName,
//     required this.payerMobile,
//     required this.payerAmount,
//     required this.payerCurrency,
//     required this.payerCurrencySymbol,
//     required this.payerAccount,
//     required this.payerAccountId,
//     required this.receiverName,
//     required this.receiverAmount,
//     required this.receiverCurrency,
//     required this.receiverCurrencySymbol,
//     required this.transactionRef,
//     required this.transactionId,
//     required this.orderRef,
//     required this.orderId,
//     required this.paymentMode,
//     required this.payableAmount,
//     required this.fintechFee,
//     required this.paymentStatus,
//     required this.senderNotes,
//     required this.systemIp,
//     required this.externalTrasactionId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory BillerId.fromJson(Map<String, dynamic> json) => BillerId(
//         id: json["_id"],
//         customerId: json["customerId"],
//         providerCode: json["provider_code"],
//         productCode: json["product_code"],
//         regionCode: json["region_code"],
//         customerAccountNumber: json["customer_account_number"],
//         distributerRef: json["distributer_ref"],
//         billRef: json["bill_ref"],
//         settings: json["settings"],
//         payerRole: json["payer_role"],
//         payerName: json["payer_name"],
//         payerMobile: json["payer_mobile"],
//         payerAmount: json["payer_amount"],
//         payerCurrency: json["payer_currency"],
//         payerCurrencySymbol: json["payer_currency_symbol"],
//         payerAccount: json["payer_account"],
//         payerAccountId: json["payer_account_id"],
//         receiverName: json["receiver_name"],
//         receiverAmount: json["receiver_amount"],
//         receiverCurrency: json["receiver_currency"],
//         receiverCurrencySymbol: json["receiver_currency_symbol"],
//         transactionRef: json["transaction_ref"],
//         transactionId: json["transaction_id"],
//         orderRef: json["order_ref"],
//         orderId: json["order_id"],
//         paymentMode: json["payment_mode"],
//         payableAmount: json["payable_amount"],
//         fintechFee: json["fintech_fee"],
//         paymentStatus: json["payment_status"],
//         senderNotes: json["sender_notes"],
//         systemIp: json["system_ip"],
//         externalTrasactionId: json["external_trasaction_id"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "customerId": customerId,
//         "provider_code": providerCode,
//         "product_code": productCode,
//         "region_code": regionCode,
//         "customer_account_number": customerAccountNumber,
//         "distributer_ref": distributerRef,
//         "bill_ref": billRef,
//         "settings": settings,
//         "payer_role": payerRole,
//         "payer_name": payerName,
//         "payer_mobile": payerMobile,
//         "payer_amount": payerAmount,
//         "payer_currency": payerCurrency,
//         "payer_currency_symbol": payerCurrencySymbol,
//         "payer_account": payerAccount,
//         "payer_account_id": payerAccountId,
//         "receiver_name": receiverName,
//         "receiver_amount": receiverAmount,
//         "receiver_currency": receiverCurrency,
//         "receiver_currency_symbol": receiverCurrencySymbol,
//         "transaction_ref": transactionRef,
//         "transaction_id": transactionId,
//         "order_ref": orderRef,
//         "order_id": orderId,
//         "payment_mode": paymentMode,
//         "payable_amount": payableAmount,
//         "fintech_fee": fintechFee,
//         "payment_status": paymentStatus,
//         "sender_notes": senderNotes,
//         "system_ip": systemIp,
//         "external_trasaction_id": externalTrasactionId,
//         "createdAt": createdAt!.toIso8601String(),
//         "updatedAt": updatedAt!.toIso8601String(),
//         "__v": v,
//       };
// }
