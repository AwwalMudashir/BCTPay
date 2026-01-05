import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  final int? code;
  final dynamic data;
  final String? message;
  final bool? success;
  final dynamic error;

  Response({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
    required this.error,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        code: json["code"],
        data: json["data"],
        message: json["message"],
        success: json["success"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data,
        "message": message,
        "success": success,
        "error": error,
      };
}
