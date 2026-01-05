import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<void> verifyRegistrationOtp({
  required String email,
  required String otp,
}) async {
  final response = await http.post(
    Uri.parse("$baseUrlPublic/${ApiEndpoint.verifyRegistrationOtp}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "email": email,
      "otp": otp,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception(response.body);
  }
}

