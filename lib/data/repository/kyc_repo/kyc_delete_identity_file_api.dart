import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> deleteKycIdentityDoc(
    {required IdentityProof identityProof,
    required KYCData? kycData,
    required bool isFile}) async {
  var body = {
    "kyc_id": kycData?.id,
    "identity_id": identityProof.id,
    "identity_type": isFile ? "file" : "identity", //file/identity
    "file_id": identityProof.files?.first.id,
  };
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.deleteKycIdentityDocument}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
