
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<AddBeneficiaryResponse> addBeneficiary({
  required String bankcode,
  required String bankname,
  required String accountnumber,
  required String beneficiaryname,
  required String accountType,
}) async {
  final body = {
    "merchantCode": merchantCode,
    "beneficiaryAccountNo": accountnumber,
    "beneficiaryName": beneficiaryname,
    "beneficiaryBankName": bankname,
    "beneficiaryBankCode": bankcode,
    "accountType": accountType,
  };
  final uri = Uri.parse("$baseUrlCore/${ApiEndpoint.beneficiarySave}");
  print("[REQ] POST $uri body=$body");
  var response = await http.post(
    uri,
    headers: await ApiClient.header(useCore: true),
    body: jsonEncode(body),
  );
  print("[RESP] POST $uri status=${response.statusCode} body=${response.body}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return AddBeneficiaryResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
