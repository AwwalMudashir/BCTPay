import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> uploadProfilePic({required XFile imageFile}) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrlCustomer/${ApiEndpoint.uploadProfile}'),
  );
  var image = await http.MultipartFile.fromPath(
    'profilepic',
    imageFile.path,
    // filename: imageFile.name,
  );
  request.headers.addAll(await ApiClient.header());
  request.files.add(image);
  var response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);
    final headers = response.headers;
    final statusCode = response.statusCode;
    final httpResponse =
        http.Response.bytes(responseData, statusCode, headers: headers);
    var data = jsonDecode(httpResponse.body);
    // print(data);
    return Response.fromJson(data);
  } else {
    throw Exception(response.toString());
  }
}
