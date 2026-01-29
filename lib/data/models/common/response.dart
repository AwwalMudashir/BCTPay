import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  /// Primary numeric code where available.
  final int? code;

  /// Raw code as returned by backend (string or number) to preserve leading zeros like "00".
  final String? codeString;

  final dynamic data;
  final String? message;
  final bool? success;
  final dynamic error;

  Response({
    required this.code,
    required this.codeString,
    required this.data,
    required this.message,
    required this.success,
    required this.error,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    // Support multiple backend field names across services
    final rawCode = json["code"] ?? json["responseCode"] ?? json["response_code"] ?? json["response"];
    final codeStr = rawCode?.toString();
    int? parsedCode;
    if (rawCode is int) {
      parsedCode = rawCode;
    } else if (rawCode is String) {
      parsedCode = int.tryParse(rawCode);
    }

    // message may be under different keys
    final message = json["message"] ?? json["responseMessage"] ?? json["response_message"] ?? json["desc"];

    // data/success/error fallbacks
    final data = json["data"] ?? json["result"];
    final success = json["success"] as bool? ?? (codeStr == "00" || codeStr == "000");
    final error = json["error"] ?? json["errors"];

    return Response(
      code: parsedCode,
      codeString: codeStr,
      data: data,
      message: message,
      success: success,
      error: error,
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "codeString": codeString,
        "data": data,
        "message": message,
        "success": success,
        "error": error,
      };

  /// Helper to check common success codes (includes Core "00"/"000").
  bool get isOk {
    final cStr = codeString ?? code?.toString();
    return cStr == "00" || cStr == "000" || cStr == "0" || code == 200 || code == 201;
  }
}
