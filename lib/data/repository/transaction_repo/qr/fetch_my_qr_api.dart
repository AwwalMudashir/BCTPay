import 'package:bctpay/globals/index.dart';
import 'package:bctpay/utils/http_with_logging.dart' as http;

Future<MyQrResponse> fetchMyQr() async {
  final uri = Uri.parse("$baseUrlCore/${ApiEndpoint.fetchMyQr}");
  final headers = await ApiClient.header(useCore: true);
  print("[REQ] GET $uri headers=$headers");
  final response = await http.get(uri, headers: headers);
  print("[RESP] GET $uri status=${response.statusCode} body=${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return MyQrResponse.fromJson(data);
  }
  throw ExceptionHandler.handleHttpResponse(response);
}
