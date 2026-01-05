import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> deleteCustomerAccount() async {
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.deleteCustomerAccount}"),
      headers: await ApiClient.header());

  //log("🚀Header ~ ${jsonEncode(await ApiClient.header())}:");
  // log("🚀${ApiEndpoint.deleteCustomerAccount} ~ ${jsonEncode(await ApiClient.header())}:");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
