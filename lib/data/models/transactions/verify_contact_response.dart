import 'package:bctpay/globals/index.dart';

class VerifyContactResponse {
  final int code;
  final VerifyContactData? data;
  final String message;
  final bool? success;

  VerifyContactResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory VerifyContactResponse.fromJson(Map<String, dynamic> json) =>
      VerifyContactResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : VerifyContactData.fromMap(json["data"]),
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

class VerifyContactData {
  final String? userType;
  final BankAccount? bankInfo;

  VerifyContactData({required this.userType, required this.bankInfo});

  Map<String, dynamic> toMap() {
    return {
      'user_type': userType,
      'bank_info': bankInfo?.toJson(),
    };
  }

  factory VerifyContactData.fromMap(Map<String, dynamic> map) {
    return VerifyContactData(
      userType: map['user_type'],
      bankInfo: map['bank_info'] != null
          ? BankAccount.fromJson(map['bank_info'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyContactData.fromJson(String source) =>
      VerifyContactData.fromMap(json.decode(source));
}
