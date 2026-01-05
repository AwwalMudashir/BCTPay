import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateTransactionResponse> initiateTicketTxn({
  required InitiateTxnBody initiateTxnBody,
}) async {
  var body = initiateTxnBody.toJson();
  //log("${ApiEndpoint.ticketInitiatePayment} ${jsonEncode(body)}");
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.ticketInitiatePayment}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //debugPrint(data.toString());
    return InitiateTransactionResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
