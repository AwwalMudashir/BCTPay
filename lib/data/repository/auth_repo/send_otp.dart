import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> sendOTP({
  required LoginBody? loginBody,
}) async {
  var response = await http.post(
      Uri.parse("$baseUrlPublic/${ApiEndpoint.sendOTP}"),
      headers: await ApiClient.header(),
      body: jsonEncode(loginBody?.toJson())
      );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
