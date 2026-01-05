import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateVerifyOrangeTxnResponse> initiateVerifyOMTxn({
  required String phoneNumber,
  required String cancelUrl,
  required String phoneCode,
  required String returnUrl,
}) async {
  var body = {
    "phone_code": phoneCode,
    "phone_number": phoneNumber,
    "return_url": returnUrl,
    "cancel_url": cancelUrl,
  };

  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.initiateVerifyOMWalletTxn}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    log(jsonEncode(data));
    return InitiateVerifyOrangeTxnResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
