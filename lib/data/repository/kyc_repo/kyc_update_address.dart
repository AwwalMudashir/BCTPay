import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<SubmitKYCResponse> updateKYCAddress({
  required KYCData? oldKYCData,
  required List<IdentityProof>? addressProofList,
  required String? pinCode,
  required String? city,
  required String? state,
  required String? address,
  required String? line1,
  required String? line2,
  required String? landmark,
}) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrlCustomer/${ApiEndpoint.updateKYCAddress}'),
  );
  var body = {
    'kyc_id': oldKYCData?.id ?? "",
    "zip_code": pinCode ?? "",
    "city": city ?? "",
    "state": state ?? "",
    "address": address ?? "",
    "line1": line1 ?? "",
    "line2": line2 ?? "",
    "landmark": landmark ?? "",
  };

  if (addressProofList != null) {
    List<String> identityIds = [];
    for (int i = 0; i < addressProofList.length; i++) {
      var identityDoc = addressProofList[i];
      identityIds.add(identityDoc.id ?? "");

      if (identityDoc.localFiles != null) {
        List<String> oldDocIds = [];
        for (int j = 0; j < identityDoc.localFiles!.length; j++) {
          var doc = identityDoc.localFiles![j];
          if (doc?.mimeType == "http") {
            var oldDoc = identityDoc.files![j];
            oldDocIds.add(oldDoc.id ?? "");
          } else {
            var multiPartFile = doc == null
                ? null
                : await http.MultipartFile.fromPath(
                    identityDoc.id == null
                        ? 'address_add_proof[$i][files]'
                        : 'add_proof[$i].files',
                    doc.path);
            multiPartFile != null ? request.files.add(multiPartFile) : null;
          }

          if (identityDoc.id == null) {
            ///new address doc
            request.fields["address_add_proof[$i][doc_id_number]"] =
                identityDoc.docIdNumber ?? "";
            request.fields["address_add_proof[$i][doc_type]"] =
                identityDoc.docType ?? "";
            request.fields["address_add_proof[$i][valid_from]"] =
                identityDoc.validFrom.toString();
            request.fields["address_add_proof[$i][valid_till]"] =
                identityDoc.validTill.toString();
          } else {
            request.fields["address_id[$i]"] = identityDoc.id ?? "";
            request.fields["add_proof[$i].doc_id_number"] =
                identityDoc.docIdNumber ?? "";
            request.fields["add_proof[$i].doc_type"] =
                identityDoc.docType ?? "";
            request.fields["add_proof[$i].valid_from"] =
                identityDoc.validFrom.toString();
            request.fields["add_proof[$i].valid_till"] =
                identityDoc.validTill.toString();
          }
        }
      }
    }
  }

  log("$body");
  log("${request.files}");
  log("${request.fields}");
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
