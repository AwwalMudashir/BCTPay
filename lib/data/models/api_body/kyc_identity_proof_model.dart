// import 'package:bctpay/globals/globals.dart';

// class IdentityProof {
//   final String docType;
//   final String docIDNumber;
//   final DateTime? validFrom;
//   final DateTime? validTill;
//   List<XFile?>? files;

//   IdentityProof({
//     required this.docType,
//     required this.docIDNumber,
//     required this.validFrom,
//     required this.validTill,
//     required this.files,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'doc_type': docType,
//       'doc_id_number': docIDNumber,
//       'valid_from': validFrom,
//       'valid_till': validTill,
//       'files': files
//       // "files": files?.map((e) async => request.files
//       //     .add(await MultipartFile.fromPath('files', e?.path ?? "")))
//     };
//   }

//   // factory IdentityProof.fromMap(Map<String, dynamic> map) {
//   //   return IdentityProof(
//   //     docType: map['doc_type'] ?? '',
//   //     docIDNumber: map['doc_id_number'] ?? '',
//   //     validFrom: DateTime.tryParse(map['valid_from']),
//   //     validTill: DateTime.tryParse(map['valid_till']),
//   //   );
//   // }

//   String toJson() => json.encode(toMap());

//   // factory IdentityProof.fromJson(String source) =>
//   //     IdentityProof.fromMap(json.decode(source));
// }
