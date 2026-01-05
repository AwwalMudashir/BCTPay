import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<AddBankAccountResponse> updateBankAccount({
  required String accountRole,
  required String accountId,
  required String? bankcode,
  required String? bankname,
  required String? accountnumber,
  required String? beneficiaryname,
  required String? clientId,
  required String? walletPhonenumber,
  required String? phoneCode,
}) async {
  var body = {};
  if (accountRole == "BANK") {
    body = {
      "institution_code": bankcode,
      "institution_name": bankname,
      "account_no": accountnumber,
      "beneficiary_name": beneficiaryname,
      "clientId": clientId,
      "account_type": accountRole,
    };
  } else {
    body = {
      "account_type": accountRole,
      "institution_name": bankname,
      "beneficiary_name": beneficiaryname,
      "account_no": walletPhonenumber,
      "phone_code": phoneCode,
    };
  }
  body["accountId"] = accountId;
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.updateAcc}"),
      headers: await ApiClient.header(),
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return AddBankAccountResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
