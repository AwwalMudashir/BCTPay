import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<RequestToPayResponse> requestTopay({
  required String amount,
  required String receiverAccountId,
  required String? txnNote,
  required String? requestReceiverPhoneCode,
  required String? requestReceiverPhoneNumber,
}) async {
  var body = jsonEncode({
    "receiver_account_id": receiverAccountId,
    "receiver_requested_amount": amount,
    "in_currency": selectedCountry?.currencyCode,
    "pay_note": txnNote,
    "request_to_pay_user_phone_code": requestReceiverPhoneCode,
    "request_to_pay_user_phone_number": requestReceiverPhoneNumber
  });
  final url = "$baseUrlCustomerTxn/${ApiEndpoint.requestToPay}";
  final headers = await ApiClient.header();
  print("[API] POST $url");
  print("[API] Body: $body");
  print("[API] Headers: {Content-Type: ${headers['Content-Type']}, Accept-Language: ${headers['Accept-Language']}, x-token: ***masked***, Authorization: ***masked***}");
  var response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: body,
  );
  print("[API] Response ($url): ${response.statusCode} ${response.body}");
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return RequestToPayResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
