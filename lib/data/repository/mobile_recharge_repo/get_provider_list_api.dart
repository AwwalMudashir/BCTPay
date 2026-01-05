import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ProviderListResponse> getProviderList({
  required String? providerCodes,
  required String? countryIsos,
  required String? regionCodes,
  required String? accountNumber,
  required String? benefits,
  required String? skuCodes,
}) async {
  var body = {};
  if (providerCodes != null) body["providerCodes"] = providerCodes;
  if (countryIsos != null) body["countryIsos"] = countryIsos;
  if (regionCodes != null) body["regionCodes"] = regionCodes;
  if (accountNumber != null) body["accountNumber"] = accountNumber;
  if (benefits != null) body["benefits"] = benefits;
  if (skuCodes != null) body["skuCodes"] = skuCodes;

  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.providerList}"),
      headers: await ApiClient.header(),
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ProviderListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
