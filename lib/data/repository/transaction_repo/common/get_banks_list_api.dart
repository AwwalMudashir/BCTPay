import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<BanksListResponse> getBanksList({required String accountType}) async {
  final isWallet = accountType == "WALLET";
  final endpoint = isWallet ? ApiEndpoint.momoList : ApiEndpoint.bankList;
  final base = isWallet ? baseUrlCore : baseUrl;
  var response = await http.get(
    Uri.parse("$base/$endpoint"),
    headers: await ApiClient.header(useCore: isWallet),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return BanksListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
