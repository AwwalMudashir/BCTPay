import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> verifyTxnQR({
  required String qrCode,
  required String type,
}) async {
  var body = jsonEncode({"qr_code": qrCode, "type": type});
  var response = await http.post(
      Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.verifyTxnQR}"),
      headers: await ApiClient.header(),
      body: body);

  //log("${ApiEndpoint.verifyTxnQR} $body");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
