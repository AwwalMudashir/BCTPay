import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> openExpressAccount({
  required OpenExpressAccountBody body,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.openExpressAcc}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body.toMap()),
  );

  if (response.statusCode == 200) {
    return responseFromJson(response.body);
  } else {
    throw Exception(response.body);
  }
}
