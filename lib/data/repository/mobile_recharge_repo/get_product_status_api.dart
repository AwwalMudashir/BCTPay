import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ProductStatusResponse> getProductStatus() async {
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.productStatus}"),
      headers: await ApiClient.header(),
      body: jsonEncode({"languageCodes": "en", "skuCodes": "IN_1A_IN_TopUp"}));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ProductStatusResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
