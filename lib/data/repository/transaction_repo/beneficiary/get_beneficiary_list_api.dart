import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<BeneficiaryListResponse> getBeneficiaryList({
  required int page,
  required int limit,
}) async {
  var uri = Uri.parse("$baseUrl/${ApiEndpoint.beneficiariesFetch}")
      .replace(queryParameters: {
    "page": "$page",
    "limit": "$limit",
  });
  var response = await http.get(
    uri,
    headers: await ApiClient.header(),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return BeneficiaryListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
