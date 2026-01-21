import 'package:bctpay/globals/index.dart';
import 'package:bctpay/utils/http_with_logging.dart' as http;

Future<CountryListResponse> getCountryList() async {
  final uri = Uri.parse("$baseUrlCore/${ApiEndpoint.countryList}")
      .replace(queryParameters: {
    "countryCode": "",
  });

  print("[REQ] GET $uri");
  final response = await http.get(
    uri,
    headers: await ApiClient.header(useCore: true),
  );
  print("[RESP] GET $uri status=${response.statusCode} body=${response.body}");

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return CountryListResponse.fromJson(data);
  } else {
    throw ExceptionHandler.handleHttpResponse(response);
  }
}
