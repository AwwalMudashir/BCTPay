import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateTransactionResponse> checkoutTicketTxn({
  required CheckoutTxnBody checkoutTxnBody,
}) async {
  var body = checkoutTxnBody.toJson();
  log("${ApiEndpoint.ticketCheckoutPayment} ${jsonEncode(body)}");
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.ticketCheckoutPayment}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  // debugPrint("url --> $baseUrlCustomerTxn/${ApiEndpoint.ticketCheckoutPayment}");
  // debugPrint("header --> ${await ApiClient.header()}");
  // debugPrint("request body --> ${ jsonEncode(body)}");
  // debugPrint("${ApiEndpoint.ticketCheckoutPayment} response -> ${response.body}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //debugPrint(data.toString());
    return InitiateTransactionResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
