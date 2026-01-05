import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> checkAccountNumberStatus({
  required String phoneCode,
  required String accountNumber,
  required String? institutionName,
  required String accountType,
}) async {
  var body = {
    "account_number": "$phoneCode$accountNumber",
    "institution_name": institutionName,
    "account_type": accountType,
  };

  // print(jsonEncode(body));
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.checkThirdPartyAccountStatus}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );


  //debugPrint("${ApiEndpoint.checkThirdPartyAccountStatus} response -> ${response.body}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
