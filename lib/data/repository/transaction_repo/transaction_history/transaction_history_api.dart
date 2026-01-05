import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<TransactionHistoryResponse> transactionHistory({
  required int page,
  required int limit,
  required TxnFilterModel? filter,
}) async {
  var body = jsonEncode({
    "filter": filter?.toMap() ??
        {
          "name": "",
          "payment_type": [],
          "payment_status": [],
          "payment": [],
          "date": {"start": "", "end": ""}
        },
    "limit": "$limit",
    "page": "$page",
  });
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.txnList}"),
    // Uri.parse("$baseUrlCustomer/transactionhistory"),
    headers: await ApiClient.header(),
    body: body,
  );
  log(body);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return TransactionHistoryResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
