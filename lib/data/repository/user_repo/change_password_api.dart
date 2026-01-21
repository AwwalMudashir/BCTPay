import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> initiatePasswordReset({required String email}) async {
  final uri = Uri.parse("$baseUrlCorePublic/${ApiEndpoint.initiatePasswordReset}")
      .replace(queryParameters: {
    "username": email,
    "entityCode": "BCT",
  });

  print("${ApiEndpoint.initiatePasswordReset} URL: $uri");
  final headers = await ApiClient.header(useCore: true);
  print("${ApiEndpoint.initiatePasswordReset} Headers: ${jsonEncode(headers)}");

  final response = await http.get(uri, headers: headers);
  print(
      "${ApiEndpoint.initiatePasswordReset} Response [${response.statusCode}]: ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}

Future<Response> selfPasswordReset({
  required String email,
  required String otp,
  required String newPassword,
}) async {
  final body = {
    "otp": otp,
    "mobileNo": "",
    "username": email,
    "entityCode": "BCT",
    "newPwd": newPassword,
  };

  final url = "$baseUrlCorePublic/${ApiEndpoint.selfPasswordReset}";
  print("${ApiEndpoint.selfPasswordReset} URL: $url");
  final headers = await ApiClient.header(useCore: true);
  print("${ApiEndpoint.selfPasswordReset} Headers: ${jsonEncode(headers)}");
  print("${ApiEndpoint.selfPasswordReset} Request: ${jsonEncode(body)}");

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );
  print(
      "${ApiEndpoint.selfPasswordReset} Response [${response.statusCode}]: ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
