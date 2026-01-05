class SignUpResponse {
  final int code;
  final SignUpData? data;
  final String message;
  final bool? success;

  SignUpResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        code: json["code"],
        data: json["data"] == null ? null : SignUpData.fromJson(json["data"]),
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

class SignUpData {
  final String? customerId;
  final String email;
  final String emailVerificationCode;
  final String emailVerifyStatus;
  final String phonenumber;
  final String password;
  final String profileComplete;
  final String profileStatus;
  final DateTime registrationDate;
  final String registeredBy;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SignUpData({
    required this.customerId,
    required this.email,
    required this.emailVerificationCode,
    required this.emailVerifyStatus,
    required this.phonenumber,
    required this.password,
    required this.profileComplete,
    required this.profileStatus,
    required this.registrationDate,
    required this.registeredBy,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
        customerId: json["customerId"],
        email: json["email"],
        emailVerificationCode: json["email_verification_code"],
        emailVerifyStatus: json["email_verify_status"],
        phonenumber: json["phonenumber"],
        password: json["password"],
        profileComplete: json["profile_complete"],
        profileStatus: json["profile_status"],
        registrationDate: DateTime.parse(json["registrationDate"]),
        registeredBy: json["registeredBy"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "email": email,
        "email_verification_code": emailVerificationCode,
        "email_verify_status": emailVerifyStatus,
        "phonenumber": phonenumber,
        "password": password,
        "profile_complete": profileComplete,
        "profile_status": profileStatus,
        "registrationDate": registrationDate.toIso8601String(),
        "registeredBy": registeredBy,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
