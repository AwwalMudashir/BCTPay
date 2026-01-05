import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<SetPrimaryAccountResponse> setPrimaryAccount({
  required BankAccount account,
}) async {
  var body = {};
  body["accountId"] = account.id;
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.setAccPrimary}"),
      headers: await ApiClient.header(),
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return SetPrimaryAccountResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
