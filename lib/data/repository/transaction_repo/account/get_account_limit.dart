import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<AccountLimitResponse> getAccountLimit() async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.accAddLimit}"),
    headers: await ApiClient.header(),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return AccountLimitResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
