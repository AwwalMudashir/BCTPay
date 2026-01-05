import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateTransactionResponse> getOrangeMoneyTxnStatus({
  required String? orderId,
}) async {
  var body = {
    "order_id": orderId,
  };
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.getOMTxnStatus}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );
  // debugPrint("url -> $baseUrlCustomerTxn/${ApiEndpoint.getOMTxnStatus}");
  // debugPrint("getOMTxnStatus header -> ${await ApiClient.header()}");
  // debugPrint("getOMTxnStatus body -> ${jsonEncode(body)}");
  // debugPrint("getOMTxnStatus response -> ${response.body}");
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //log(jsonEncode(data));
    return InitiateTransactionResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
