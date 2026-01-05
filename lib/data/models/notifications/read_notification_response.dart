import 'package:bctpay/globals/index.dart';

class ReadNotificationResponse {
  final int code;
  final List<NotificationData>? data;
  final String message;
  final bool? success;

  ReadNotificationResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ReadNotificationResponse.fromMap(Map<String, dynamic> json) =>
      ReadNotificationResponse(
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
