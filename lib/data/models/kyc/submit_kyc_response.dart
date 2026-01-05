class SubmitKYCResponse {
  final int code;
  // final KycList? data;
  final String message;
  final bool? success;

  SubmitKYCResponse({
    required this.code,
    // required this.data,
    required this.message,
    required this.success,
  });

  factory SubmitKYCResponse.fromJson(Map<String, dynamic> json) =>
      SubmitKYCResponse(
        code: json["code"],
        // data: json["data"] == null ? null : KycList.fromJson(json["data"]),
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

// class UserProfileData {
//   final String? mobileOtp;
//   final String? profilePic;
//   final String id;
//   final String customerId;
//   final String? email;
//   final String emailVerificationCode;
//   final String emailVerifyStatus;
//   final String phonenumber;
//   final String password;
//   final String profileComplete;
//   final String profileStatus;
//   final DateTime registrationDate;
//   final String registeredBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;
//   final String costomerqrCode;
//   final String token;
//   final String firstname;
//   final String city;
//   final String country;
//   final String line1;
//   final String postalcode;
//   final String? walletId;
//   final String emailOtp;
//   final String customerStatus;

//   UserProfileData({
//     required this.mobileOtp,
//     required this.profilePic,
//     required this.id,
//     required this.customerId,
//     required this.email,
//     required this.emailVerificationCode,
//     required this.emailVerifyStatus,
//     required this.phonenumber,
//     required this.password,
//     required this.profileComplete,
//     required this.profileStatus,
//     required this.registrationDate,
//     required this.registeredBy,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.costomerqrCode,
//     required this.token,
//     required this.firstname,
//     required this.city,
//     required this.country,
//     required this.line1,
//     required this.postalcode,
//     required this.walletId,
//     required this.emailOtp,
//     required this.customerStatus,
//   });

//   factory UserProfileData.fromJson(Map<String, dynamic> json) =>
//       UserProfileData(
//         mobileOtp: json["mobile_otp"],
//         profilePic: json["profile_pic"],
//         id: json["_id"],
//         customerId: json["customerId"],
//         email: json["email"],
//         emailVerificationCode: json["email_verification_code"],
//         emailVerifyStatus: json["email_verify_status"],
//         phonenumber: json["phonenumber"],
//         password: json["password"],
//         profileComplete: json["profile_complete"],
//         profileStatus: json["profile_status"],
//         registrationDate: DateTime.parse(json["registrationDate"]),
//         registeredBy: json["registeredBy"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         costomerqrCode: json["costomerqr_code"],
//         token: json["token"],
//         firstname: json["firstname"],
//         city: json["city"],
//         country: json["country"],
//         line1: json["line1"],
//         postalcode: json["postalcode"],
//         walletId: json["WalletId"],
//         emailOtp: json["email_otp"],
//         customerStatus: json["customer_status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "mobile_otp": mobileOtp,
//         "profile_pic": profilePic,
//         "_id": id,
//         "customerId": customerId,
//         "email": email,
//         "email_verification_code": emailVerificationCode,
//         "email_verify_status": emailVerifyStatus,
//         "phonenumber": phonenumber,
//         "password": password,
//         "profile_complete": profileComplete,
//         "profile_status": profileStatus,
//         "registrationDate": registrationDate.toIso8601String(),
//         "registeredBy": registeredBy,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "costomerqr_code": costomerqrCode,
//         "token": token,
//         "firstname": firstname,
//         "city": city,
//         "country": country,
//         "line1": line1,
//         "postalcode": postalcode,
//         "WalletId": walletId,
//         "email_otp": emailOtp,
//         "customer_status": customerStatus,
//       };
// }
