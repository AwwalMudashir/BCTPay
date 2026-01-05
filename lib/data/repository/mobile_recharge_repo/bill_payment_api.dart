import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<BillPaymentResponse> billPayment({
  required String paymentwith,
  required double amount,
  required String customerPhone,
  required String skuCode,
  required String sendCurrencyIso,
  required String accountNumber,
}) async {
  var response =
      await http.post(Uri.parse("$baseUrlCustomer/${ApiEndpoint.billPayment}"),
          headers: await ApiClient.header(),
          body: jsonEncode({
            "paymentwith": paymentwith,
            "amount": "$amount",
            "customerPhone": customerPhone,
            "SkuCode": skuCode,
            "SendCurrencyIso": sendCurrencyIso,
            "AccountNumber": accountNumber
          }));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return BillPaymentResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
