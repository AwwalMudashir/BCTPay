import 'package:bctpay/globals/index.dart';
import 'package:bctpay/utils/http_with_logging.dart' as http;

Future<WalletNameByQrResponse> getWalletNameByQr(String qrCode) async {
  final uri = Uri.parse("$baseUrlCore/${ApiEndpoint.getWalletNameByQr}")
      .replace(queryParameters: {"qrCode": qrCode});
  final headers = await ApiClient.header(useCore: true);
  print("[REQ] GET $uri headers=$headers");
  final response = await http.get(uri, headers: headers);
  print("[RESP] GET $uri status=${response.statusCode} body=${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return WalletNameByQrResponse.fromJson(data);
  }
  throw ExceptionHandler.handleHttpResponse(response);
}
