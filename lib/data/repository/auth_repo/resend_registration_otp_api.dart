
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> resendRegistrationOtp({
  required String email,
}) async {
  final uri = Uri.parse("$baseUrlCorePublic/${ApiEndpoint.resendRegistrationOtp}")
      .replace(queryParameters: {
    "username": email,
    "entityCode": "BCT",
  });

  print("${ApiEndpoint.resendRegistrationOtp} Req => $uri");

  final response = await http.get(
    uri,
    headers: await ApiClient.header(useCore: true),
  );

  print(
      "${ApiEndpoint.resendRegistrationOtp} Resp [${response.statusCode}] => ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw ExceptionHandler.handleHttpResponse(response);
  }
}

