import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<AddBeneficiaryResponse> addBeneficiary({
  required String bankcode,
  required String bankname,
  required String accountnumber,
  required String beneficiaryname,
  required String clientId,
  required String accountRole,
  required String walletPhonenumber,
  required String phoneCode,
}) async {
  final body = {
    "merchantCode": merchantCode,
    "beneficiaryAccountNo":
        accountRole == "BANK" ? accountnumber : walletPhonenumber,
    "beneficiaryName": beneficiaryname,
    "beneficiaryBankName": bankname,
    "beneficiaryBankCode": bankcode,
    "accountType": accountRole,
  };
  var response = await http.post(
    Uri.parse("$baseUrl/${ApiEndpoint.beneficiarySave}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return AddBeneficiaryResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
