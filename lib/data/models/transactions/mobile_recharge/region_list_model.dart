class RegionListResponse {
  final int code;
  final RegionListData? data;
  final String? message;
  final bool? success;

  RegionListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory RegionListResponse.fromJson(Map<String, dynamic> json) =>
      RegionListResponse(
        code: json["code"],
        data:
            json["data"] == null ? null : RegionListData.fromJson(json["data"]),
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

class RegionListData {
  final int resultCode;
  final List<dynamic> errorCodes;
  final List<RegionListItem>? items;

  RegionListData({
    required this.resultCode,
    required this.errorCodes,
    required this.items,
  });

  factory RegionListData.fromJson(Map<String, dynamic> json) => RegionListData(
        resultCode: json["ResultCode"],
        errorCodes: List<dynamic>.from(json["ErrorCodes"].map((x) => x)),
        items: json["Items"] == null
            ? []
            : List<RegionListItem>.from(
                json["Items"].map((x) => RegionListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResultCode": resultCode,
        "ErrorCodes": List<dynamic>.from(errorCodes.map((x) => x)),
        "Items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class RegionListItem {
  final String regionCode;
  final String regionName;
  final String countryIso;

  RegionListItem({
    required this.regionCode,
    required this.regionName,
    required this.countryIso,
  });

  factory RegionListItem.fromJson(Map<String, dynamic> json) => RegionListItem(
        regionCode: json["RegionCode"],
        regionName: json["RegionName"],
        countryIso: json["CountryIso"],
      );

  Map<String, dynamic> toJson() => {
        "RegionCode": regionCode,
        "RegionName": regionName,
        "CountryIso": countryIso,
      };
}
