import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateTransactionResponse> checkoutEFTSubscriptionTxn({
  required String orderId,
}) async {
  var body = {
    "order_id": orderId,
  };

  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.checkoutEFTSubscriptionTxn}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  //log("${ApiEndpoint.checkoutEFTSubscriptionTxn} ${jsonEncode(body)}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //debugPrint(data.toString());
    return InitiateTransactionResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
