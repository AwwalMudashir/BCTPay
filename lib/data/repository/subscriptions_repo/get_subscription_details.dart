import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<SubscriberUserDetailResponse> getSubscriptionDetails({
  required String id,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.getAllSubscriberUserAccDetails}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "subscriber_userAcc_id": id,
    }),
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return SubscriberUserDetailResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
