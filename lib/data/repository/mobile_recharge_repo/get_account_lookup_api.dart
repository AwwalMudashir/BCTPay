import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<GetAccountLookupResponse> getAccountLookup(
    {required String accountNumber}) async {
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.accountLookup}"),
      headers: await ApiClient.header(),
      body: jsonEncode({
        "accountNumber": accountNumber.replaceAll(
            RegExp('[^A-Za-z0-9]'), '') //"918319108122"
      }));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return GetAccountLookupResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
