import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<FAQsListResponse> getFAQs({
  required int page,
  required int limit,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlPublic/${ApiEndpoint.faq}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "page": "$page",
      "limit": "$limit",
      "filter": {},
    }),
  );

  debugPrint(
      "$baseUrlCustomer/${ApiEndpoint.faq} --> \n${await ApiClient.header()}\n${jsonEncode({
        "page": "$page",
        "limit": "$limit",
        "filter": {},
      })}\n${response.body}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return FAQsListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
