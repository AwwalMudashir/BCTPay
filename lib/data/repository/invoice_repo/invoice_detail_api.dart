import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InvoiceDetailResponse> invoiceDetail({
  required String invoiceNumber,
}) async {
  var body = {"invoice_number": invoiceNumber};
  var response = await http.post(
      Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.invoiceDetail}"),
      headers: await ApiClient.header(),
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return InvoiceDetailResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
