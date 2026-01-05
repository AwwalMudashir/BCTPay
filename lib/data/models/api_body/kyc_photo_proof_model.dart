import 'dart:convert';

class PhotoProof {
  final String docType;
  final String commentsOn;
  final DateTime? validFrom;
  final DateTime? validTill;

  PhotoProof(
      {required this.docType,
      required this.commentsOn,
      required this.validFrom,
      required this.validTill});

  Map<String, dynamic> toMap() {
    return {
      'doc_type': docType,
      'comments_on': commentsOn,
      'valid_from': validFrom.toString(),
      'valid_till': validTill.toString,
    };
  }

  factory PhotoProof.fromMap(Map<String, dynamic> map) {
    return PhotoProof(
      docType: map['doc_type'] ?? '',
      commentsOn: map['comments_on'] ?? '',
      validFrom: DateTime.tryParse(map['valid_from']),
      validTill: DateTime.tryParse(map['valid_till']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoProof.fromJson(String source) =>
      PhotoProof.fromMap(json.decode(source));
}
