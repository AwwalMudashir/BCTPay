import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<BctpaySettingDetailsResponse> getBctPaySettingDetails({
  required String countryId,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.bctPaySettingDetail}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "country_id": countryId,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return BctpaySettingDetailsResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
