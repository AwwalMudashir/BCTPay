import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ProfileResponse> getProfile() async {
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.getProfile}"),
      headers: await ApiClient.header());

  //log("🚀Header ~ ${jsonEncode(await ApiClient.header())}:");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return ProfileResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
