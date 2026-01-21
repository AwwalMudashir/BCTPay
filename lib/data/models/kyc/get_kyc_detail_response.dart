// To parse this JSON data, do
//
//     final kycDetailResponse = kycDetailResponseFromJson(jsonString);

import 'package:bctpay/globals/index.dart';

KycDetailResponse kycDetailResponseFromJson(String str) =>
    KycDetailResponse.fromJson(json.decode(str));

String kycDetailResponseToJson(KycDetailResponse data) =>
    json.encode(data.toJson());

class KycDetailResponse {
  final int? code;
  final KYCData? data;
  final String? message;
  final bool? success;
  final String? error;

  KycDetailResponse({
    this.code,
    this.data,
    required this.message,
    this.success,
    this.error,
  });

  factory KycDetailResponse.fromJson(Map<String, dynamic> json) =>
      KycDetailResponse(
        code: json["code"],
        data: json["data"] == null ? null : KYCData.fromJson(json["data"]),
        message: json["message"]?.toString(),
        success: json["success"],
        error: json["error"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "message": message,
        "success": success,
        "error": error,
      };
}

class KYCData {
  final String? id;
  final String? customerId;
  final String? userName;
  final DateTime? userDob;
  final KYCStatus? kycStatus;
  final List<IdentityProof>? identityProof;
  final IdentityProof? photoProof;
  final List<IdentityProof>? addProof;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? email;
  final String? phoneNumber;
  final String? phoneCode;
  final String? address;
  final String? state;
  final String? city;
  final String? pinCode;

  KYCData(
      {this.id,
      this.customerId,
      this.userName,
      this.userDob,
      this.kycStatus,
      this.identityProof,
      this.photoProof,
      this.addProof,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.address,
      this.state,
      this.city,
      this.email,
      this.phoneNumber,
      this.phoneCode,
      this.pinCode});

