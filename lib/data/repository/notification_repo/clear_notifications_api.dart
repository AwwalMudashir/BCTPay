import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ClearNotificationResponse> clearNotifications(
    List<String>? notificationIds,
    {required bool clearAll}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.clearNotification}"),
    headers: await ApiClient.header(),
    body: jsonEncode({"notificationId": clearAll ? "ALL" : notificationIds}),
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ClearNotificationResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
