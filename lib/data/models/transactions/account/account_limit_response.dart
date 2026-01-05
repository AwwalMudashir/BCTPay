// To parse this JSON data, do
//
//     final accountLimitResponse = accountLimitResponseFromJson(jsonString);

import 'dart:convert';

AccountLimitResponse accountLimitResponseFromJson(String str) =>
    AccountLimitResponse.fromJson(json.decode(str));

String accountLimitResponseToJson(AccountLimitResponse data) =>
    json.encode(data.toJson());

class AccountLimitResponse {
  final int code;
  final AccountLimitData? data;
  final String message;
  final bool? success;

  AccountLimitResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory AccountLimitResponse.fromJson(Map<String, dynamic> json) =>
      AccountLimitResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : AccountLimitData.fromJson(json["data"]),
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

class AccountLimitData {
  final List<AccountPermission> accountPermissions;
  final List<TransactionLimit> transactionLimits;

  AccountLimitData({
    required this.accountPermissions,
    required this.transactionLimits,
  });

  factory AccountLimitData.fromJson(Map<String, dynamic> json) =>
      AccountLimitData(
        accountPermissions: List<AccountPermission>.from(
            json["accountPermissions"]
                .map((x) => AccountPermission.fromJson(x))),
        transactionLimits: List<TransactionLimit>.from(
            json["transactionLimits"].map((x) => TransactionLimit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "accountPermissions":
            List<dynamic>.from(accountPermissions.map((x) => x.toJson())),
        "transactionLimits":
            List<dynamic>.from(transactionLimits.map((x) => x.toJson())),
      };
}

class AccountPermission {
  final String id;
  final String accountType;
  final int totalAccountAllowed;
  final int totalSameAccountAllowed;

  AccountPermission({
    required this.id,
    required this.accountType,
    required this.totalAccountAllowed,
    required this.totalSameAccountAllowed,
  });

  factory AccountPermission.fromJson(Map<String, dynamic> json) =>
      AccountPermission(
        id: json["_id"],
        accountType: json["account_type"],
        totalAccountAllowed: json["total_account_allowed"],
        totalSameAccountAllowed: json["total_same_account_allowed"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "account_type": accountType,
        "total_account_allowed": totalAccountAllowed,
        "total_same_account_allowed": totalSameAccountAllowed,
      };
}

class TransactionLimit {
  final String id;
  final String serviceType;
  final int? perTrasactionAmount;
  final String miniValue;

  TransactionLimit({
    required this.id,
    required this.serviceType,
    required this.perTrasactionAmount,
    required this.miniValue,
  });

  factory TransactionLimit.fromJson(Map<String, dynamic> json) =>
      TransactionLimit(
        id: json["_id"],
        serviceType: json["service_type"],
        perTrasactionAmount: json["per_trasaction_amount"],
        miniValue: json["mini_value"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "service_type": serviceType,
        "per_trasaction_amount": perTrasactionAmount,
        "mini_value": miniValue,
      };
}
