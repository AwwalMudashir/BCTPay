import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<VerifyQrResponse> verifyQR({
  required String qrCode,
  required String type,
}) async {
  var body = jsonEncode({
    "qr_code": qrCode,
    "qr_type": type,
  });
  var response = await http.post(
      Uri.parse("$baseUrlCustomerTxn${ApiEndpoint.verifyQR}"),
      headers: await ApiClient.header(),
      body: body);
  //log("${ApiEndpoint.verifyQR} $body");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //log(jsonEncode(data));
    //debugPrint("${ApiEndpoint.verifyQR} response--> ${jsonEncode(data)}");
    return VerifyQrResponse.fromJson(data, type);
  } else {
    throw Exception(response.body);
  }
}