  factory KYCData.fromJson(Map<String, dynamic> json) => KYCData(
      id: json["_id"],
      customerId: json["customerId"],
      userName: json["user_name"],
      userDob:
          json["user_dob"] == null ? null : DateTime.tryParse(json["user_dob"]),
      kycStatus: kycStatusValues.map[json["kyc_status"]],
      identityProof: json["identity_proof"] == null
          ? []
          : List<IdentityProof>.from(
              json["identity_proof"]!.map((x) => IdentityProof.fromJson(x))),
      photoProof: json["photo_proof"] == null
          ? null
          : IdentityProof.fromJson(json["photo_proof"]),
      addProof: json["add_proof"] == null
          ? []
          : List<IdentityProof>.from(
              json["add_proof"]!.map((x) => IdentityProof.fromJson(x))),
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.tryParse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null
          ? null
          : DateTime.tryParse(json["updatedAt"]),
      v: json["__v"],
      address: json["address"],
      state: json["state"],
      city: json["city"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      phoneCode: json["phone_code"],
      pinCode: json["zip_code"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "user_name": userName,
        "user_dob": userDob?.toIso8601String(),
        "kyc_status": kycStatusValues.reverse[kycStatus],
        "identity_proof": identityProof == null
            ? []
            : List<dynamic>.from(identityProof!.map((x) => x.toJson())),
        "photo_proof": photoProof?.toJson(),
        "add_proof": addProof == null
            ? []
            : List<dynamic>.from(addProof!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "address": address,
        "state": state,
        "city": city,
        "email": email,
        "phone_number": phoneNumber,
        "phone_code": phoneCode,
        "zip_code": pinCode
      };
}

class IdentityProof extends Equatable {
  final String? canUpload;
  final KYCStatus? status;
  final String? docType;
  final String? viewComment;
  final String? comment;
  final List<FileElement>? files;
  final DateTime? lastUploadAt;
  final DateTime? lastVerificationAt;
  final Atedby? createdby;
  final String? createdbyUserId;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Atedby? updatedby;
  final String? updatedbyUserId;
  final String? docIdNumber;
  final DateTime? validFrom;
  final DateTime? validTill;
  final String? fileName;
  final List<XFile?>? localFiles;

  const IdentityProof({
    this.canUpload,
    this.status,
    this.docType,
    this.viewComment,
    this.comment,
    this.files,
    this.lastUploadAt,
    this.lastVerificationAt,
    this.createdby,
    this.createdbyUserId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.updatedby,
    this.updatedbyUserId,
    this.docIdNumber,
    this.validFrom,
    this.validTill,
    this.fileName,
    this.localFiles,
  });

  IdentityProof copyWith({
    String? canUpload,
    KYCStatus? status,
    String? docType,
    String? viewComment,
    String? comment,
    List<FileElement>? files,
    DateTime? lastUploadAt,
    DateTime? lastVerificationAt,
    Atedby? createdby,
    String? createdbyUserId,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Atedby? updatedby,
    String? updatedbyUserId,
    String? docIdNumber,
    DateTime? validFrom,
    DateTime? validTill,
    String? fileName,
    List<XFile?>? localFiles,
  }) =>
      IdentityProof(
        canUpload: canUpload ?? this.canUpload,
        status: status ?? this.status,
        docType: docType ?? this.docType,
        viewComment: viewComment ?? this.viewComment,
        comment: comment ?? this.comment,
        files: files ?? this.files,
        lastUploadAt: lastUploadAt ?? this.lastUploadAt,
        lastVerificationAt: lastVerificationAt ?? this.lastVerificationAt,
        createdby: createdby ?? this.createdby,
        createdbyUserId: createdbyUserId ?? this.createdbyUserId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedby: updatedby ?? this.updatedby,
        updatedbyUserId: updatedbyUserId ?? this.updatedbyUserId,
        docIdNumber: docIdNumber ?? this.docIdNumber,
        validFrom: validFrom ?? this.validFrom,
        validTill: validTill ?? this.validTill,
        fileName: fileName ?? this.fileName,
        localFiles: localFiles ?? this.localFiles,
      );

  factory IdentityProof.fromJson(Map<String, dynamic> json) => IdentityProof(
      canUpload: json["can_upload"],
      status: kycStatusValues.map[json["status"]],
      docType: json["doc_type"],
      viewComment: json["view_comment"],
      comment: json["comments_on"],
      files: json["files"] == null
          ? []
          : List<FileElement>.from(
              json["files"]!.map((x) => FileElement.fromJson(x))),
      lastUploadAt: json["last_upload_at"] == null
          ? null
          : DateTime.tryParse(json["last_upload_at"]),
      lastVerificationAt: json["last_verification_at"] == null
          ? null
          : DateTime.tryParse(json["last_verification_at"]),
      createdby:
          json["createdby"] == null ? null : Atedby.fromJson(json["createdby"]),
      createdbyUserId: json["createdby_user_id"],
      id: json["_id"],
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.tryParse(json["createdAt"]),
      updatedAt: json["updatedAt"] == null
          ? null
          : DateTime.tryParse(json["updatedAt"]),
      updatedby:
          json["updatedby"] == null ? null : Atedby.fromJson(json["updatedby"]),
      updatedbyUserId: json["updatedby_user_id"],
      docIdNumber: json["doc_id_number"],
      validFrom: json["valid_from"] == null
          ? null
          : DateTime.tryParse(json["valid_from"]),
      validTill: json["valid_till"] == null
          ? null
          : DateTime.tryParse(json["valid_till"]),
      fileName: json["file_name"],
      localFiles: json["files"] == null
          ? []
          : List<FileElement>.from(
                  json["files"]!.map((x) => FileElement.fromJson(x)))
              .map((e) => XFile(e.fileName ?? "", mimeType: "http", name: e.id))
              .toList());

  Map<String, dynamic> toJson() => {
        "can_upload": canUpload,
        "status": kycStatusValues.reverse[status],
        "doc_type": docType,
        "view_comment": viewComment,
        "comments_on": comment,
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
        "last_upload_at": lastUploadAt?.toIso8601String(),
        "last_verification_at": lastVerificationAt?.toIso8601String(),
        "createdby": createdby?.toJson(),
        "createdby_user_id": createdbyUserId,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "updatedby": updatedby?.toJson(),
        "updatedby_user_id": updatedbyUserId,
        "doc_id_number": docIdNumber,
        "valid_from": validFrom?.toIso8601String(),
        "valid_till": validTill?.toIso8601String(),
        "file_name": fileName,
      };

  @override
  List<Object?> get props => [
        // canUpload,
        // status,
        docType,
        // viewComment,
        // comment,
        files,
        // lastUploadAt,
        // lastVerificationAt,
        // createdby,
        // createdbyUserId,
        id,
        // createdAt,
        // updatedAt,
        // updatedby,
        // updatedbyUserId,
        docIdNumber,
        validFrom,
        validTill,
        // fileName,
        localFiles,
      ];
}

class Atedby {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? role;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? profilePic;

  Atedby({
    this.userId,
    this.fullName,
    this.email,
    this.role,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.profilePic,
  });

  Atedby copyWith({
    String? userId,
    String? fullName,
    String? email,
    String? role,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? profilePic,
  }) =>
      Atedby(
        userId: userId ?? this.userId,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        role: role ?? this.role,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        profilePic: profilePic ?? this.profilePic,
      );

  factory Atedby.fromJson(Map<String, dynamic> json) => Atedby(
        userId: json["user_id"],
        fullName: json["full_name"],
        email: json["email"],
        role: json["role"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "email": email,
        "role": role,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "profile_pic": profilePic,
      };
}

// class IdentityProof {
//   final String? canUpload;
//   final String? status;
//   final String? docType;
//   final String? viewComment;
//   final List<FileElement>? files;
//   final String? id;
//   final DateTime? lastUploadAt;
//   final DateTime? lastVerificationAt;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? docIdNumber;
//   final DateTime? validFrom;
//   final DateTime? validTill;
//   final String? fileName;
//   List<XFile?>? localFiles;

//   IdentityProof({
//     this.canUpload,
//     this.status,
//     this.docType,
//     this.viewComment,
//     this.files,
//     this.id,
//     this.lastUploadAt,
//     this.lastVerificationAt,
//     this.createdAt,
//     this.updatedAt,
//     this.docIdNumber,
//     this.validFrom,
//     this.validTill,
//     this.fileName,
//     this.localFiles,
//   });

//   factory IdentityProof.fromJson(Map<String, dynamic> json) => IdentityProof(
//         canUpload: json["can_upload"],
//         status: json["status"],
//         docType: json["doc_type"],
//         viewComment: json["view_comment"],
//         files: json["files"] == null
//             ? []
//             : List<FileElement>.from(
//                 json["files"]!.map((x) => FileElement.fromJson(x))),
//         id: json["_id"],
//         lastUploadAt: json["last_upload_at"] == null
//             ? null
//             : DateTime.parse(json["last_upload_at"]),
//         lastVerificationAt: json["last_verification_at"] == null
//             ? null
//             : DateTime.parse(json["last_verification_at"]),
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         docIdNumber: json["doc_id_number"],
//         validFrom: json["valid_from"] == null
//             ? null
//             : DateTime.parse(json["valid_from"]),
//         validTill: json["valid_till"] == null
//             ? null
//             : DateTime.parse(json["valid_till"]),
//         fileName: json["file_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "can_upload": canUpload,
//         "status": status,
//         "doc_type": docType,
//         "view_comment": viewComment,
//         "files": files == null
//             ? []
//             : List<dynamic>.from(files!.map((x) => x.toJson())),
//         "_id": id,
//         "last_upload_at": lastUploadAt?.toIso8601String(),
//         "last_verification_at": lastVerificationAt?.toIso8601String(),
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "doc_id_number": docIdNumber,
//         "valid_from": validFrom?.toIso8601String(),
//         "valid_till": validTill?.toIso8601String(),
//         "file_name": fileName,
//       };

//   IdentityProof copyWith({
//     String? canUpload,
//     String? status,
//     String? docType,
//     String? viewComment,
//     List<FileElement>? files,
//     String? id,
//     DateTime? lastUploadAt,
//     DateTime? lastVerificationAt,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     String? docIdNumber,
//     DateTime? validFrom,
//     DateTime? validTill,
//     String? fileName,
//     List<XFile?>? localFiles,
//   }) {
//     return IdentityProof(
//       canUpload: canUpload ?? this.canUpload,
//       status: status ?? this.status,
//       docType: docType ?? this.docType,
//       viewComment: viewComment ?? this.viewComment,
//       files: files ?? this.files,
//       id: id ?? this.id,
//       lastUploadAt: lastUploadAt ?? this.lastUploadAt,
//       lastVerificationAt: lastVerificationAt ?? this.lastVerificationAt,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       docIdNumber: docIdNumber ?? this.docIdNumber,
//       validFrom: validFrom ?? this.validFrom,
//       validTill: validTill ?? this.validTill,
//       fileName: fileName ?? this.fileName,
//       localFiles: localFiles ?? this.localFiles,
//     );
//   }
// }

class FileElement {
  final String? fileName;
  final String? fileExtension;
  final String? fileStatus;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FileElement({
    this.fileName,
    this.fileExtension,
    this.fileStatus,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        fileName: json["file_name"],
        fileExtension: json["file_extension"],
        fileStatus: json["file_status"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "file_name": fileName,
        "file_extension": fileExtension,
        "file_status": fileStatus,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

// import 'dart:convert';

// import 'package:bctpay/models/provider_list_model.dart';

// KycDetailResponse kycDetailResponseFromJson(String str) =>
//     KycDetailResponse.fromJson(json.decode(str));

// String kycDetailResponseToJson(KycDetailResponse data) =>
//     json.encode(data.toJson());

// class KycDetailResponse {
//   final int code;
//   final KYCData? data;
//   final String message;
//   final bool? success;

//   KycDetailResponse({
//     required this.code,
//     required this.data,
//     required this.message,
//     required this.success,
//   });

//   factory KycDetailResponse.fromJson(Map<String, dynamic> json) =>
//       KycDetailResponse(
//         code: json["code"],
//         data: json["data"] == null ? null : KYCData.fromJson(json["data"]),
//         message: json["message"],
//         success: json["success"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "data": data?.toJson(),
//         "message": message,
//         "success": success,
//       };
// }

// class KYCData {
//   final String id;
//   final String customerId;
//   final String kycDocType;
//   final String kycIdNumber;
//   final String frontKycDocName;
//   final String? backKycDocName;
//   final String kycDocExtension;
//   final DateTime? validFrom;
//   final DateTime? validTill;
//   final String kycVerificationStep;
//   final KYCStatus? kycStatus;
//   final DateTime lastKycUploadAt;
//   final DateTime lastKycVerificationAt;
//   final String viewComment;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;
//   final String? verifiedByAdminEmail;
//   final String? verifiedByAdminId;
//   final String? verifiedByAdminName;
//   final String? verifiedByAdminRole;
//   final String? comments;
//   final String? canUploadKyc;

//   KYCData({
//     required this.id,
//     required this.customerId,
//     required this.kycDocType,
//     required this.kycIdNumber,
//     required this.frontKycDocName,
//     required this.backKycDocName,
//     required this.kycDocExtension,
//     required this.validFrom,
//     required this.validTill,
//     required this.kycVerificationStep,
//     required this.kycStatus,
//     required this.lastKycUploadAt,
//     required this.lastKycVerificationAt,
//     required this.viewComment,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.verifiedByAdminEmail,
//     required this.verifiedByAdminId,
//     required this.verifiedByAdminName,
//     required this.verifiedByAdminRole,
//     required this.comments,
//     required this.canUploadKyc,
//   });

//   factory KYCData.fromJson(Map<String, dynamic> json) => KYCData(
//         id: json["_id"],
//         customerId: json["customerId"],
//         kycDocType: json["kyc_doc_type"],
//         kycIdNumber: json["kyc_id_number"],
//         frontKycDocName: json["front_kyc_doc_name"],
//         backKycDocName: json["back_kyc_doc_name"],
//         kycDocExtension: json["kyc_doc_extension"],
//         validFrom: json["valid_from"] == null
//             ? null
//             : DateTime.tryParse(json["valid_from"]),
//         validTill: json["valid_till"] == null
//             ? null
//             : DateTime.tryParse(json["valid_till"]),
//         kycVerificationStep: json["kyc_verification_step"],
//         kycStatus: kycStatusValues.map[json["kyc_status"]],
//         lastKycUploadAt: DateTime.parse(json["last_kyc_upload_at"]),
//         lastKycVerificationAt: DateTime.parse(json["last_kyc_verification_at"]),
//         viewComment: json["view_comment"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         verifiedByAdminEmail: json["verified_by_admin_email"],
//         verifiedByAdminId: json["verified_by_admin_id"],
//         verifiedByAdminName: json["verified_by_admin_name"],
//         verifiedByAdminRole: json["verified_by_admin_role"],
//         comments: json["comments"],
//         canUploadKyc: json["can_upload_kyc"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "customerId": customerId,
//         "kyc_doc_type": kycDocType,
//         "kyc_id_number": kycIdNumber,
//         "front_kyc_doc_name": frontKycDocName,
//         "back_kyc_doc_name": backKycDocName,
//         "kyc_doc_extension": kycDocExtension,
//         "valid_from": validFrom?.toIso8601String,
//         "valid_till": validTill?.toIso8601String,
//         "kyc_verification_step": kycVerificationStep,
//         "kyc_status": kycStatusValues.reverse[kycStatus],
//         "last_kyc_upload_at": lastKycUploadAt.toIso8601String(),
//         "last_kyc_verification_at": lastKycVerificationAt.toIso8601String(),
//         "view_comment": viewComment,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "verified_by_admin_email": verifiedByAdminEmail,
//         "verified_by_admin_id": verifiedByAdminId,
//         "verified_by_admin_name": verifiedByAdminName,
//         "verified_by_admin_role": verifiedByAdminRole,
//         "comments": comments,
//         "can_upload_kyc": canUploadKyc,
//       };
// }

enum KYCStatus {
  uploaded,
  underReview,
  pending,
  approved,
  rejected,
  updated,
  suspended,
  expired
}

final kycStatusValues = EnumValues({
  "Uploaded": KYCStatus.uploaded,
  "Under Review": KYCStatus.underReview,
  "Pending": KYCStatus.pending,
  "Approved": KYCStatus.approved,
  "Rejected": KYCStatus.rejected,
  "Updated": KYCStatus.updated,
  "Suspended": KYCStatus.suspended,
  "Expired": KYCStatus.expired,
});

extension StatusExt on KYCStatus {
  static const Map<KYCStatus, String> keys = {
    KYCStatus.uploaded: 'Uploaded',
    KYCStatus.underReview: 'UnderReview',
    KYCStatus.pending: 'Pending',
    KYCStatus.approved: 'Approved',
    KYCStatus.rejected: 'Rejected',
    KYCStatus.updated: 'Updated',
    KYCStatus.suspended: 'Suspended',
    KYCStatus.expired: 'Expired',
  };

  static const Map<KYCStatus, String> values = {
    KYCStatus.uploaded: 'Uploaded',
    KYCStatus.underReview: 'Under Review',
    KYCStatus.pending: 'Pending',
    KYCStatus.approved: 'Approved',
    KYCStatus.rejected: 'Rejected',
    KYCStatus.updated: 'Updated',
    KYCStatus.suspended: 'Suspended',
    KYCStatus.expired: 'Expired',
  };

  String? get key => keys[this];
  String? get value => values[this];

  // NEW
  static KYCStatus? fromRaw(String raw) => keys.entries
      .firstWhere((e) => e.value == raw,
          orElse: () => {KYCStatus.pending: "Pending"}.entries.first)
      .key;
}
