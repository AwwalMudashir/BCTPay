import 'package:bctpay/globals/index.dart';

class ProfileResponse {
  final int code;
  final Customer? data;
  final String message;
  final bool? success;

  ProfileResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : Customer.fromJson(jsonDecode(decrypt(json["data"]))),
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

class Customer {
  final String? id;
  final String? customerId;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? emailVerificationCode;
  final String? emailVerifyStatus;
  final String? emailOtp;
  final String? mobileOtp;
  final String? phonenumber;
  final String? phoneCode;
  final String? kycStatus;
  final String? state;
  final String? country;
  final String? countryId;
  final String? password;
  final String? profileComplete;
  final String? profilePic;
  final String? profileStatus;
  final String? customerStatus;
  final DateTime? registrationDate;
  final String? role;
  final String? registeredBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  // final WalletId walletId;
  final String? costomerqrCode;
  final String? token;
  final String? city;
  final String? line1;
  final String? line2;
  final String? postalcode;
  final String? kongCustomerKey;
  final String? kongCustomerSecret;
  final String? gender;
  final String? profileLink;

  ///merchant data
  final String? countryflag;
  final String? businessCategoryName;
  final String? companyLogo;
  final String? adminLogoForDarkTheme;
  final String? adminLogoForWhiteTheme;

  Customer({
    required this.id,
    this.customerId,
    this.firstname,
    this.lastname,
    this.email,
    this.emailVerificationCode,
    this.emailVerifyStatus,
    this.emailOtp,
    this.mobileOtp,
    this.phonenumber,
    this.phoneCode,
    this.kycStatus,
    this.state,
    this.country,
    this.countryId,
    this.password,
    this.profileComplete,
    this.profilePic,
    this.profileStatus,
    this.customerStatus,
    this.registrationDate,
    this.role,
    this.registeredBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    //  this.walletId,
    this.costomerqrCode,
    this.token,
    this.city,
    this.line1,
    this.line2,
    this.postalcode,
    this.kongCustomerKey,
    this.kongCustomerSecret,
    this.gender,
    this.profileLink,
    this.countryflag,
    this.businessCategoryName,
    this.companyLogo,
    this.adminLogoForDarkTheme,
    this.adminLogoForWhiteTheme,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        customerId: json["customerId"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        emailVerificationCode: json["email_verification_code"],
        emailVerifyStatus: json["email_verify_status"],
        emailOtp: json["email_otp"],
        mobileOtp: json["mobile_otp"],
        phonenumber: json["phonenumber"],
        phoneCode: json["phone_code"],
        kycStatus: json["kyc_status"],
        state: json["state"],
        country: json["country"],
        countryId: json["countryId"],
        password: json["password"],
        profileComplete: json["profile_complete"],
        profilePic: json["profile_pic"],
        profileStatus: json["profile_status"],
        customerStatus: json["customer_status"],
        registrationDate: json["registrationDate"] == null
            ? null
            : DateTime.tryParse(json["registrationDate"]),
        role: json["role"],
        registeredBy: json["registeredBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTimeHelper.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTimeHelper.tryParse(json["updatedAt"]),
        v: json["__v"],
        // walletId: WalletId.fromJson(json["WalletId"]),
        costomerqrCode: json["costomerqr_code"],
        token: json["token"],
        city: json["city"],
        line1: json["line1"],
        line2: json["line2"],
        postalcode: json["postalcode"],
        kongCustomerKey: json["kong_customer_key"],
        kongCustomerSecret: json["kong_customer_secret"],
        gender: json["gender"],
        profileLink: json["profile_link"],
        countryflag: json["countryflag"],
        businessCategoryName: json["business_category_name"],
        companyLogo: json["company_logo"],
        adminLogoForDarkTheme: json["adminLogoForDarkTheme"],
        adminLogoForWhiteTheme: json["adminLogoForWhiteTheme"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "email_verification_code": emailVerificationCode,
        "email_verify_status": emailVerifyStatus,
        "email_otp": emailOtp,
        "mobile_otp": mobileOtp,
        "phonenumber": phonenumber,
        "phone_code": phoneCode,
        "kyc_status": kycStatus,
        "state": state,
        "country": country,
        "countryId": countryId,
        "password": password,
        "profile_complete": profileComplete,
        "profile_pic": profilePic,
        "profile_status": profileStatus,
        "customer_status": customerStatus,
        "registrationDate": registrationDate?.toIso8601String(),
        "role": role,
        "registeredBy": registeredBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        // "WalletId": walletId.toJson(),
        "costomerqr_code": costomerqrCode,
        "token": token,
        "city": city,
        "line1": line1,
        "line2": line2,
        "postalcode": postalcode,
        "kong_customer_key": kongCustomerKey,
        "kong_customer_secret": kongCustomerSecret,
        "gender": gender,
        "profile_link": profileLink,
        "countryflag": countryflag,
        "business_category_name": businessCategoryName,
        "company_logo": companyLogo,
        "adminLogoForDarkTheme": adminLogoForDarkTheme,
        "adminLogoForWhiteTheme": adminLogoForWhiteTheme,
      };
}

class WalletId {
  final String id;
  final String customerId;
  final String btcwalletId;
  final String walletStatus;
  final String walletBalance;
  final String walletPass;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  WalletId({
    required this.id,
    required this.customerId,
    required this.btcwalletId,
    required this.walletStatus,
    required this.walletBalance,
    required this.walletPass,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory WalletId.fromJson(Map<String, dynamic> json) => WalletId(
        id: json["_id"],
        customerId: json["customerId"],
        btcwalletId: json["btcwalletID"],
        walletStatus: json["wallet_status"],
        walletBalance: json["wallet_balance"],
        walletPass: json["wallet_pass"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "btcwalletID": btcwalletId,
        "wallet_status": walletStatus,
        "wallet_balance": walletBalance,
        "wallet_pass": walletPass,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
