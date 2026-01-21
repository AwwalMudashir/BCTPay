
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> verifyRegistrationOtp({
  required String email,
  required String otp,
}) async {
  final payload = {
    "email": email,
    "otp": otp,
  };
  final uri =
      Uri.parse("$baseUrlCorePublic/${ApiEndpoint.verifyRegistrationOtp}");

  print("${ApiEndpoint.verifyRegistrationOtp} Req => $payload");

  final response = await http.post(
    uri,
    headers: await ApiClient.header(useCore: true),
    body: jsonEncode(payload),
  );

  print(
      "${ApiEndpoint.verifyRegistrationOtp} Resp [${response.statusCode}] => ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw ExceptionHandler.handleHttpResponse(response);
  }
}

