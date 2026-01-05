import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ForgetOtpVerificationResponse> forgetOTPVerify(
    {required String emailOtp}) async {
  var response = await http.post(
    Uri.parse("$baseUrlPublic/${ApiEndpoint.forgotOtpVerify}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "email_otp": emailOtp,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ForgetOtpVerificationResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
