import 'package:bctpay/data/models/transactions/wallet_balance_response_model.dart';
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<WalletBalanceResponse> getWalletBalance() async {
  final response = await http.get(
    Uri.parse("$baseUrl/${ApiEndpoint.walletBalance}"),
    headers: await ApiClient.header(),
  );

  if (response.statusCode == 200) {
    return WalletBalanceResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

