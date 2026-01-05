import 'dart:convert';

import 'package:bctpay/data/models/transactions/account/bank_account_list_model.dart';

BeneficiaryListResponse beneficiaryListResponseFromJson(String str) =>
    BeneficiaryListResponse.fromJson(json.decode(str));

String beneficiaryListResponseToJson(BeneficiaryListResponse data) =>
    json.encode(data.toJson());

class BeneficiaryListResponse {
  final int code;
  final BeneficiaryData? data;
  final String message;
  final bool? success;

  BeneficiaryListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory BeneficiaryListResponse.fromJson(Map<String, dynamic> json) =>
      BeneficiaryListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : BeneficiaryData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data!.toJson(),
        "message": message,
        "success": success,
      };
}

class BeneficiaryData {
  final List<BankAccount> transactionlist;
  final int transactioncount;

  BeneficiaryData({
    required this.transactionlist,
    required this.transactioncount,
  });

  factory BeneficiaryData.fromJson(Map<String, dynamic> json) =>
      BeneficiaryData(
        transactionlist: List<BankAccount>.from(
            json["transactionlist"].map((x) => BankAccount.fromJson(x))),
        transactioncount: json["transactioncount"],
      );

  Map<String, dynamic> toJson() => {
        "transactionlist":
            List<dynamic>.from(transactionlist.map((x) => x.toJson())),
        "transactioncount": transactioncount,
      };
}

// class TransactionlistData {
//   final String id;
//   final String customerId;
//   final String accountType;
//   final String? mobileNumber;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;
//   final String? accountNumber;
//   final String? accountId;

//   TransactionlistData({
//     required this.id,
//     required this.customerId,
//     required this.accountType,
//     required this.mobileNumber,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.accountNumber,
//     required this.accountId,
//   });

//   factory TransactionlistData.fromJson(Map<String, dynamic> json) =>
//       TransactionlistData(
//         id: json["_id"],
//         customerId: json["customerId"],
//         accountType: json["account_type"],
//         mobileNumber: json["mobileNumber"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         accountNumber: json["account_no"],
//         accountId: json["accountId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "customerId": customerId,
//         "account_type": accountType,
//         "mobileNumber": mobileNumber,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "account_no": accountNumber,
//         "accountId": accountId,
//       };
// }
