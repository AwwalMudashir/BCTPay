import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<NotificationsListResponse> getNotificationsList({
  required int page,
  required int limit,
}) async {
  final body = jsonEncode({
    "page": "$page",
    "limit": "$limit",
  });
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.notificationList}"),
      headers: await ApiClient.header(),
      body: body);
  log("${ApiEndpoint.notificationList} $body");
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return NotificationsListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
