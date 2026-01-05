import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<CountryListResponse> getCountryList() async {
  var response = await http.post(
      Uri.parse("$baseUrlPublic/${ApiEndpoint.countryList}"),
      headers: await ApiClient.header());
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return CountryListResponse.fromJson(data);
  } else {
    throw ExceptionHandler.handleHttpResponse(response);
  }
}
