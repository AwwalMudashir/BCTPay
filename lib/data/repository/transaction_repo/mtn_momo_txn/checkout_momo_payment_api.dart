import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateTransactionResponse> checkoutMomoPayment({
  required String orderId,
  required String urlEndpoint,
}) async {
  var body = {
    "order_id": orderId,
  };

  // print(jsonEncode(body));
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/$urlEndpoint"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  // debugPrint("url --> $baseUrlCustomerTxn/$urlEndpoint");
  // debugPrint("header --> ${await ApiClient.header()}");
  // debugPrint("request body --> ${ jsonEncode(body)}");
  // debugPrint("$urlEndpoint response -> ${response.body}");


  if (response.statusCode == 200) {
    var data = json.decode(response.body);
   // debugPrint(data.toString());
    return InitiateTransactionResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
