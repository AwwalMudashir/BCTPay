class ProductStatusResponse {
  final int code;
  final ProductStatusData? data;
  final String message;
  final bool? success;

  ProductStatusResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ProductStatusResponse.fromJson(Map<String, dynamic> json) =>
      ProductStatusResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : ProductStatusData.fromJson(json["data"]),
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

class ProductStatusData {
  final int resultCode;
  final List<dynamic> errorCodes;
  final List<ProductStatusItem> items;

  ProductStatusData({
    required this.resultCode,
    required this.errorCodes,
    required this.items,
  });

  factory ProductStatusData.fromJson(Map<String, dynamic> json) =>
      ProductStatusData(
        resultCode: json["ResultCode"],
        errorCodes: List<dynamic>.from(json["ErrorCodes"].map((x) => x)),
        items: List<ProductStatusItem>.from(
            json["Items"].map((x) => ProductStatusItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResultCode": resultCode,
        "ErrorCodes": List<dynamic>.from(errorCodes.map((x) => x)),
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class ProductStatusItem {
  final String displayText;
  final String localizationKey;
  final String languageCode;

  ProductStatusItem({
    required this.displayText,
    required this.localizationKey,
    required this.languageCode,
  });

  factory ProductStatusItem.fromJson(Map<String, dynamic> json) =>
      ProductStatusItem(
        displayText: json["DisplayText"],
        localizationKey: json["LocalizationKey"],
        languageCode: json["LanguageCode"],
      );

  Map<String, dynamic> toJson() => {
        "DisplayText": displayText,
        "LocalizationKey": localizationKey,
        "LanguageCode": languageCode,
      };
}
