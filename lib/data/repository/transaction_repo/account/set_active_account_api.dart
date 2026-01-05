import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> setActiveAccount({
  required BankAccount account,
}) async {
  var body = {};
  body["accountId"] = account.id;
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.setAccActive}"),
      headers: await ApiClient.header(),
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
