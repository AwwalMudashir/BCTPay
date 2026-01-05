class GetAccountLookupResponse {
  final int code;
  final AccountLookupData? data;
  final String message;
  final bool? success;

  GetAccountLookupResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetAccountLookupResponse.fromJson(Map<String, dynamic> json) =>
      GetAccountLookupResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : AccountLookupData.fromJson(json["data"]),
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

class AccountLookupData {
  final String? countryIso;
  final String? accountNumberNormalized;
  final List<AccountLookupListItem> items;
  final int resultCode;
  final List<dynamic> errorCodes;

  AccountLookupData({
    required this.countryIso,
    required this.accountNumberNormalized,
    required this.items,
    required this.resultCode,
    required this.errorCodes,
  });

  factory AccountLookupData.fromJson(Map<String, dynamic> json) =>
      AccountLookupData(
        countryIso: json["CountryIso"],
        accountNumberNormalized: json["AccountNumberNormalized"],
        items: json["Items"] == null
            ? []
            : List<AccountLookupListItem>.from(
                json["Items"].map((x) => AccountLookupListItem.fromJson(x))),
        resultCode: json["ResultCode"],
        errorCodes: List<dynamic>.from(json["ErrorCodes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "CountryIso": countryIso,
        "AccountNumberNormalized": accountNumberNormalized,
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
        "ResultCode": resultCode,
        "ErrorCodes": List<dynamic>.from(errorCodes.map((x) => x)),
      };
}

class AccountLookupListItem {
  final String providerCode;
  final String regionCode;

  AccountLookupListItem({
    required this.providerCode,
    required this.regionCode,
  });

  factory AccountLookupListItem.fromJson(Map<String, dynamic> json) =>
      AccountLookupListItem(
        providerCode: json["ProviderCode"],
        regionCode: json["RegionCode"],
      );

  Map<String, dynamic> toJson() => {
        "ProviderCode": providerCode,
        "RegionCode": regionCode,
      };
}
