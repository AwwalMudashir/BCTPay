import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<RecentBillTransactionResponse> getRecentBillTxn() async {
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.recentBillTxnList}"),
      headers: await ApiClient.header(),
      body: jsonEncode({
        "filter": {},
      }));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return RecentBillTransactionResponse.fromJson(data);
  } else {
    // debugPrint(response.body);
    throw Exception(response.body);
  }
}
