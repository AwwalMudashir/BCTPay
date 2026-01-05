import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<QueryDetailResponse> getQueryDetail({required String queryId}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.queryDetail}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "queryId": queryId,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    debugPrint(data.toString());
    return QueryDetailResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
