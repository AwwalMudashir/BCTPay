class ChangePasswordResponse {
  final int code;
  // final Data? data;
  final String message;
  final bool? success;

  ChangePasswordResponse({
    required this.code,
    // required this.data,
    required this.message,
    required this.success,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponse(
        code: json["code"],
        // data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        // "data": data?.toJson(),
        "message": message,
        "success": success,
      };
}

// class Data {
//   final String id;
//   final String customerId;
//   final String firstname;
//   final String email;
//   final String emailVerificationCode;
//   final String emailVerifyStatus;
//   final String emailOtp;
//   final String mobileOtp;
//   final String phonenumber;
//   final String line1;
//   final String postalcode;
//   final String city;
//   final String? state;
//   final String country;
//   final String password;
//   final String profileComplete;
//   final String profilePic;
//   final String profileStatus;
//   final String customerStatus;
//   final DateTime registrationDate;
//   final String registeredBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;
//   final String walletId;
//   final String costomerqrCode;
//   final String token;
//   final String kycStatus;

//   Data({
//     required this.id,
//     required this.customerId,
//     required this.firstname,
//     required this.email,
//     required this.emailVerificationCode,
//     required this.emailVerifyStatus,
//     required this.emailOtp,
//     required this.mobileOtp,
//     required this.phonenumber,
//     required this.line1,
//     required this.postalcode,
//     required this.city,
//     required this.state,
//     required this.country,
//     required this.password,
//     required this.profileComplete,
//     required this.profilePic,
//     required this.profileStatus,
//     required this.customerStatus,
//     required this.registrationDate,
//     required this.registeredBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.walletId,
//     required this.costomerqrCode,
//     required this.token,
//     required this.kycStatus,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["_id"],
//         customerId: json["customerId"],
//         firstname: json["firstname"],
//         email: json["email"],
//         emailVerificationCode: json["email_verification_code"],
//         emailVerifyStatus: json["email_verify_status"],
//         emailOtp: json["email_otp"],
//         mobileOtp: json["mobile_otp"],
//         phonenumber: json["phonenumber"],
//         line1: json["line1"],
//         postalcode: json["postalcode"],
//         city: json["city"],
//         state: json["state"],
//         country: json["country"],
//         password: json["password"],
//         profileComplete: json["profile_complete"],
//         profilePic: json["profile_pic"],
//         profileStatus: json["profile_status"],
//         customerStatus: json["customer_status"],
//         registrationDate: DateTime.parse(json["registrationDate"]),
//         registeredBy: json["registeredBy"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         walletId: json["WalletId"],
//         costomerqrCode: json["costomerqr_code"],
//         token: json["token"],
//         kycStatus: json["kyc_status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "customerId": customerId,
//         "firstname": firstname,
//         "email": email,
//         "email_verification_code": emailVerificationCode,
//         "email_verify_status": emailVerifyStatus,
//         "email_otp": emailOtp,
//         "mobile_otp": mobileOtp,
//         "phonenumber": phonenumber,
//         "line1": line1,
//         "postalcode": postalcode,
//         "city": city,
//         "state": state,
//         "country": country,
//         "password": password,
//         "profile_complete": profileComplete,
//         "profile_pic": profilePic,
//         "profile_status": profileStatus,
//         "customer_status": customerStatus,
//         "registrationDate": registrationDate.toIso8601String(),
//         "registeredBy": registeredBy,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "WalletId": walletId,
//         "costomerqr_code": costomerqrCode,
//         "token": token,
//         "kyc_status": kycStatus,
//       };
// }
