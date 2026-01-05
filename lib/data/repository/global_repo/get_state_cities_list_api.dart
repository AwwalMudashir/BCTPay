import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<StateCitiesResponse> getStateCitiesList() async {
  var response = await http.post(
      Uri.parse("$baseUrlPublic/${ApiEndpoint.stateCitiesList}"),
      headers: await ApiClient.header(),
      body: jsonEncode({"country_name": selectedCountry?.countryName}));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return StateCitiesResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
