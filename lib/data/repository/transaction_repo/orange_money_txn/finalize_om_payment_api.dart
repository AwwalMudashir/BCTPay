import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> finalizeOMpayment({
  required String token,
  required String? msisdnNumber,
  required String otp,
  required String orderId,
}) async {
  var body = {
    "token": token,
    "msisdn_number": msisdnNumber,
    "otp": otp,
    "order_id": orderId,
  };


  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.finalizeOMPayment}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  // debugPrint("$baseUrlCustomerTxn/${ApiEndpoint.finalizeOMPayment}");
  // debugPrint("${ApiEndpoint.finalizeOMPayment} body -> ${jsonEncode(body)}");
  // debugPrint("${ApiEndpoint.finalizeOMPayment} header -> ${await ApiClient.header()}");
  // debugPrint("${ApiEndpoint.finalizeOMPayment} resp -> ${json.decode(response.body)}");
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
