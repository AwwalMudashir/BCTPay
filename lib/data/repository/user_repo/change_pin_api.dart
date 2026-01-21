import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

/// Change transaction PIN (requires current PIN)
Future<Response> changeTransactionPin({
  required String username,
  required String currentPin,
  required String newPin,
}) async {
  final payload = {
    "username": username,
    "oldPin": hashPwdAndEncrypt(currentPin),
    "newPin": hashPwdAndEncrypt(newPin),
    "entityCode": "BCT",
    "deviceId": await DeviceInfo.getDeviceId(),
    "channel": "MOBILE",
  };

  final url = "$baseUrlCorePublic/${ApiEndpoint.changeTransactPin}";
  final headers = await ApiClient.header(useCore: true);
  print("${ApiEndpoint.changeTransactPin} URL: $url");
  print("${ApiEndpoint.changeTransactPin} Headers: ${jsonEncode(headers)}");
  print("${ApiEndpoint.changeTransactPin} Request: ${jsonEncode(payload)}");

  final response =
      await http.post(Uri.parse(url), headers: headers, body: jsonEncode(payload));
  print(
      "${ApiEndpoint.changeTransactPin} Response [${response.statusCode}]: ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}

/// Send OTP for forgot PIN
Future<Response> initiateForgotPin({required String username}) async {
  final uri = Uri.parse("$baseUrlCorePublic/${ApiEndpoint.initiateForgotPin}")
      .replace(queryParameters: {
    "username": username,
    "entityCode": "BCT",
  });

  final headers = await ApiClient.header(useCore: true);
  print("${ApiEndpoint.initiateForgotPin} URL: $uri");
  print("${ApiEndpoint.initiateForgotPin} Headers: ${jsonEncode(headers)}");

  final response = await http.get(uri, headers: headers);
  print(
      "${ApiEndpoint.initiateForgotPin} Response [${response.statusCode}]: ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}

/// Validate OTP for PIN reset
Future<Response> validatePinResetOtp({
  required String username,
  required String otp,
}) async {
  final uri = Uri.parse("$baseUrlCorePublic/${ApiEndpoint.validatePinResetOtp}")
      .replace(queryParameters: {
    "username": username,
    "entityCode": "BCT",
  });

  final headers = await ApiClient.header(useCore: true);
  headers["x-otp"] = otp;

  print("${ApiEndpoint.validatePinResetOtp} URL: $uri");
  print("${ApiEndpoint.validatePinResetOtp} Headers: ${jsonEncode(headers)}");

  final response = await http.post(uri, headers: headers);
  print(
      "${ApiEndpoint.validatePinResetOtp} Response [${response.statusCode}]: ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}

/// Set a new PIN (used after OTP verification)
Future<Response> setPin({
  required String username,
  required String newPin,
}) async {
  final encryptedPin = hashPwdAndEncrypt(newPin);
  final payload = {
    "username": username,
    "newPin": encryptedPin,
    "entityCode": "BCT",
    "deviceId": await DeviceInfo.getDeviceId(),
    "channel": "MOBILE",
  };

  final url = "$baseUrlCorePublic/${ApiEndpoint.setPin}";
  final headers = await ApiClient.header(useCore: true);
  headers["x-enc-pwd"] = encryptedPin;

  print("${ApiEndpoint.setPin} URL: $url");
  print("${ApiEndpoint.setPin} Headers: ${jsonEncode(headers)}");
  print("${ApiEndpoint.setPin} Request: ${jsonEncode(payload)}");

  final response =
      await http.post(Uri.parse(url), headers: headers, body: jsonEncode(payload));
  print("${ApiEndpoint.setPin} Response [${response.statusCode}]: ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
