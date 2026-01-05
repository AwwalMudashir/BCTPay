import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<QueryDetailResponse> replyQuery({
  required String queryId,
  required String message,
  required List<XFile?> queryImage,
}) async {
  var body = {
    "queryId": queryId,
    "message": message,
  };

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrlCustomer/${ApiEndpoint.queryReply}'),
  );
  if (queryImage.isNotEmpty) {
    for (int i = 0; i < queryImage.length; i++) {
      var image = queryImage[i];
      request.files.add(await http.MultipartFile.fromPath(
          "query_image[$i]", image?.path ?? ""));
    }
  }

  request.headers.addAll(await ApiClient.header());

  request.fields.addAll(body);

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    debugPrint(data.toString());
    return QueryDetailResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
