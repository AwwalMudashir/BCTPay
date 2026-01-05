import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ProductListResponse> getProductList({
  required String regionCodes,
  required String accountNumber,
  required String providerCode,
  required String benefits,
}) async {
  var response =
      await http.post(Uri.parse("$baseUrlCustomer/${ApiEndpoint.productList}"),
          headers: await ApiClient.header(),
          body: jsonEncode({
            "regionCodes": regionCodes,
            "accountNumber": accountNumber,
            "ProviderCode": providerCode,
            "benefits": benefits,
            "skuCodes": ""
          }));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return ProductListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
