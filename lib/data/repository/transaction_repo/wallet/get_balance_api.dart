
import 'package:bctpay/data/models/transactions/wallet_balance_response_model.dart';
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<WalletBalanceResponse> getWalletBalance() async {
  final uri = Uri.parse("$baseUrlCore/${ApiEndpoint.walletBalance}");
  print("[REQ] GET $uri");
  final response = await http.get(
    uri,
    headers: await ApiClient.header(useCore: true),
  );
  print("[RESP] GET $uri status=${response.statusCode} body=${response.body}");

  if (response.statusCode == 200) {
    return WalletBalanceResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

