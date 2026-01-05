import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> transactionDetail({
  required String transactionId,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.txnDetail}"),
    // Uri.parse("$baseUrlCustomer/transactionhistory"),
    headers: await ApiClient.header(),
    body: jsonEncode({"transaction_id": transactionId}),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
