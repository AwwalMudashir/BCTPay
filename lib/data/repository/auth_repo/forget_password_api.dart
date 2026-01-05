import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ForgetPasswordResponse> forgetPassword({required String email}) async {
  var response = await http.post(
    Uri.parse("$baseUrlPublic/${ApiEndpoint.forgotPassword}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "email": email,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ForgetPasswordResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
