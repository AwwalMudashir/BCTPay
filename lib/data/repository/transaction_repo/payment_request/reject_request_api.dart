import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> rejectPaymentRequest({
  required String requestId,
}) async {
  var body = jsonEncode({
    "requested_id": requestId,
  });
  final url = "$baseUrlCustomerTxn/${ApiEndpoint.rejectPR}";
  final headers = await ApiClient.header();
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
    // debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
