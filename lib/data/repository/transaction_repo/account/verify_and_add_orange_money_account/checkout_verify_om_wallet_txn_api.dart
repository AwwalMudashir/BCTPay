import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> checkoutVerifyOMTxn({
  required String orderId,
}) async {
  var body = {
    "order_id": orderId,
  };


  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.checkoutVerifyOMWalletTxn}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
