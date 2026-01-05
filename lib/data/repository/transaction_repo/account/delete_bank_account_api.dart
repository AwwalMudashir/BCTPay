import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<DeleteBankAccountResponse> deleteBankAccount({
  required BankAccount account,
}) async {
  var body = {};
  account.accountRole == "BANK"
      ? body["accountId"] = account.id
      : body["accountId"] = account.id;
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.deleteAcc}"),
      headers: await ApiClient.header(),
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return DeleteBankAccountResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
