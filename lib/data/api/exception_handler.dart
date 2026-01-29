import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

class ExceptionHandler {
  /// Handle errors from raw http.Response
  static Exception handleHttpResponse(http.Response response) {
    final decoded = _decodeJson(response.body);
    final message =
        decoded['error'] ?? decoded['message'] ?? decoded.toString();

    // if (response.statusCode == 401) {
    // showToast(message);
    // sessionExpired(message, context);
    // } else
    if (response.statusCode == HTTPResponseStatusCodes.tooManyRequestsCode) {
      throw TooManyRequestException(error: message);
    } else {
      // showToast(message);
      throw Exception(message);
    }
  }

  /// Handle errors from custom Response object (if used in your app)
  static void handleCustomResponse(Response response, context) {
    final message = response.message ?? response.error ?? "Unknown error";

    if (response.code == 401) {
      showToast(message);
      sessionExpired(message, context);
    } else {
      showToast(message);
    }
  }

  static Map<String, dynamic> _decodeJson(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return {"error": body}; // fallback to raw string
    }
  }
}

class TooManyRequestException implements Exception {
  final String error;
  TooManyRequestException({required this.error});

  @override
  String toString() => 'TooManyRequestException: $error';
}

class SessionExpiredException implements Exception {
  final String message;
  SessionExpiredException(this.message);

  @override
  String toString() => 'SessionExpiredException: $message';
}
