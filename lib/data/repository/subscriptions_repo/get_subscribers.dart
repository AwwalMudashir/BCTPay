import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<SubscriberUserListResponse> getSubscribers({
  required int page,
  required int limit,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.getSubscriberUserList}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "page": "$page",
      "limit": "$limit",
      "filter": {},
    }),
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return SubscriberUserListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
