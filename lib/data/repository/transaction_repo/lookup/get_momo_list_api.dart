
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<MomoLookupResponse> getMomoList({required String countryCode}) async {
  final uri = Uri.parse("$baseUrlCore/${ApiEndpoint.momoList}")
      .replace(queryParameters: {"countryCode": countryCode});
  print("[REQ] GET $uri");
  final response = await http.get(
    uri,
    headers: await ApiClient.header(useCore: true),
  );
  print("[RESP] GET $uri status=${response.statusCode} body=${response.body}");

  if (response.statusCode == 200) {
    return MomoLookupResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
