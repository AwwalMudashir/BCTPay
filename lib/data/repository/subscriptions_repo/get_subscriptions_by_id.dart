import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> getSubscriptionById({
  required String id,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.subscriptionDetails}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "subscription_id": id,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    log(jsonEncode(data));
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
