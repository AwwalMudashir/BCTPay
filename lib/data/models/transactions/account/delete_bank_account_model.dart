import 'package:bctpay/globals/index.dart';

class DeleteBankAccountResponse {
  final int code;
  final BankAccount? data;
  final String message;
  final bool? success;

  DeleteBankAccountResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory DeleteBankAccountResponse.fromJson(Map<String, dynamic> json) =>
      DeleteBankAccountResponse(
        code: json["code"],
        data: json["data"] == null ? null : BankAccount.fromJson(json["data"]),
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
