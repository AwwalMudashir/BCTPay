class CurrencyListResponse {
  final int code;
  final CurrencyListData? data;
  final String message;
  final bool? success;

  CurrencyListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory CurrencyListResponse.fromJson(Map<String, dynamic> json) =>
      CurrencyListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : CurrencyListData.fromJson(json["data"]),
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

class CurrencyListData {
  final int resultCode;
  final List<dynamic> errorCodes;
  final List<CurrencyListItem> items;

  CurrencyListData({
    required this.resultCode,
    required this.errorCodes,
    required this.items,
  });

  factory CurrencyListData.fromJson(Map<String, dynamic> json) =>
      CurrencyListData(
        resultCode: json["ResultCode"],
        errorCodes: List<dynamic>.from(json["ErrorCodes"].map((x) => x)),
        items: List<CurrencyListItem>.from(
            json["Items"].map((x) => CurrencyListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResultCode": resultCode,
        "ErrorCodes": List<dynamic>.from(errorCodes.map((x) => x)),
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class CurrencyListItem {
  final String currencyIso;
  final String currencyName;

  CurrencyListItem({
    required this.currencyIso,
    required this.currencyName,
  });

  factory CurrencyListItem.fromJson(Map<String, dynamic> json) =>
      CurrencyListItem(
        currencyIso: json["CurrencyIso"],
        currencyName: json["CurrencyName"],
      );

  Map<String, dynamic> toJson() => {
        "CurrencyIso": currencyIso,
        "CurrencyName": currencyName,
      };
}
