import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<CouponListResponse> getCouponList() async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.couponList}"),
    headers: await ApiClient.header(),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return CouponListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
