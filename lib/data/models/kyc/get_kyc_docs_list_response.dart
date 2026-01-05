class KycDocsListResponse {
  final int code;
  final List<KYCDocData>? data;
  final String message;
  final bool? success;

  KycDocsListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory KycDocsListResponse.fromJson(Map<String, dynamic> json) =>
      KycDocsListResponse(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<KYCDocData>.from(
                json["data"].map((x) => KYCDocData.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class KYCDocData {
  final String id;
  final String countryName;
  final String countryCode;
  final String accessType;
  final String docNameForGn;
  final String docNameForEn;
  final String frontDocRequired;
  final String backDocRequired;
  final List<String> fileExtensionAllowed;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool isMandatory;
  final String? docImageIcon;
  final int? numberOfFiles;
  final String? identityType;

  KYCDocData({
    required this.id,
    required this.countryName,
    required this.countryCode,
    required this.accessType,
    required this.docNameForGn,
    required this.docNameForEn,
    required this.frontDocRequired,
    required this.backDocRequired,
    required this.fileExtensionAllowed,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isMandatory,
    required this.docImageIcon,
    required this.numberOfFiles,
    required this.identityType,
  });

  factory KYCDocData.fromJson(Map<String, dynamic> json) => KYCDocData(
        id: json["_id"],
        countryName: json["country_name"],
        countryCode: json["country_code"],
        accessType: json["access_type"],
        docNameForGn: json["doc_name_for_gn"],
        docNameForEn: json["doc_name_for_en"],
        frontDocRequired: json["front_doc_required"],
        backDocRequired: json["back_doc_required"],
        fileExtensionAllowed:
            List<String>.from(json["file_extension_allowed"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isMandatory: json["is_mandatory"] == "true",
        docImageIcon: json["doc_image_icon"],
        numberOfFiles: json["number_of_files"],
        identityType: json["identity_type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "country_name": countryName,
        "country_code": countryCode,
        "access_type": accessType,
        "doc_name_for_gn": docNameForGn,
        "doc_name_for_en": docNameForEn,
        "front_doc_required": frontDocRequired,
        "back_doc_required": backDocRequired,
        "file_extension_allowed":
            List<dynamic>.from(fileExtensionAllowed.map((x) => x)),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "is_mandatory": isMandatory,
        "doc_image_icon": docImageIcon,
        "number_of_files": numberOfFiles,
        "identity_type": identityType,
      };
}
