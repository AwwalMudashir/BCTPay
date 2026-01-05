import 'package:bctpay/data/models/transactions/payment_request/request_to_pay_response.dart';

class PaymentRequestsByOtherResponse {
  final int code;
  final PaymentRequestsByOtherData? data;
  final String message;
  final bool? success;

  PaymentRequestsByOtherResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory PaymentRequestsByOtherResponse.fromJson(Map<String, dynamic> json) =>
      PaymentRequestsByOtherResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : PaymentRequestsByOtherData.fromJson(json["data"]),
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

class PaymentRequestsByOtherData {
  final List<PaymentRequest> list;
  final int count;

  PaymentRequestsByOtherData({
    required this.list,
    required this.count,
  });

  factory PaymentRequestsByOtherData.fromJson(Map<String, dynamic> json) =>
      PaymentRequestsByOtherData(
        list: List<PaymentRequest>.from(
            json["list"].map((x) => PaymentRequest.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "count": count,
      };
}

// class ListElement {
//   final String id;
//   final String requestToPayUserPhoneCode;
//   final String requestToPayUserPhoneNumber;
//   final String senderId;
//   final String senderBctpayId;
//   final String senderName;
//   final String senderRole;
//   final String senderCountryName;
//   final String senderCountryCode;
//   final String requestedAmount;
//   final String requestedCurrency;
//   final String receiverId;
//   final String receiverBctpayId;
//   final String receiverName;
//   final String receiverRole;
//   final String receiverCountryName;
//   final String receiverCountryCode;
//   final String receiverAccountId;
//   final String payNote;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   ListElement({
//     required this.id,
//     required this.requestToPayUserPhoneCode,
//     required this.requestToPayUserPhoneNumber,
//     required this.senderId,
//     required this.senderBctpayId,
//     required this.senderName,
//     required this.senderRole,
//     required this.senderCountryName,
//     required this.senderCountryCode,
//     required this.requestedAmount,
//     required this.requestedCurrency,
//     required this.receiverId,
//     required this.receiverBctpayId,
//     required this.receiverName,
//     required this.receiverRole,
//     required this.receiverCountryName,
//     required this.receiverCountryCode,
//     required this.receiverAccountId,
//     required this.payNote,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
//         id: json["_id"],
//         requestToPayUserPhoneCode: json["request_to_pay_user_phone_code"],
//         requestToPayUserPhoneNumber: json["request_to_pay_user_phone_number"],
//         senderId: json["sender_id"],
//         senderBctpayId: json["sender_bctpay_id"],
//         senderName: json["sender_name"],
//         senderRole: json["sender_role"],
//         senderCountryName: json["sender_country_name"],
//         senderCountryCode: json["sender_country_code"],
//         requestedAmount: json["requested_amount"],
//         requestedCurrency: json["requested_currency"],
//         receiverId: json["receiver_id"],
//         receiverBctpayId: json["receiver_bctpay_id"],
//         receiverName: json["receiver_name"],
//         receiverRole: json["receiver_role"],
//         receiverCountryName: json["receiver_country_name"],
//         receiverCountryCode: json["receiver_country_code"],
//         receiverAccountId: json["receiver_account_id"],
//         payNote: json["pay_note"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "request_to_pay_user_phone_code": requestToPayUserPhoneCode,
//         "request_to_pay_user_phone_number": requestToPayUserPhoneNumber,
//         "sender_id": senderId,
//         "sender_bctpay_id": senderBctpayId,
//         "sender_name": senderName,
//         "sender_role": senderRole,
//         "sender_country_name": senderCountryName,
//         "sender_country_code": senderCountryCode,
//         "requested_amount": requestedAmount,
//         "requested_currency": requestedCurrency,
//         "receiver_id": receiverId,
//         "receiver_bctpay_id": receiverBctpayId,
//         "receiver_name": receiverName,
//         "receiver_role": receiverRole,
//         "receiver_country_name": receiverCountryName,
//         "receiver_country_code": receiverCountryCode,
//         "receiver_account_id": receiverAccountId,
//         "pay_note": payNote,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }
