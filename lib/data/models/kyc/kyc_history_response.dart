// To parse this JSON data, do
//
//     final kycHistoryResponse = kycHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:bctpay/data/models/kyc/get_kyc_detail_response.dart';

KycHistoryResponse kycHistoryResponseFromJson(String str) =>
    KycHistoryResponse.fromJson(json.decode(str));

String kycHistoryResponseToJson(KycHistoryResponse data) =>
    json.encode(data.toJson());

class KycHistoryResponse {
  final int code;
  final List<KycList>? data;
  final String message;
  final bool? success;

  KycHistoryResponse({
    required this.code,
    this.data,
    required this.message,
    this.success,
  });

  factory KycHistoryResponse.fromJson(Map<String, dynamic> json) =>
      KycHistoryResponse(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<KycList>.from(json["data"]!.map((x) => KycList.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class KycList {
  final String? id;
  final String? customerId;
  final String? userName;
  final DateTime? userDob;
  final KYCStatus? kycStatus;
  final KYCStatus? previousKycStatus;
  final KYCStatus? previewStutus;
  final KYCStatus? currentStatus;
  final String? commentsOn;
  final String? viewComment;
  final List<IdentityProof>? identityProof;
  final IdentityProof? photoProof;
  final List<IdentityProof>? addProof;
  final String? address;
  final String? state;
  final String? city;
  final String? zipCode;
  final String? email;
  final String? phoneNumber;
  final String? phoneCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  // final String? adminProfilePic;
  // final String? customerProfilePic;
  // final String? customerName;
  // final String? verifiedByAdminName;
  final Updatedby? createdBy;
  final Updatedby? updatedBy;
  final String? updatationType;
  final String? docType;

  KycList(
      {this.id,
      this.customerId,
      this.userName,
      this.userDob,
      this.kycStatus,
      this.previousKycStatus,
      this.previewStutus,
      this.currentStatus,
      this.commentsOn,
      this.viewComment,
      this.identityProof,
      this.photoProof,
      this.addProof,
      this.address,
      this.state,
      this.city,
      this.zipCode,
      this.email,
      this.phoneNumber,
      this.phoneCode,
      this.createdAt,
      this.updatedAt,
      this.v,
      // this.adminProfilePic,
      // this.customerProfilePic,
      // this.customerName,
      // this.verifiedByAdminName,
      this.createdBy,
      this.updatedBy,
      this.updatationType,
      this.docType});

  factory KycList.fromJson(Map<String, dynamic> json) => KycList(
        id: json["_id"],
        customerId: json["customerId"],
        userName: json["user_name"],
        userDob:
            json["user_dob"] == null ? null : DateTime.parse(json["user_dob"]),
        kycStatus: kycStatusValues.map[json["kyc_status"]],
        previousKycStatus: kycStatusValues.map[json["previous_kyc_status"]],
        previewStutus: kycStatusValues.map[json["preview_stutus"]],
        currentStatus: kycStatusValues.map[json["current_status"]],
        commentsOn: json["comments_on"],
        viewComment: json["view_comment"],
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
        address: json["address"],
        state: json["state"],
        city: json["city"],
        zipCode: json["zip_code"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        phoneCode: json["phone_code"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        createdBy: json["createdby"] == null
            ? null
            : Updatedby.fromJson(json["createdby"]),
        updatedBy: json["updatedby"] == null
            ? null
            : Updatedby.fromJson(json["updatedby"]),
        updatationType: json["updatation_type"],
        docType: json["doc_type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "user_name": userName,
        "user_dob": userDob?.toIso8601String(),
        "kyc_status": kycStatusValues.reverse[kycStatus],
        "previous_kyc_status": kycStatusValues.reverse[kycStatus],
        "preview_stutus": kycStatusValues.reverse[kycStatus],
        "current_status": kycStatusValues.reverse[kycStatus],
        "comments_on": commentsOn,
        "view_comment": viewComment,
        "identity_proof": identityProof == null
            ? []
            : List<dynamic>.from(identityProof!.map((x) => x.toJson())),
        "photo_proof": photoProof?.toJson(),
        "add_proof": addProof == null
            ? []
            : List<dynamic>.from(addProof!.map((x) => x.toJson())),
        "address": address,
        "state": state,
        "city": city,
        "zip_code": zipCode,
        "email": email,
        "phone_number": phoneNumber,
        "phone_code": phoneCode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "createdby": createdBy?.toJson(),
        "updatedby": updatedBy?.toJson(),
        "updatation_type": updatationType,
        "doc_type": docType,
      };
}

class Updatedby {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? role;
  final String? profilePic;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Updatedby({
    this.userId,
    this.fullName,
    this.email,
    this.role,
    this.profilePic,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Updatedby copyWith({
    String? userId,
    String? fullName,
    String? email,
    String? role,
    String? profilePic,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Updatedby(
        userId: userId ?? this.userId,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        role: role ?? this.role,
        profilePic: profilePic ?? this.profilePic,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Updatedby.fromJson(Map<String, dynamic> json) => Updatedby(
        userId: json["user_id"],
        fullName: json["full_name"],
        email: json["email"],
        role: json["role"],
        profilePic: json["profile_pic"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "email": email,
        "role": role,
        "profile_pic": profilePic,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

// class Proof {
//   final String? canUpload;
//   final String? status;
//   final String? docType;
//   final String? viewComment;
//   final List<FileElement>? files;
//   final DateTime? lastUploadAt;
//   final DateTime? lastVerificationAt;
//   final String? id;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? docIdNumber;
//   final DateTime? validFrom;
//   final DateTime? validTill;
//   final String? fileName;

//   Proof({
//     this.canUpload,
//     this.status,
//     this.docType,
//     this.viewComment,
//     this.files,
//     this.lastUploadAt,
//     this.lastVerificationAt,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.docIdNumber,
//     this.validFrom,
//     this.validTill,
//     this.fileName,
//   });

//   factory Proof.fromJson(Map<String, dynamic> json) => Proof(
//         canUpload: json["can_upload"],
//         status: json["status"],
//         docType: json["doc_type"],
//         viewComment: json["view_comment"],
//         files: json["files"] == null
//             ? []
//             : List<FileElement>.from(
//                 json["files"]!.map((x) => FileElement.fromJson(x))),
//         lastUploadAt: json["last_upload_at"] == null
//             ? null
//             : DateTime.parse(json["last_upload_at"]),
//         lastVerificationAt: json["last_verification_at"] == null
//             ? null
//             : DateTime.parse(json["last_verification_at"]),
//         id: json["_id"],
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
//         "last_upload_at": lastUploadAt?.toIso8601String(),
//         "last_verification_at": lastVerificationAt?.toIso8601String(),
//         "_id": id,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "doc_id_number": docIdNumber,
//         "valid_from": validFrom?.toIso8601String(),
//         "valid_till": validTill?.toIso8601String(),
//         "file_name": fileName,
//       };
// }

// class FileElement {
//   final String? fileName;
//   final String? fileExtension;
//   final String? fileStatus;
//   final String? id;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   FileElement({
//     this.fileName,
//     this.fileExtension,
//     this.fileStatus,
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
//         fileName: json["file_name"],
//         fileExtension: json["file_extension"],
//         fileStatus: json["file_status"],
//         id: json["_id"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "file_name": fileName,
//         "file_extension": fileExtension,
//         "file_status": fileStatus,
//         "_id": id,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };
// }

// import 'package:bctpay/models/get_kyc_detail_response.dart';

// class KycHistoryResponse {
//   final int code;
//   final KYCHistoryData? data;
//   final String message;
//   final bool? success;

//   KycHistoryResponse({
//     required this.code,
//     required this.data,
//     required this.message,
//     required this.success,
//   });

//   factory KycHistoryResponse.fromJson(Map<String, dynamic> json) =>
//       KycHistoryResponse(
//         code: json["code"],
//         data:
//             json["data"] == null ? null : KYCHistoryData.fromJson(json["data"]),
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

// class KYCHistoryData {
//   final List<KycList> kycList;
//   final int kycCount;

//   KYCHistoryData({
//     required this.kycList,
//     required this.kycCount,
//   });

//   factory KYCHistoryData.fromJson(Map<String, dynamic> json) => KYCHistoryData(
//         kycList:
//             List<KycList>.from(json["KycList"].map((x) => KycList.fromJson(x))),
//         kycCount: json["KycCount"],
//       );

//   Map<String, dynamic> toJson() => {
//         "KycList": List<dynamic>.from(kycList.map((x) => x.toJson())),
//         "KycCount": kycCount,
//       };
// }

// class KycList {
//   final String id;
//   final CustomerId customerId;
//   final String kycDocType;
//   final String kycIdNumber;
//   final String frontKycDocName;
//   final String? backKycDocName;
//   final String kycDocExtension;
//   final String kycVerificationStep;
//   final KYCStatus? previousKycStatus;
//   final KYCStatus? kycStatus;
//   final DateTime lastKycUploadAt;
//   final DateTime lastKycVerificationAt;
//   final String verifiedByAdminId;
//   final String verifiedByAdminName;
//   final String verifiedByAdminEmail;
//   final String verifiedByAdminRole;
//   final String? adminProfilePic;
//   final String comments;
//   final String viewComment;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   KycList({
//     required this.id,
//     required this.customerId,
//     required this.kycDocType,
//     required this.kycIdNumber,
//     required this.frontKycDocName,
//     required this.backKycDocName,
//     required this.kycDocExtension,
//     required this.kycVerificationStep,
//     required this.previousKycStatus,
//     required this.kycStatus,
//     required this.lastKycUploadAt,
//     required this.lastKycVerificationAt,
//     required this.verifiedByAdminId,
//     required this.verifiedByAdminName,
//     required this.verifiedByAdminEmail,
//     required this.verifiedByAdminRole,
//     required this.adminProfilePic,
//     required this.comments,
//     required this.viewComment,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory KycList.fromJson(Map<String, dynamic> json) => KycList(
//         id: json["_id"],
//         customerId: CustomerId.fromJson(json["customerId"]),
//         kycDocType: json["kyc_doc_type"],
//         kycIdNumber: json["kyc_id_number"],
//         frontKycDocName: json["front_kyc_doc_name"],
//         backKycDocName: json["back_kyc_doc_name"],
//         kycDocExtension: json["kyc_doc_extension"],
//         kycVerificationStep: json["kyc_verification_step"],
//         previousKycStatus: kycStatusValues.map[json["previous_kyc_status"]],
//         kycStatus: kycStatusValues.map[json["kyc_status"]],
//         lastKycUploadAt: DateTime.parse(json["last_kyc_upload_at"]),
//         lastKycVerificationAt: DateTime.parse(json["last_kyc_verification_at"]),
//         verifiedByAdminId: json["verified_by_admin_id"],
//         verifiedByAdminName: json["verified_by_admin_name"],
//         verifiedByAdminEmail: json["verified_by_admin_email"],
//         verifiedByAdminRole: json["verified_by_admin_role"],
//         adminProfilePic: json["admin_profile_pic"],
//         comments: json["comments"],
//         viewComment: json["view_comment"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "customerId": customerId.toJson(),
//         "kyc_doc_type": kycDocType,
//         "kyc_id_number": kycIdNumber,
//         "front_kyc_doc_name": frontKycDocName,
//         "back_kyc_doc_name": backKycDocName,
//         "kyc_doc_extension": kycDocExtension,
//         "kyc_verification_step": kycVerificationStep,
//         "previous_kyc_status": kycStatusValues.reverse[previousKycStatus],
//         "kyc_status": kycStatusValues.reverse[kycStatus],
//         "last_kyc_upload_at": lastKycUploadAt.toIso8601String(),
//         "last_kyc_verification_at": lastKycVerificationAt.toIso8601String(),
//         "verified_by_admin_id": verifiedByAdminId,
//         "verified_by_admin_name": verifiedByAdminName,
//         "verified_by_admin_email": verifiedByAdminEmail,
//         "verified_by_admin_role": verifiedByAdminRole,
//         "admin_profile_pic": adminProfilePic,
//         "comments": comments,
//         "view_comment": viewComment,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }

// class CustomerId {
//   final String id;
//   final String firstname;
//   final String email;
//   final String phonenumber;
//   final String profilePic;
//   final String? lastname;

//   CustomerId({
//     required this.id,
//     required this.firstname,
//     required this.email,
//     required this.phonenumber,
//     required this.profilePic,
//     required this.lastname,
//   });

//   factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
//         id: json["_id"],
//         firstname: json["firstname"],
//         email: json["email"],
//         phonenumber: json["phonenumber"],
//         profilePic: json["profile_pic"],
//         lastname: json["lastname"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "firstname": firstname,
//         "email": email,
//         "phonenumber": phonenumber,
//         "profile_pic": profilePic,
//         "lastname": lastname,
//       };
// }
