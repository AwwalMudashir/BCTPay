import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<RecentTransactionsResponse> recentTransactions() async {
  // String kongToken = await SharedPreferance.getKongServerToken();
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.recentTxn}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "filter": {},
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return RecentTransactionsResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
