import 'package:bctpay/data/models/transactions/send_money_response_model.dart';
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<SendMoneyResponse> sendMoney({
  required String mobileNo,
  required String accountType,
  required String networkOrBankCode,
  required String beneficiaryName,
  required double amount,
  required String note,
  required String accountNo,
  required String externalRefNo,
  required String ccy,
}) async {
  final response = await http.post(
    Uri.parse("$baseUrlTransaction/${ApiEndpoint.momoSendMoney}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "mobileNo": mobileNo,
      "accountType": accountType,
      "networkOrBankCode": networkOrBankCode,
      "beneficiaryName": beneficiaryName,
      "amount": amount,
      "note": note,
      "accountNo": accountNo,
      "externalRefNo": externalRefNo,
      "ccy": ccy,
    }),
  );

  if (response.statusCode == 200) {
    return SendMoneyResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

