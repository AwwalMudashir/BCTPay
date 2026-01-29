
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
  } else if (response.statusCode == 400) {
    final decoded = json.decode(response.body);
    final respCode = decoded['responseCode']?.toString() ?? '';
    final respMsg = decoded['responseMessage']?.toString() ?? '';
    if (respCode == 'E18' || respMsg == 'E18') {
      throw SessionExpiredException(respMsg.isNotEmpty ? respMsg : respCode);
    }
    throw Exception(response.body);
  } else {
    throw Exception(response.body);
  }
}

