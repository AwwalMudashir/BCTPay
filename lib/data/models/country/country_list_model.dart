class CountryListResponse {
  final int? code;
  final List<CountryData>? data;
  final String? message;
  final bool? success;
  final String? error;

  CountryListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
    required this.error,
  });

  factory CountryListResponse.fromJson(Map<String, dynamic> json) =>
      CountryListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<CountryData>.from(
                json["data"].map((x) => CountryData.fromJson(x))),
        message: json["message"],
        success: json["success"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
        "error": error,
      };
}

class CountryData {
  final String id;
  final String adminId;
  final String countryName;
  final String countryCode;
  final String countryFlag;
  final String? phoneCode;
  final String? currencyName;
  final String currencyCode;
  final String currencySymbol;
  final String timeZone;
  final String status;
  final String writePermission;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  CountryData({
    required this.id,
    required this.adminId,
    required this.countryName,
    required this.countryCode,
    required this.countryFlag,
    required this.phoneCode,
    required this.currencyName,
    required this.currencyCode,
    required this.currencySymbol,
    required this.timeZone,
    required this.status,
    required this.writePermission,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        id: json["_id"],
        adminId: json["adminId"],
        countryName: json["country_name"],
        countryCode: json["country_code"],
        countryFlag: json["country_flag"],
        phoneCode: json["phone_code"],
        currencyName: json["currency_name"],
        currencyCode: json["currency_code"],
        currencySymbol: json["currency_symbol"],
        timeZone: json["time_zone"],
        status: json["status"],
        writePermission: json["write_permission"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "country_name": countryName,
        "country_code": countryCode,
        "country_flag": countryFlag,
        "phone_code": phoneCode,
        "currency_name": currencyName,
        "currency_code": currencyCode,
        "currency_symbol": currencySymbol,
        "time_zone": timeZone,
        "status": status,
        "write_permission": writePermission,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

// class CountryListResponse {
//   final int code;
//   final CountryListData data;
//   final String message;
//   final bool success;

//   CountryListResponse({
//     required this.code,
//     required this.data,
//     required this.message,
//     required this.success,
//   });

//   factory CountryListResponse.fromJson(Map<String, dynamic> json) =>
//       CountryListResponse(
//         code: json["code"],
//         data: CountryListData.fromJson(json["data"]),
//         message: json["message"],
//         success: json["success"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "data": data.toJson(),
//         "message": message,
//         "success": success,
//       };
// }

// class CountryListData {
//   final int resultCode;
//   final List<dynamic> errorCodes;
//   final List<CountryData> items;

//   CountryListData({
//     required this.resultCode,
//     required this.errorCodes,
//     required this.items,
//   });

//   factory CountryListData.fromJson(Map<String, dynamic> json) =>
//       CountryListData(
//         resultCode: json["ResultCode"],
//         errorCodes: List<dynamic>.from(json["ErrorCodes"].map((x) => x)),
//         items: List<CountryData>.from(
//             json["Items"].map((x) => CountryData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "ResultCode": resultCode,
//         "ErrorCodes": List<dynamic>.from(errorCodes.map((x) => x)),
//         "Items": List<dynamic>.from(items.map((x) => x.toJson())),
//       };
// }

// class CountryData {
//   final String countryIso;
//   final String countryName;
//   final List<InternationalDialingInformation> internationalDialingInformation;
//   final List<String> regionCodes;

//   CountryData({
//     required this.countryIso,
//     required this.countryName,
//     required this.internationalDialingInformation,
//     required this.regionCodes,
//   });

//   factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
//         countryIso: json["CountryIso"],
//         countryName: json["CountryName"],
//         internationalDialingInformation:
//             List<InternationalDialingInformation>.from(
//                 json["InternationalDialingInformation"]
//                     .map((x) => InternationalDialingInformation.fromJson(x))),
//         regionCodes: List<String>.from(json["RegionCodes"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "CountryIso": countryIso,
//         "CountryName": countryName,
//         "InternationalDialingInformation": List<dynamic>.from(
//             internationalDialingInformation.map((x) => x.toJson())),
//         "RegionCodes": List<dynamic>.from(regionCodes.map((x) => x)),
//       };
// }

// class InternationalDialingInformation {
//   final String prefix;
//   final int minimumLength;
//   final int maximumLength;

//   InternationalDialingInformation({
//     required this.prefix,
//     required this.minimumLength,
//     required this.maximumLength,
//   });

//   factory InternationalDialingInformation.fromJson(Map<String, dynamic> json) =>
//       InternationalDialingInformation(
//         prefix: json["Prefix"],
//         minimumLength: json["MinimumLength"],
//         maximumLength: json["MaximumLength"],
//       );

//   Map<String, dynamic> toJson() => {
//         "Prefix": prefix,
//         "MinimumLength": minimumLength,
//         "MaximumLength": maximumLength,
//       };
// }
