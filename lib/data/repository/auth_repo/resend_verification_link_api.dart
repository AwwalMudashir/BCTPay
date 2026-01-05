import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> resendVerificationLink({
  required String phoneCode,
  required String phone,
}) async {
  var body = {
    "phone_code": phoneCode,
    "phonenumber": phone,
  };
  var response = await http.post(
    Uri.parse("$baseUrlPublic/${ApiEndpoint.resendVerificationLink}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
