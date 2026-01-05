class LoginResponse {
  final int? code;
  final LoginData? data;
  final String? message;
  final bool? success;
  final dynamic error;

  LoginResponse({
    required this.code,
    required this.data,
    required this.message,
    this.success,
    this.error,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        code: json["code"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "message": message,
        "success": success,
        "error": error,
      };
}

class LoginData {
  final String token;
  final String? kongServerToken;

  LoginData({
    required this.token,
    required this.kongServerToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
        kongServerToken: json["kong_server_token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "kong_server_token": kongServerToken,
      };
}
