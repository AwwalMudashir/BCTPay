import 'package:bctpay/lib.dart';

class SetActiveAccountResponse {
  final int code;
  final ActiveAccountData? data;
  final String message;
  final bool? success;

  SetActiveAccountResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory SetActiveAccountResponse.fromJson(Map<String, dynamic> json) =>
      SetActiveAccountResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : ActiveAccountData.fromJson(json["data"]),
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

class ActiveAccountData {
  final String id;
  final String customerId;
  final String accountNo;
  final String accountType;
  final String verifyStatus;
  final String accountStatus;
  final String primaryAccount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final String beneficiaryName;

  ActiveAccountData({
    required this.id,
    required this.customerId,
    required this.accountNo,
    required this.accountType,
    required this.verifyStatus,
    required this.accountStatus,
    required this.primaryAccount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.beneficiaryName,
  });

  factory ActiveAccountData.fromJson(Map<String, dynamic> json) =>
      ActiveAccountData(
        id: json["_id"],
        customerId: json["customerId"],
        accountNo: json["account_no"],
        accountType: json["account_type"],
        verifyStatus: json["verify_status"],
        accountStatus: json["account_status"],
        primaryAccount: json["primary_account"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTimeHelper.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTimeHelper.tryParse(json["updatedAt"]),
        v: json["__v"],
        beneficiaryName: json["beneficiary_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "account_no": accountNo,
        "account_type": accountType,
        "verify_status": verifyStatus,
        "account_status": accountStatus,
        "primary_account": primaryAccount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "beneficiary_name": beneficiaryName,
      };
}
