import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<VerifyContactResponse> verifyContact({
  required String receiverPhoneCode,
  required String receiverPhoneNumber,
}) async {
  var body = jsonEncode({
    "receiver_phone_code": receiverPhoneCode,
    "receiver_phone_number": receiverPhoneNumber
  });
  var response = await http.post(
      Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.verifyContact}"),
      headers: await ApiClient.header(),
      body: body);

  //log("${ApiEndpoint.verifyContact} $body");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //debugPrint(data.toString());
    return VerifyContactResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
