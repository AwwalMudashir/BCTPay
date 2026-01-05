import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<SubmitKYCResponse> updateKYCIdentityProof({
  required String? userName,
  required String? dob,
  required KYCData? oldKYCData,
  required List<IdentityProof>? identityProofList,
  required String? phoneCode,
  required String? phoneNumber,
  required String? email,
}) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrlCustomer/${ApiEndpoint.updateKYCIdentity}'),
  );
  var body = {
    'kyc_id': oldKYCData?.id ?? "",
    "user_name": userName ?? "",
    "user_dob": dob ?? "",
    "phone_code": phoneCode ?? "",
    "phone_number": phoneNumber ?? "",
    "email": email ?? "",
  };

  if (identityProofList != null) {
    List<String> identityIds = [];
    for (int i = 0; i < identityProofList.length; i++) {
      var identityDoc = identityProofList[i];
      if (identityDoc.id?.isNotEmpty ?? false) {
        identityIds.add(identityDoc.id ?? "");
      }
      // for (var identityDoc in identityProofList) {
      if (identityDoc.localFiles != null) {
        List<String> oldDocIds = [];
        // for (var doc in identityDoc.localFiles!) {
        for (int j = 0; j < identityDoc.localFiles!.length; j++) {
          var doc = identityDoc.localFiles![j];
          if (doc?.mimeType == "http") {
            var oldDoc = identityDoc.files![j];
            oldDocIds.add(oldDoc.id ?? "");
          } else {
            var multiPartFile = doc == null
                ? null
                : await http.MultipartFile.fromPath(
                    identityDoc.id != null
                        ? 'identity_proof[$i].files'
                        : 'add_identity_proof[$i][files]',
                    doc.path);
            multiPartFile != null ? request.files.add(multiPartFile) : null;
            // print(multiPartFile?.field);
          }

          if (identityDoc.id != null) {
            ///old object identity_proof
            request.fields["identity_id[$i]"] = identityDoc.id ?? "";
            request.fields["identity_proof[$i].doc_type"] =
                identityDoc.docType ?? "";
            request.fields["identity_proof[$i].doc_id_number"] =
                identityDoc.docIdNumber ?? "";
            request.fields["identity_proof[$i].valid_from"] =
                identityDoc.validFrom.toString();
            request.fields["identity_proof[$i].valid_till"] =
                identityDoc.validTill.toString();
          } else {
            ///new object
            ///add_identity_proof
            request.fields["add_identity_proof[$i][doc_type]"] =
                identityDoc.docType ?? "";
            request.fields["add_identity_proof[$i][doc_id_number]"] =
                identityDoc.docIdNumber ?? "";
            request.fields["add_identity_proof[$i][valid_from]"] =
                identityDoc.validFrom.toString();
            request.fields["add_identity_proof[$i][valid_till]"] =
                identityDoc.validTill.toString();
          }
        }
      }
    }
  }
  request.headers.addAll(await ApiClient.header());


  request.fields.addAll(body);
  request.fields;
  debugPrint("$baseUrlCustomer/${ApiEndpoint.updateKYCIdentity} -> ${request.files}");
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
