import 'package:bctpay/globals/globals.dart';
import 'package:http/http.dart';

class AddressProof {
  final String docType;
  final String commentsOn;
  final DateTime? validFrom;
  final DateTime? validTill;
  final List<XFile?>? files;

  AddressProof({
    required this.docType,
    required this.commentsOn,
    required this.validFrom,
    required this.validTill,
    required this.files,
  });

  Map<String, dynamic> toMap(MultipartRequest request) {
    return {
      'doc_type': docType,
      'comments_on': commentsOn,
      'valid_from': validFrom.toString(),
      'valid_till': validTill.toString,
      // "files": files?.map((e) async => request.files
      //     .add(await MultipartFile.fromPath('files', e?.path ?? "")))
    };
  }

  // factory AddressProof.fromMap(Map<String, dynamic> map) {
  //   return AddressProof(
  //     docType: map['doc_type'] ?? '',
  //     commentsOn: map['comments_on'] ?? '',
  //     validFrom: DateTime.tryParse(map['valid_from']),
  //     validTill: DateTime.tryParse(map['valid_till']),
  //   );
  // }

  String toJson(MultipartRequest request) => json.encode(toMap(request));

  // factory AddressProof.fromJson(String source) =>
  //     AddressProof.fromMap(json.decode(source));
}
