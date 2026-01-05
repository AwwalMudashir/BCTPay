import 'package:bctpay/globals/index.dart';

class VerifyQrResponse {
  final int code;
  final VerifyQRData? data;
  final String message;
  final bool? success;
  final String? type;

  VerifyQrResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
    required this.type,
  });

  factory VerifyQrResponse.fromJson(Map<String, dynamic> json, String? type) =>
      VerifyQrResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : VerifyQRData.fromJson(json["data"], type),
        message: json["message"],
        success: json["success"],
        type: type,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "message": message,
        "success": success,
        "type": type,
      };
}

class VerifyQRData {
  final BankAccount? receiverAccount;
  final String? profilePic;
  final String? receiverType;
  final Invoice? invoiceDetails;
  final Subscriber? subscriber;
  final PaymentLinkData? paymentLinkData;

  VerifyQRData({
    required this.receiverAccount,
    required this.profilePic,
    required this.receiverType,
    required this.invoiceDetails,
    required this.subscriber,
    required this.paymentLinkData,
  });

  factory VerifyQRData.fromJson(Map<String, dynamic> json, String? type) =>
      VerifyQRData(
          receiverAccount: json["receiverAccount"] == null
              ? null
              : BankAccount.fromJson(json["receiverAccount"]),
          profilePic: json["profile_pic"],
          receiverType: json["receiver_type"],
          invoiceDetails: json["invoice_details"] == null
              ? null
              : Invoice.fromJson(json["invoice_details"]),
          subscriber: type == '1236' ? Subscriber.fromJson(json) : null,
          paymentLinkData:
              type == '1238' ? PaymentLinkData.fromJson(json) : null);

  Map<String, dynamic> toJson() => {
        "receiverAccount": receiverAccount?.toJson(),
        "profile_pic": profilePic,
        "receiver_type": receiverType,
        "invoice_details": invoiceDetails?.toJson(),
        "subscriber": subscriber?.toJson(),
        "payment_link": paymentLinkData?.toJson(),
      };
}
