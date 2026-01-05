import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<CheckBankBalanceResponse> checkBankBalance({
  required String accountId,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.checkBal}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "accountId": accountId,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return CheckBankBalanceResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
