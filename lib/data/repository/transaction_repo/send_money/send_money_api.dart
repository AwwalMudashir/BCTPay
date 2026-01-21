
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
  String channel = "MOBILE",
  String? pin,
}) async {
  final uri = Uri.parse("$baseUrlCore/${ApiEndpoint.momoSendMoney}");
  final payload = {
    "mobileNo": mobileNo,
    "accountType": accountType,
    "networkOrBankCode": networkOrBankCode,
    "beneficiaryName": beneficiaryName,
    "amount": amount,
    "note": note,
    "accountNo": accountNo,
    "externalRefNo": externalRefNo,
    "ccy": ccy,
    "channel": channel,
  };

  print("[REQ] POST $uri body=$payload");
  final headers = await ApiClient.header(useCore: true);
  if (pin != null && pin.isNotEmpty) {
    headers["x-enc-pwd"] = hashPwdAndEncrypt(pin);
  }
  final response = await http.post(
    uri,
    headers: headers,
    body: jsonEncode(payload),
  );
  print(
      "[RESP] POST $uri status=${response.statusCode} body=${response.body}");

  if (response.statusCode == 200) {
    return SendMoneyResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

