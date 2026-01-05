import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<KycDetailResponse> getKYCDetails() async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.kycDetail}"),
    headers: await ApiClient.header(),
  );

  debugPrint("$baseUrlCustomer/${ApiEndpoint.kycDetail}\n ${await ApiClient.header()}");
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return KycDetailResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
