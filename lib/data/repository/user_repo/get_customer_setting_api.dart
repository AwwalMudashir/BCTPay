import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<CustomerSettingResponse> customerSetting() async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.customerSettingDetail}"),
    headers: await ApiClient.header(),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return CustomerSettingResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
