import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<SubmitKYCResponse> updateKYCSelfie({
  required KYCData? oldKYCData,
  required XFile? selfieImage,
}) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrlCustomer/${ApiEndpoint.updateKYCSelfie}'),
  );
  var body = {
    'kyc_id': oldKYCData?.id ?? "",
  };

  if (selfieImage?.mimeType == "http") {
    request.fields["selfie_id"] = oldKYCData?.photoProof?.id ?? "";
  } else {
    var selfieMultipartFile = selfieImage == null
        ? null
        : await http.MultipartFile.fromPath(
            'photo_proof.file', selfieImage.path);
    selfieMultipartFile != null ? request.files.add(selfieMultipartFile) : null;
  }
  request.headers.addAll(await ApiClient.header());

  request.fields.addAll(body);
  request.fields;
  var response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await response.stream.toBytes();
    final headers = response.headers;
    final statusCode = response.statusCode;
    final httpResponse =
        http.Response.bytes(responseData, statusCode, headers: headers);
    var data = jsonDecode(httpResponse.body);
    return SubmitKYCResponse.fromJson(data);
  } else {
    throw Exception(response.toString());
  }
}
