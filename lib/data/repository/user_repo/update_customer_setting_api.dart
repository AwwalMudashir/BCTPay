import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<CustomerSettingResponse> updateCustomerSetting({
  String? language,
  String? currency,
  String? currencySymbol,
  String? themeColor,
  String? timezone,
}) async {
  var body = {};
  // body["customerId"] = await SharedPreferance.getCustomerId();
  // body["_id"] = await SharedPreferance.getUserId();
  if (language != null && language != "") body["language"] = language;
  if (currency != null && currency != "") body["currency"] = currency;
  if (currencySymbol != null && currencySymbol != "") {
    body["currencySymbol"] = currencySymbol;
  }
  if (themeColor != null && themeColor != "") body["themeColor"] = themeColor;
  if (timezone != null && timezone != "") body["timezone"] = timezone;
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.updateSetting}"),
      headers: await ApiClient.header(),
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return CustomerSettingResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
