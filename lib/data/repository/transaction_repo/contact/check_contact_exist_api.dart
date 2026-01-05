import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> checkContactExist({
  required String receiverPhoneCode,
  required String receiverPhoneNumber,
}) async {
  var response = await http.post(
      Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.checkContactExist}"),
      headers: await ApiClient.header(),
      body: jsonEncode({
        "receiver_phone_code": receiverPhoneCode,
        "receiver_phone_number": receiverPhoneNumber
      }));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
   // debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
