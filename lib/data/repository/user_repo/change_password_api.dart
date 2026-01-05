import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ChangePasswordResponse> changePassword({
  required String oldPassword,
  required String newPassword,
}) async {
  var body = {
    "password": oldPassword,
    "newpassword": newPassword,
  };
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.changePwd}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // print(data);
    return ChangePasswordResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
