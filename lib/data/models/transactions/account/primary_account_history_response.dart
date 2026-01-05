// To parse this JSON data, do
//
//     final primaryAccountHistoryResponse = primaryAccountHistoryResponseFromJson(jsonString);

import 'dart:convert';

PrimaryAccountHistoryResponse primaryAccountHistoryResponseFromJson(
        String str) =>
    PrimaryAccountHistoryResponse.fromJson(json.decode(str));

String primaryAccountHistoryResponseToJson(
        PrimaryAccountHistoryResponse data) =>
    json.encode(data.toJson());

class PrimaryAccountHistoryResponse {
  final int? code;
  final Data? data;
  final String? message;
  final bool? success;

  PrimaryAccountHistoryResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  factory PrimaryAccountHistoryResponse.fromJson(Map<String, dynamic> json) =>
      PrimaryAccountHistoryResponse(
        code: json["code"],
        data: (json["data"] == null || json["data"] is List)
            ? null
            : Data.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "message": message,
        "success": success,
      };
}

class Data {
  final List<PrimaryAcoountList>? primaryAcoountList;
  final int? primaryAcoount;

  Data({
    this.primaryAcoountList,
    this.primaryAcoount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        primaryAcoountList: json["PrimaryAcoountList"] == null
            ? []
            : List<PrimaryAcoountList>.from(json["PrimaryAcoountList"]!
                .map((x) => PrimaryAcoountList.fromJson(x))),
        primaryAcoount: json["PrimaryAcoount"],
      );

  Map<String, dynamic> toJson() => {
        "PrimaryAcoountList": primaryAcoountList == null
            ? []
            : List<dynamic>.from(primaryAcoountList!.map((x) => x.toJson())),
        "PrimaryAcoount": primaryAcoount,
      };
}

class PrimaryAcoountList {
  final String? id;
  final String? adminId;
  final String? customerId;
  final String? beneficiaryName;
  final String? institutionName;
  final String? accountNo;
  final String? previousInstitutionName;
  final String? previousAccountNo;
  final String? previousBeneficiaryName;
  final String? previousAccountType;
  final String? accountType;
  final String? verifyStatus;
  final String? accountStatus;
  final String? primaryAccount;
  final String? updatedbyUserName;
  final String? updatedbyUserEmail;
  final String? updatedbyUserProfilePic;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  PrimaryAcoountList({
    this.id,
    this.adminId,
    this.customerId,
    this.beneficiaryName,
    this.institutionName,
    this.accountNo,
    this.previousInstitutionName,
    this.previousAccountNo,
    this.previousBeneficiaryName,
    this.previousAccountType,
    this.accountType,
    this.verifyStatus,
    this.accountStatus,
    this.primaryAccount,
    this.updatedbyUserName,
    this.updatedbyUserEmail,
    this.updatedbyUserProfilePic,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PrimaryAcoountList.fromJson(Map<String, dynamic> json) =>
      PrimaryAcoountList(
        id: json["_id"],
        adminId: json["adminId"],
        customerId: json["customerId"],
        beneficiaryName: json["beneficiary_name"],
        institutionName: json["institution_name"],
        accountNo: json["account_no"],
        previousInstitutionName: json["previous_institution_name"],
        previousAccountNo: json["previous_account_no"],
        previousBeneficiaryName: json["previous_beneficiary_name"],
        previousAccountType: json["previous_account_type"],
        accountType: json["account_type"],
        verifyStatus: json["verify_status"],
        accountStatus: json["account_status"],
        primaryAccount: json["primary_account"],
        updatedbyUserName: json["updatedby_user_name"],
        updatedbyUserEmail: json["updatedby_user_email"],
        updatedbyUserProfilePic: json["updatedby_user_profile_pic"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "customerId": customerId,
        "beneficiary_name": beneficiaryName,
        "institution_name": institutionName,
        "account_no": accountNo,
        "previous_institution_name": previousInstitutionName,
        "previous_account_no": previousAccountNo,
        "previous_beneficiary_name": previousBeneficiaryName,
        "previous_account_type": previousAccountType,
        "account_type": accountType,
        "verify_status": verifyStatus,
        "account_status": accountStatus,
        "primary_account": primaryAccount,
        "updatedby_user_name": updatedbyUserName,
        "updatedby_user_email": updatedbyUserEmail,
        "updatedby_user_profile_pic": updatedbyUserProfilePic,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
