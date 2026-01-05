import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InvoiceListResponse> invoiceList({
  required int page,
  required int limit,
  required InvoiceFilterModel? filter,
}) async {
  final body = {
    "page": "$page",
    "limit": "$limit",
    "filter": filter?.toMap() ?? "",
  };
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.invoiceList}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );
  log(jsonEncode(body));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return InvoiceListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
