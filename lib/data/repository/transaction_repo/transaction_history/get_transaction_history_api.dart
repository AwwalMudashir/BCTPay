import 'package:bctpay/globals/index.dart' hide TransactionHistoryResponse;
import 'package:bctpay/data/models/transactions/transaction_history_response.dart';
import 'package:http/http.dart' as http;

Future<TransactionHistoryResponse> getTransactionHistory({
  int pageSize = 10,
  int pageNumber = 1,
}) async {
  final uri = Uri.parse("$baseUrlCorePublic/ecommerce/fetch-transaction-history")
      .replace(queryParameters: {
    "pageSize": pageSize.toString(),
    "pageNumber": pageNumber.toString(),
  });

  final headers = await ApiClient.header(useCore: true);
  print("transactionHistory URL: $uri");
  print("transactionHistory Headers: ${jsonEncode(headers)}");

  final response = await http.get(uri, headers: headers);
  print("transactionHistory Response [${response.statusCode}]: ${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return TransactionHistoryResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
