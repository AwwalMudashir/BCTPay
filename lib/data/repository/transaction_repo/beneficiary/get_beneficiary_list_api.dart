
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<BeneficiaryFetchResponse> getBeneficiaryList({
  required int page,
  required int limit,
}) async {
  // Core expects pageNumber + pageSize
  final pageNumber = page <= 0 ? 1 : page;
  const pageSize = 100; // fixed as requested
  var uri = Uri.parse("$baseUrlCore/${ApiEndpoint.beneficiariesFetch}")
      .replace(queryParameters: {
    "pageNumber": "$pageNumber",
    "pageSize": "$pageSize",
  });
  print("[REQ] GET $uri");
  var response = await http.get(
    uri,
    headers: await ApiClient.header(useCore: true),
  );
  print("[RESP] GET $uri status=${response.statusCode} body=${response.body}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return BeneficiaryFetchResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
