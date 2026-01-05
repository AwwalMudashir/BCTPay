import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ContactUsResponse> contactUs({
  required String fullname,
  required String email,
  required String phonenumber,
  required String message,
  required String type,
  required List<XFile?> queryImage,
}) async {
  var body = {
    "fullname": fullname,
    "email": email,
    "phonenumber": phonenumber,
    "message": message,
    "type": type,
  };

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrlCustomer/${ApiEndpoint.enquiry}'),
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

  log("$body ${request.files}");

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    debugPrint(data.toString());
    return ContactUsResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
