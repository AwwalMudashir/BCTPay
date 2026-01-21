class LoginResponse {
  final int? code;
  final String? codeString;
  final LoginData? data;
  final String? message;
  final bool? success;
  final dynamic error;

  LoginResponse({
    required this.code,
    required this.codeString,
    required this.data,
    required this.message,
    this.success,
    this.error,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final rawCode = json["code"];
    final codeStr = json["codeString"]?.toString() ?? rawCode?.toString();
    int? parsed;
    if (rawCode is int) {
      parsed = rawCode;
    } else if (rawCode is String) {
      parsed = int.tryParse(rawCode);
    }

    return LoginResponse(
      code: parsed,
      codeString: codeStr,
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
        error: json["error"],
      );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "codeString": codeString,
        "data": data?.toJson(),
        "message": message,
        "success": success,
        "error": error,
      };

  bool get isOk {
    final cStr = codeString ?? code?.toString();
    return cStr == "00" || cStr == "000" || cStr == "0" || code == 200 || code == 201;
  }
}

class LoginData {
  final String token;
  final String? kongServerToken;
  final String? username;
  final String? fullname;
  final String? email;
  final String? mobileNo;
  final String? userRole;
  final String? customerId;
  final String? country;
  final String? language;
  final String? lastLoginDate;
  final String? ccy;
  final String? partnerLink;
  final String? responseCode;
  final String? responseMessage;
  final String? gender;

  LoginData({
    required this.token,
    this.kongServerToken,
    this.username,
    this.fullname,
    this.email,
    this.mobileNo,
    this.userRole,
    this.customerId,
    this.country,
    this.language,
    this.lastLoginDate,
    this.ccy,
    this.partnerLink,
    this.responseCode,
    this.responseMessage,
    this.gender,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"] ?? "",
        kongServerToken: json["kong_server_token"],
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        userRole: json["userRole"],
        customerId: json["customerId"],
        country: json["country"],
        language: json["language"],
        lastLoginDate: json["lastLoginDate"],
        ccy: json["ccy"],
        partnerLink: json["partnerLink"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "kong_server_token": kongServerToken,
        "username": username,
        "fullname": fullname,
        "email": email,
        "mobileNo": mobileNo,
        "userRole": userRole,
        "customerId": customerId,
        "country": country,
        "language": language,
        "lastLoginDate": lastLoginDate,
        "ccy": ccy,
        "partnerLink": partnerLink,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "gender": gender,
      };
}
