import 'package:bctpay/globals/index.dart';

class AddBankAccountResponse {
  final int code;
  final BankAccount? data;
  final String message;
  final bool? success;

  AddBankAccountResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory AddBankAccountResponse.fromJson(Map<String, dynamic> json) =>
      AddBankAccountResponse(
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
