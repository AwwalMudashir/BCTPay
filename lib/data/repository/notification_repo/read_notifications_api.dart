import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ReadNotificationResponse> readNotification(
    List<String>? notificationIds, bool readAll) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.readNotification}"),
    headers: await ApiClient.header(),
    body: jsonEncode({"notificationId": readAll ? "ALL" : notificationIds}),
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ReadNotificationResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
