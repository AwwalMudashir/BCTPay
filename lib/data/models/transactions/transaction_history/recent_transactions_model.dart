import 'package:bctpay/globals/index.dart';

class RecentTransactionsResponse {
  final int code;
  final List<Transaction>? data;
  final String message;
  final bool? success;

  RecentTransactionsResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory RecentTransactionsResponse.fromMap(Map<String, dynamic> json) =>
      RecentTransactionsResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<Transaction>.from(
                json["data"].map((x) => Transaction.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

// class Transaction {
//   final String id;
//   final String customerId;
//   final String payerName;
//   final String payerMobile;
//   final String payerAmount;
//   final String payerCurrency;
//   final String payerCurrencySymbol;
//   final String payerAccount;
//   final String payerAccountId;
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
//   final String? externalTrasactionId;

//   Transaction({
//     required this.id,
//     required this.customerId,
//     required this.payerName,
//     required this.payerMobile,
//     required this.payerAmount,
//     required this.payerCurrency,
//     required this.payerCurrencySymbol,
//     required this.payerAccount,
//     required this.payerAccountId,
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
//   });

//   factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
//         id: json["_id"],
//         customerId: json["customerId"],
//         payerName: json["payerName"],
//         payerMobile: json["payerMobile"],
//         payerAmount: json["payerAmount"],
//         payerCurrency: json["payerCurrency"],
//         payerCurrencySymbol: json["payer_currency_symbol"],
//         payerAccount: json["payer_account"],
//         payerAccountId: json["payer_account_id"],
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
//       );

//   Map<String, dynamic> toMap() => {
//         "_id": id,
//         "customerId": customerId,
//         "payerName": payerName,
//         "payerMobile": payerMobile,
//         "payerAmount": payerAmount,
//         "payerCurrency": payerCurrency,
//         "payer_currency_symbol": payerCurrencySymbol,
//         "payer_account": payerAccount,
//         "payer_account_id": payerAccountId,
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
//       };
// }
