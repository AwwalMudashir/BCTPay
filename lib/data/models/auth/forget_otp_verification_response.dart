import 'dart:convert';

ForgetOtpVerificationResponse forgetOtpVerificationResponseFromJson(
        String str) =>
    ForgetOtpVerificationResponse.fromJson(json.decode(str));

String forgetOtpVerificationResponseToJson(
        ForgetOtpVerificationResponse data) =>
    json.encode(data.toJson());

class ForgetOtpVerificationResponse {
  final int code;
  final ForgetOtpVerificationData? data;
  final String message;
  final bool? success;

  ForgetOtpVerificationResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ForgetOtpVerificationResponse.fromJson(Map<String, dynamic> json) =>
      ForgetOtpVerificationResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : ForgetOtpVerificationData.fromJson(json["data"]),
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

class ForgetOtpVerificationData {
  final String otp;

  ForgetOtpVerificationData({
    required this.otp,
  });

  factory ForgetOtpVerificationData.fromJson(Map<String, dynamic> json) =>
      ForgetOtpVerificationData(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
