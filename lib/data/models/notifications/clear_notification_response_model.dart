import 'package:bctpay/globals/index.dart';

class ClearNotificationResponse {
  final int code;
  final List<NotificationData>? data;
  final String message;
  final bool? success;

  ClearNotificationResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ClearNotificationResponse.fromMap(Map<String, dynamic> json) =>
      ClearNotificationResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<NotificationData>.from(
                json["data"].map((x) => NotificationData.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}
