import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<QueryTypeResponse> getTypeOfQueries() async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.getTypeOfQueries}"),
    headers: await ApiClient.header(),

  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return QueryTypeResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
