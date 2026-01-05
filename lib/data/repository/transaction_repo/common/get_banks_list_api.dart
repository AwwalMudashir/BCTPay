import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<BanksListResponse> getBanksList({required String accountType}) async {
  final endpoint =
      accountType == "WALLET" ? ApiEndpoint.momoList : ApiEndpoint.bankList;
  var response = await http.get(
    Uri.parse("$baseUrl/$endpoint"),
    headers: await ApiClient.header(),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return BanksListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
