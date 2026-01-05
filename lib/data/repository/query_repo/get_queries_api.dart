import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<QueriesListResponse> getQueries({
  required int page,
  required int limit,
  required QueryFilterModel? filter,
}) async {
  final body = {
    "page": "$page",
    "limit": "$limit",
    "filter": filter?.toMap() ?? "",
  };
  var response = await http.post(
      Uri.parse("$baseUrlCustomer/${ApiEndpoint.queriesList}"),
      headers: await ApiClient.header(),
      body: jsonEncode(body));

  log(jsonEncode(body));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    debugPrint(data.toString());
    return QueriesListResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
