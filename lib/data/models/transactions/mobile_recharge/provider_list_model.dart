import 'package:bctpay/lib.dart';

class ProviderListResponse {
  final int code;
  final ProviderListData? data;
  final String message;
  final bool? success;

  ProviderListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ProviderListResponse.fromJson(Map<String, dynamic> json) =>
      ProviderListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : ProviderListData.fromJson(json["data"]),
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

class ProviderListData {
  final int resultCode;
  final List<dynamic> errorCodes;
  final List<ProviderListItem> items;

  ProviderListData({
    required this.resultCode,
    required this.errorCodes,
    required this.items,
  });

  factory ProviderListData.fromJson(Map<String, dynamic> json) =>
      ProviderListData(
        resultCode: json["ResultCode"],
        errorCodes: List<dynamic>.from(json["ErrorCodes"].map((x) => x)),
        items: json["Items"] == null
            ? []
            : List<ProviderListItem>.from(
                json["Items"].map((x) => ProviderListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResultCode": resultCode,
        "ErrorCodes": List<dynamic>.from(errorCodes.map((x) => x)),
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class ProviderListItem {
  final String providerCode;
  final String countryIso;
  final String name;
  final String validationRegex;
  final String? customerCareNumber;
  final List<String> regionCodes;
  final List<RechargePaymentType> paymentTypes;
  final String? logoUrl;

  ProviderListItem({
    required this.providerCode,
    required this.countryIso,
    required this.name,
    required this.validationRegex,
    required this.customerCareNumber,
    required this.regionCodes,
    required this.paymentTypes,
    required this.logoUrl,
  });

  factory ProviderListItem.fromJson(Map<String, dynamic> json) =>
      ProviderListItem(
        providerCode: json["ProviderCode"],
        countryIso: json["CountryIso"],
        name: json["Name"],
        validationRegex: json["ValidationRegex"],
        customerCareNumber: json["CustomerCareNumber"],
        regionCodes: List<String>.from(json["RegionCodes"].map((x) => x)),
        paymentTypes: List<RechargePaymentType>.from(
            json["PaymentTypes"].map((x) => paymentTypeValues.map[x]!)),
        logoUrl: json["LogoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "ProviderCode": providerCode,
        "CountryIso": countryIso,
        "Name": name,
        "ValidationRegex": validationRegex,
        "CustomerCareNumber": customerCareNumber,
        "RegionCodes": List<dynamic>.from(regionCodes.map((x) => x)),
        "PaymentTypes": List<dynamic>.from(
            paymentTypes.map((x) => paymentTypeValues.reverse[x])),
        "LogoUrl": logoUrl,
      };
}

enum RechargePaymentType { prepaid }

final paymentTypeValues = EnumValues({"Prepaid": RechargePaymentType.prepaid});
