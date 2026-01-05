class RequestToPayResponse {
  final int code;
  final PaymentRequest? data;
  final String message;
  final bool? success;

  RequestToPayResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory RequestToPayResponse.fromJson(Map<String, dynamic> json) =>
      RequestToPayResponse(
        code: json["code"],
        data:
            json["data"] == null ? null : PaymentRequest.fromJson(json["data"]),
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

class PaymentRequest {
  final String id;
  final String requestToPayUserPhoneCode;
  final String requestToPayUserPhoneNumber;
  final String senderId;
  final String senderBctpayId;
  final String senderName;
  final String senderProfilePic;
  final String senderRole;
  final String senderCountryName;
  final String senderCountryCode;
  final String requestedAmount;
  final String requestedCurrency;
  final String receiverId;
  final String receiverBctpayId;
  final String receiverName;
  final String receiverProfilePic;
  final String receiverRole;
  final String receiverCountryName;
  final String receiverCountryCode;
  final String receiverAccountId;
  final String receiverAccountLogo;
  final String payNote;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String? requestSenderPhoneCode;
  final String? requestSenderPhoneNumber;

  PaymentRequest({
    required this.id,
    required this.requestToPayUserPhoneCode,
    required this.requestToPayUserPhoneNumber,
    required this.senderId,
    required this.senderBctpayId,
    required this.senderName,
    required this.senderProfilePic,
    required this.senderRole,
    required this.senderCountryName,
    required this.senderCountryCode,
    required this.requestedAmount,
    required this.requestedCurrency,
    required this.receiverId,
    required this.receiverBctpayId,
    required this.receiverName,
    required this.receiverProfilePic,
    required this.receiverRole,
    required this.receiverCountryName,
    required this.receiverCountryCode,
    required this.receiverAccountId,
    required this.receiverAccountLogo,
    required this.payNote,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.requestSenderPhoneCode,
    required this.requestSenderPhoneNumber,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
        id: json["_id"],
        requestToPayUserPhoneCode: json["request_to_pay_user_phone_code"],
        requestToPayUserPhoneNumber: json["request_to_pay_user_phone_number"],
        senderId: json["sender_id"],
        senderBctpayId: json["sender_bctpay_id"],
        senderName: json["sender_name"],
        senderProfilePic: json["sender_profile_pic"],
        senderRole: json["sender_role"],
        senderCountryName: json["sender_country_name"],
        senderCountryCode: json["sender_country_code"],
        requestedAmount: json["requested_amount"],
        requestedCurrency: json["requested_currency"],
        receiverId: json["receiver_id"],
        receiverBctpayId: json["receiver_bctpay_id"],
        receiverName: json["receiver_name"],
        receiverProfilePic: json["receiver_profile_pic"],
        receiverRole: json["receiver_role"],
        receiverCountryName: json["receiver_country_name"],
        receiverCountryCode: json["receiver_country_code"],
        receiverAccountId: json["receiver_account_id"],
        receiverAccountLogo: json["receiver_account_logo"],
        payNote: json["pay_note"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        requestSenderPhoneCode: json["requestSender_phone_code"],
        requestSenderPhoneNumber: json["requestSender_phonenumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "request_to_pay_user_phone_code": requestToPayUserPhoneCode,
        "request_to_pay_user_phone_number": requestToPayUserPhoneNumber,
        "sender_id": senderId,
        "sender_bctpay_id": senderBctpayId,
        "sender_name": senderName,
        "sender_profile_pic": senderProfilePic,
        "sender_role": senderRole,
        "sender_country_name": senderCountryName,
        "sender_country_code": senderCountryCode,
        "requested_amount": requestedAmount,
        "requested_currency": requestedCurrency,
        "receiver_id": receiverId,
        "receiver_bctpay_id": receiverBctpayId,
        "receiver_name": receiverName,
        "receiver_profile_pic": receiverProfilePic,
        "receiver_role": receiverRole,
        "receiver_country_name": receiverCountryName,
        "receiver_country_code": receiverCountryCode,
        "receiver_account_id": receiverAccountId,
        "receiver_account_logo": receiverAccountLogo,
        "pay_note": payNote,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "request_sender_phone_code": requestSenderPhoneCode,
        "request_sender_phonenumber": requestSenderPhoneNumber,
      };
}
