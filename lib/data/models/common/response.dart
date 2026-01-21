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
    final rawCode = json["code"];
    final codeStr = rawCode?.toString();
    int? parsedCode;
    if (rawCode is int) {
      parsedCode = rawCode;
    } else if (rawCode is String) {
      parsedCode = int.tryParse(rawCode);
    }

    return Response(
      code: parsedCode,
      codeString: codeStr,
        data: json["data"],
        message: json["message"],
        success: json["success"],
        error: json["error"],
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
