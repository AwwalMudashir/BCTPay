import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<CurrencyListResponse> getCurrencyList() async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.currencyList}"),
    headers: await ApiClient.header(),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return CurrencyListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
