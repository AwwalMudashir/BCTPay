import 'package:bctpay/globals/index.dart';

class DeleteBeneficiaryResponse {
  final int code;
  final BankAccount? data;
  final String message;
  final bool? success;

  DeleteBeneficiaryResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory DeleteBeneficiaryResponse.fromJson(Map<String, dynamic> json) =>
      DeleteBeneficiaryResponse(
        code: json["code"],
        data: json["data"] == null ? null : BankAccount.fromJson(json["data"]),
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

// class DeleteBeneficiaryData {
//   final String customerId;
//   final String accountType;
//   final String? accountNumber;
//   final String? accountId;
//   final String id;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   DeleteBeneficiaryData({
//     required this.customerId,
//     required this.accountType,
//     required this.accountNumber,
//     required this.accountId,
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory DeleteBeneficiaryData.fromJson(Map<String, dynamic> json) =>
//       DeleteBeneficiaryData(
//         customerId: json["customerId"],
//         accountType: json["accountType"],
//         accountNumber: json["accountNumber"],
//         accountId: json["accountId"],
//         id: json["_id"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "customerId": customerId,
//         "accountType": accountType,
//         "accountNumber": accountNumber,
//         "accountId": accountId,
//         "_id": id,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }
