import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<RegionListResponse> getRegionList({required String countryIsos}) async {
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.regionList}"),
      headers: await ApiClient.header(),
      body: jsonEncode({"countryIsos": countryIsos}));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return RegionListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
