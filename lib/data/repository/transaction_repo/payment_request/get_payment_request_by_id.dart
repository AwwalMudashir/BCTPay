import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> getPaymentRequestById({
  required String requestId,
}) async {
  final url = "$baseUrlCustomerTxn/${ApiEndpoint.sendPaymentRequest}";
  final headers = await ApiClient.header();
  final body = jsonEncode({"request_id": requestId});
  print("[API] POST $url");
  print("[API] Body: $body");
  print("[API] Headers: {Content-Type: ${headers['Content-Type']}, Accept-Language: ${headers['Accept-Language']}, x-token: ***masked***, Authorization: ***masked***}");
  var response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: body,
  );
  print("[API] Response ($url): ${response.statusCode} ${response.body}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
