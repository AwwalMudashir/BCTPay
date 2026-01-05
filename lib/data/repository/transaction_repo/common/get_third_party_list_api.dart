import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ThirdPartyListResponse> getThirdPartyList() async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxnPublic/${ApiEndpoint.thirdPartyList}"),
    headers: await ApiClient.header(),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ThirdPartyListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
