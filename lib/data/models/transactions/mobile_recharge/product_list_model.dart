class ProductListResponse {
  final int code;
  final ProductListData? data;
  final String message;
  final bool? success;

  ProductListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      ProductListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : ProductListData.fromJson(json["data"]),
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

class ProductListData {
  final int resultCode;
  final List<dynamic> errorCodes;
  final List<Plan> items;

  ProductListData({
    required this.resultCode,
    required this.errorCodes,
    required this.items,
  });

  factory ProductListData.fromJson(Map<String, dynamic> json) =>
      ProductListData(
        resultCode: json["ResultCode"],
        errorCodes: List<dynamic>.from(json["ErrorCodes"].map((x) => x)),
        items: json["Items"] == null
            ? []
            : List<Plan>.from(json["Items"].map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResultCode": resultCode,
        "ErrorCodes": List<dynamic>.from(errorCodes.map((x) => x)),
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Plan {
  final String providerCode;
  final String skuCode;
  final String localizationKey;
  final List<dynamic> settingDefinitions;
  final Imum maximum;
  final Imum minimum;
  final double commissionRate;
  final String processingMode;
  final String redemptionMechanism;
  final List<dynamic> benefits;
  final String uatNumber;
  final String defaultDisplayText;
  final String regionCode;
  final List<dynamic> paymentTypes;
  final bool lookupBillsRequired;
  final String? validityPeriodIso;

  Plan({
    required this.providerCode,
    required this.skuCode,
    required this.localizationKey,
    required this.settingDefinitions,
    required this.maximum,
    required this.minimum,
    required this.commissionRate,
    required this.processingMode,
    required this.redemptionMechanism,
    required this.benefits,
    required this.uatNumber,
    required this.defaultDisplayText,
    required this.regionCode,
    required this.paymentTypes,
    required this.lookupBillsRequired,
    required this.validityPeriodIso,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        providerCode: json["ProviderCode"],
        skuCode: json["SkuCode"],
        localizationKey: json["LocalizationKey"],
        settingDefinitions:
            List<dynamic>.from(json["SettingDefinitions"].map((x) => x)),
        maximum: Imum.fromJson(json["Maximum"]),
        minimum: Imum.fromJson(json["Minimum"]),
        commissionRate: json["CommissionRate"]?.toDouble(),
        processingMode: json["ProcessingMode"],
        redemptionMechanism: json["RedemptionMechanism"],
        benefits: json["Benefits"],
        uatNumber: json["UatNumber"],
        defaultDisplayText: json["DefaultDisplayText"],
        regionCode: json["RegionCode"],
        paymentTypes: json["PaymentTypes"],
        lookupBillsRequired: json["LookupBillsRequired"],
        validityPeriodIso: json["ValidityPeriodIso"],
      );

  Map<String, dynamic> toJson() => {
        "ProviderCode": providerCode,
        "SkuCode": skuCode,
        "LocalizationKey": localizationKey,
        "SettingDefinitions":
            List<dynamic>.from(settingDefinitions.map((x) => x)),
        "Maximum": maximum.toJson(),
        "Minimum": minimum.toJson(),
        "CommissionRate": commissionRate,
        "ProcessingMode": processingMode,
        "RedemptionMechanism": redemptionMechanism,
        "Benefits": benefits,
        "UatNumber": uatNumber,
        "DefaultDisplayText": defaultDisplayText,
        "RegionCode": regionCode,
        "PaymentTypes": paymentTypes,
        "LookupBillsRequired": lookupBillsRequired,
        "ValidityPeriodIso": validityPeriodIso,
      };
}

// enum Benefit { mobile, minutes, data }

// final benefitValues = EnumValues({
//   "Data": Benefit.data,
//   "Minutes": Benefit.minutes,
//   "Mobile": Benefit.mobile
// });

class Imum {
  final int customerFee;
  final int distributorFee;
  final double receiveValue;
  final String receiveCurrencyIso;
  final double receiveValueExcludingTax;
  final int taxRate;
  final double sendValue;
  final String sendCurrencyIso;

  Imum({
    required this.customerFee,
    required this.distributorFee,
    required this.receiveValue,
    required this.receiveCurrencyIso,
    required this.receiveValueExcludingTax,
    required this.taxRate,
    required this.sendValue,
    required this.sendCurrencyIso,
  });

  factory Imum.fromJson(Map<String, dynamic> json) => Imum(
        customerFee: json["CustomerFee"],
        distributorFee: json["DistributorFee"],
        receiveValue: json["ReceiveValue"]?.toDouble(),
        receiveCurrencyIso: json["ReceiveCurrencyIso"],
        receiveValueExcludingTax: json["ReceiveValueExcludingTax"].toDouble(),
        taxRate: json["TaxRate"],
        sendValue: json["SendValue"]?.toDouble(),
        sendCurrencyIso: json["SendCurrencyIso"],
      );

  Map<String, dynamic> toJson() => {
        "CustomerFee": customerFee,
        "DistributorFee": distributorFee,
        "ReceiveValue": receiveValue,
        "ReceiveCurrencyIso": receiveCurrencyIso,
        "ReceiveValueExcludingTax": receiveValueExcludingTax,
        "TaxRate": taxRate,
        "SendValue": sendValue,
        "SendCurrencyIso": sendCurrencyIso,
      };
}

// enum ReceiveCurrencyIso { inr }

// final receiveCurrencyIsoValues = EnumValues({"INR": ReceiveCurrencyIso.inr});

// enum SendCurrencyIso { usd }

// final sendCurrencyIsoValues = EnumValues({"USD": SendCurrencyIso.usd});

// enum PaymentType { prepaid }

// final paymentTypeValues = EnumValues({"Prepaid": PaymentType.prepaid});

// enum ProcessingMode { instant }

// final processingModeValues = EnumValues({"Instant": ProcessingMode.instant});

// enum ProviderCode { rjin }

// final providerCodeValues = EnumValues({"RJIN": ProviderCode.rjin});

// enum RedemptionMechanism { immediate }

// final redemptionMechanismValues =
//     EnumValues({"Immediate": RedemptionMechanism.immediate});

// enum RegionCode { IN }

// final regionCodeValues = EnumValues({"IN": RegionCode.IN});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
