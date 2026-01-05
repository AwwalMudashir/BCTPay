class CustomerSettingResponse {
  final int code;
  final SettingData? data;
  final String message;
  final bool? success;

  CustomerSettingResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory CustomerSettingResponse.fromJson(Map<String, dynamic> json) =>
      CustomerSettingResponse(
        code: json["code"],
        data: json["data"] == null ? null : SettingData.fromJson(json["data"]),
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

class SettingData {
  final String id;
  final String customerId;
  final String? language;
  final String currency;
  final String currencySymbol;
  final String themeColor;
  final String timezone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SettingData({
    required this.id,
    required this.customerId,
    required this.language,
    required this.currency,
    required this.currencySymbol,
    required this.themeColor,
    required this.timezone,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SettingData.fromJson(Map<String, dynamic> json) => SettingData(
        id: json["_id"],
        customerId: json["customerId"],
        language: json["language"],
        currency: json["currency"],
        currencySymbol: json["currencySymbol"],
        themeColor: json["themeColor"],
        timezone: json["timezone"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "language": language,
        "currency": currency,
        "currencySymbol": currencySymbol,
        "themeColor": themeColor,
        "timezone": timezone,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
