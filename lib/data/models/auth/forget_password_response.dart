import 'dart:convert';

ForgetPasswordResponse forgetPasswordResponseFromJson(String str) =>
    ForgetPasswordResponse.fromJson(json.decode(str));

String forgetPasswordResponseToJson(ForgetPasswordResponse data) =>
    json.encode(data.toJson());

class ForgetPasswordResponse {
  final int code;
  final ForgetPasswordData? data;
  final String message;
  final bool? success;

  ForgetPasswordResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : ForgetPasswordData.fromJson(json["data"]),
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

class ForgetPasswordData {
  final String? otp;

  ForgetPasswordData({
    required this.otp,
  });

  factory ForgetPasswordData.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordData(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
