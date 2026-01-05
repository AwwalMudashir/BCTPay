import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<SubmitKYCResponse> submitKYC({
  required String? userName,
  required String? dob,
  required KYCData? oldKYCData,
  required List<IdentityProof>? identityProofList,
  required List<IdentityProof>? addressProofList,
  required XFile? selfieImage,
  required String? phoneCode,
  required String? phoneNumber,
  required String? email,
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
    Uri.parse('$baseUrlCustomer/${ApiEndpoint.submitKYC}'),
  );
  var body = {
    'user_name': userName ?? "",
    'user_dob': dob ?? "", //'1990-01-01',
    'photo_proof[comments_on_pic]': 'Clear photo',
    'photo_proof[kyc_pic_name]': 'photo',
    "phone_code": phoneCode ?? "",
    "phone_number": phoneNumber ?? "",
    "email": email ?? "",
    "zip_code": pinCode ?? "",
    "city": city ?? "",
    "state": state ?? "",
    "address": address ?? "",
    "line1": line1 ?? "",
    "line2": line2 ?? "",
    "landmark": landmark ?? "",
  };

  if (selfieImage?.mimeType == "http") {
    request.fields["photo_proof.file[0]"] = selfieImage?.path ?? "";
  } else {
    var selfieMultipartFile = selfieImage == null
        ? null
        : await http.MultipartFile.fromPath(
            'photo_proof.file', selfieImage.path);
    selfieMultipartFile != null ? request.files.add(selfieMultipartFile) : null;
  }
  if (addressProofList != null) {
    for (int i = 0; i < addressProofList.length; i++) {
      var identityDoc = addressProofList[i];
      if (identityDoc.localFiles != null) {
        for (int j = 0; j < identityDoc.localFiles!.length; j++) {
          var doc = identityDoc.localFiles![j];
          if (doc?.mimeType == "http") {
            request.fields["add_proof[$i].files[$j]"] = doc?.path ?? "";
          } else {
            var multiPartFile = doc == null
                ? null
                : await http.MultipartFile.fromPath(
                    'add_proof[$i].files', doc.path);
            multiPartFile != null ? request.files.add(multiPartFile) : null;
          }
          request.fields["add_proof[$i][doc_type]"] = identityDoc.docType ?? "";
          request.fields["add_proof[$i][doc_id_number]"] =
              identityDoc.docIdNumber ?? "";
          request.fields["add_proof[$i][valid_from]"] =
              identityDoc.validFrom.toString();
          request.fields["add_proof[$i][valid_till]"] =
              identityDoc.validTill.toString();
        }
      }
    }
  }

  if (identityProofList != null) {
    for (int i = 0; i < identityProofList.length; i++) {
      var identityDoc = identityProofList[i];
      // for (var identityDoc in identityProofList) {
      if (identityDoc.localFiles != null) {
        // for (var doc in identityDoc.localFiles!) {
        for (int j = 0; j < identityDoc.localFiles!.length; j++) {
          var doc = identityDoc.localFiles![j];
          if (doc?.mimeType == "http") {
            request.fields["identity_proof[$i].files[$j]"] = doc?.path ?? "";
          } else {
            var multiPartFile = doc == null
                ? null
                : await http.MultipartFile.fromPath(
                    'identity_proof[$i].files', doc.path);
            multiPartFile != null ? request.files.add(multiPartFile) : null;
            // request.fields["identity_proof[$i].files[0][file_extension]"] =
            //     doc?.name.split(".").last ?? "png";
          }
          request.fields["identity_proof[$i][doc_type]"] =
              identityDoc.docType ?? "";
          request.fields["identity_proof[$i][doc_id_number]"] =
              identityDoc.docIdNumber ?? "";
          request.fields["identity_proof[$i][valid_from]"] =
              identityDoc.validFrom.toString();
          request.fields["identity_proof[$i][valid_till]"] =
              identityDoc.validTill.toString();
        }
      }
    }
  }
  log("------------------------------------");
  log(jsonEncode(body));
  log(jsonEncode(request.fields));
  log("------------------------------------");

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
    // print(data);
    return SubmitKYCResponse.fromJson(data);
  } else {
    throw Exception(response.statusCode);
  }
}
