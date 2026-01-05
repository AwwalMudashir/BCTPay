import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ForgetResetPasswordResponse> forgetResetPassword({
  required String emailOtp,
  required String newpassword,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlPublic/${ApiEndpoint.forgotResetPassword}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "newpassword": newpassword,
      "email_otp": emailOtp,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ForgetResetPasswordResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
