import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> getOmCharges({
  required String token,
  required String? msisdnNumber,
  required String? orderId,
}) async {
  var body = {
    "token": token,
    "msisdn_number": msisdnNumber,
    "order_id": orderId,
  };


  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.getOMCharges}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
