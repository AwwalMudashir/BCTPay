import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateTransactionResponse> checkoutOMTicketpayment({
  required String orderId,
}) async {
  var body = {
    "order_id": orderId,
  };

  //log("${ApiEndpoint.checkoutOmTicketPayment}${jsonEncode(body)}");

  // debugPrint("$baseUrlCustomerTxn/${ApiEndpoint.checkoutOmTicketPayment}");
  // debugPrint("${ApiEndpoint.checkoutOmTicketPayment} body -> ${jsonEncode(body)}");
  // debugPrint("${ApiEndpoint.checkoutOmTicketPayment} header -> ${await ApiClient.header()}");

  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.checkoutOmTicketPayment}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  //debugPrint("${ApiEndpoint.checkoutOmTicketPayment} resp -> ${json.decode(response.body)}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //log(jsonEncode(data));
    return InitiateTransactionResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
