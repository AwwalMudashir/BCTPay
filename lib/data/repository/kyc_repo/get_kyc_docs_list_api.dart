import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<KycDocsListResponse> getKYCDocsList() async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.kycDocList}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "filter": {},
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return KycDocsListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
