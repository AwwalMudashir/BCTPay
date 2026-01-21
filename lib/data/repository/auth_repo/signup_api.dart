import 'package:bctpay/globals/index.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<Response> signup({
  required String email,
  required String phoneCode,
  required String phoneNumber,
  required String password,
  required String firstName,
  String? lastName,
  String? address,
  String? pinCode,
  String? city,
  String? country,
  String? gender,
  String? onboardingId,
  String? dateOfBirth,
  String? nationality,
}) async {
  // Build payload using the core API expected keys (camelCase)
  // Encrypt password using help2pay/Fortitude scheme (AES/CBC/PKCS7 with fixed key/iv)
  final encodedPassword = hashPwdAndEncrypt(password);

  var body = {
    "firstname": firstName,
    "lastname": lastName ?? "",
    "mobileNo": phoneNumber,
    "email": email,
    "countryCode": country ?? "",
    "gender": gender ?? "",
    "onboardingId": onboardingId ?? "",
    "dateOfBirth": dateOfBirth ?? "",
    "password": encodedPassword,
    "nationality": nationality ?? "",
    "phoneCode": phoneCode,
    "channel": "MOBILE",
    "device_name": await DeviceInfo.getDeviceName(),
    "device_id": await DeviceInfo.getDeviceId(),
    "device_token": Platform.isIOS
        ? (kReleaseMode ? await getFcmToken() : "12345")
        : await getFcmToken(),
    "last_login_ip": "106.76.92.240",
    "model": await DeviceInfo.getDeviceModel(),
    "os": Platform.operatingSystem,
    "os_version": await DeviceInfo.getDeviceOSVersion()
  };

  // Remove empty string fields so the payload stays compact
  body.removeWhere((key, value) => (value is String) && value.isEmpty);

  // prepare headers and print request for debugging
  final headers = await ApiClient.header(useCore: true);
  print('Signup request URL: $baseUrlCorePublic/${ApiEndpoint.signUp}');
  print('Signup request headers: ${jsonEncode(headers)}');
  print('Signup request body: ${jsonEncode(body)}');

  var response = await http.post(
    Uri.parse("$baseUrlCorePublic/${ApiEndpoint.signUp}"),
    headers: headers,
    body: jsonEncode(body),
  );
  // also print response for debugging
  print('Signup response status: ${response.statusCode}');
  print('Signup response body: ${response.body}');
  log("${ApiEndpoint.signUp} ${jsonEncode(body)}");
  log("Header ${jsonEncode(headers)}");

  if (response.statusCode == 200) {
    final raw = json.decode(response.body);
    log(jsonEncode(raw));

    // Normalize response to the app's `Response` model shape.
    int parsedCode = 0;
    try {
      if (raw is Map && raw['code'] != null) {
        final codeVal = raw['code'];
        if (codeVal is int) {
          parsedCode = codeVal;
        } else if (codeVal is String) {
          // common API returns "000" for success — treat as 200
          if (codeVal == '000') {
            parsedCode = 200;
          } else {
            parsedCode = int.tryParse(codeVal) ?? 0;
          }
        }
      }
    } catch (_) {
      parsedCode = 0;
    }

    final message = (raw is Map)
        ? (raw['message'] ?? raw['desc'] ?? raw['errorMessage'] ?? '')
        : '';
    final success = (raw is Map && raw['desc'] != null && raw['desc'].toString().toLowerCase() == 'success') || parsedCode == 200 || (raw is Map && raw['success'] == true);

    final normalized = {
      'code': parsedCode,
      'data': (raw is Map) ? raw['data'] : null,
      'message': message,
      'success': success,
      'error': (raw is Map) ? (raw['error'] ?? raw['errorMessage']) : null,
    };

    return Response.fromJson(normalized);
  } else {
    throw Exception(response.body);
  }
}
