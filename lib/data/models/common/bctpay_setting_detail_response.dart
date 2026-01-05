import 'package:bctpay/lib.dart';

class BctpaySettingDetailsResponse {
  final int code;
  final BCTPaySettingDetailsData? data;
  final String message;
  final bool? success;

  BctpaySettingDetailsResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory BctpaySettingDetailsResponse.fromJson(Map<String, dynamic> json) =>
      BctpaySettingDetailsResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : BCTPaySettingDetailsData.fromJson(json["data"]),
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

class BCTPaySettingDetailsData {
  final List<AdminList> admincommisionfeesList;
  final List<AdmintransationlimitList> admintransationlimitList;
  final List<AdminWithdrawalFeesList> adminWithdrawalFeesList;
  final List<AdminList> adminTransactionFeesList;
  final List<AdminList> adminWallettopupFeesList;
  final List<AdminList> adminSettlementDayList;

  BCTPaySettingDetailsData({
    required this.admincommisionfeesList,
    required this.admintransationlimitList,
    required this.adminWithdrawalFeesList,
    required this.adminTransactionFeesList,
    required this.adminWallettopupFeesList,
    required this.adminSettlementDayList,
  });

  factory BCTPaySettingDetailsData.fromJson(Map<String, dynamic> json) =>
      BCTPaySettingDetailsData(
        admincommisionfeesList: List<AdminList>.from(
            json["AdmincommisionfeesList"].map((x) => AdminList.fromJson(x))),
        admintransationlimitList: List<AdmintransationlimitList>.from(
            json["AdmintransationlimitList"]
                .map((x) => AdmintransationlimitList.fromJson(x))),
        adminWithdrawalFeesList: List<AdminWithdrawalFeesList>.from(
            json["AdminWithdrawalFeesList"]
                .map((x) => AdminWithdrawalFeesList.fromJson(x))),
        adminTransactionFeesList: List<AdminList>.from(
            json["AdminTransactionFeesList"].map((x) => AdminList.fromJson(x))),
        adminWallettopupFeesList: List<AdminList>.from(
            json["AdminWallettopupFeesList"].map((x) => AdminList.fromJson(x))),
        adminSettlementDayList: List<AdminList>.from(
            json["AdminSettlementDayList"].map((x) => AdminList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "AdmincommisionfeesList":
            List<dynamic>.from(admincommisionfeesList.map((x) => x.toJson())),
        "AdmintransationlimitList":
            List<dynamic>.from(admintransationlimitList.map((x) => x.toJson())),
        "AdminWithdrawalFeesList":
            List<dynamic>.from(adminWithdrawalFeesList.map((x) => x.toJson())),
        "AdminTransactionFeesList":
            List<dynamic>.from(adminTransactionFeesList.map((x) => x.toJson())),
        "AdminWallettopupFeesList":
            List<dynamic>.from(adminWallettopupFeesList.map((x) => x.toJson())),
        "AdminSettlementDayList":
            List<dynamic>.from(adminSettlementDayList.map((x) => x.toJson())),
      };
}

class AdminList {
  final String id;
  final String adminId;
  final CountryId? countryId;
  final String countryName;
  final String countryCode;
  final String serviceType;
  final int? minSettlementDays;
  final int? maxSettlementDays;
  final CommisionType? transactionFeeType;
  final int? transactionFee;
  final CommisionType? walletFeeType;
  final int? topupFee;
  final CommisionType? commisionType;
  final int? amount;

  AdminList({
    required this.id,
    required this.adminId,
    required this.countryId,
    required this.countryName,
    required this.countryCode,
    required this.serviceType,
    required this.minSettlementDays,
    required this.maxSettlementDays,
    required this.transactionFeeType,
    required this.transactionFee,
    required this.walletFeeType,
    required this.topupFee,
    required this.commisionType,
    required this.amount,
  });

  factory AdminList.fromJson(Map<String, dynamic> json) => AdminList(
        id: json["_id"],
        adminId: json["adminId"],
        countryId: json["country_id"] == null
            ? null
            : CountryId.fromJson(json["country_id"]),
        countryName: json["country_name"],
        countryCode: json["country_code"],
        serviceType: json["service_type"],
        minSettlementDays: json["min_settlement_days"],
        maxSettlementDays: json["max_settlement_days"],
        transactionFeeType:
            commisionTypeValues.map[json["transaction_fee_type"]],
        transactionFee: json["transaction_fee"],
        walletFeeType: commisionTypeValues.map[json["wallet_fee_type"]],
        topupFee: json["topup_fee"],
        commisionType: commisionTypeValues.map[json["commision_type"]],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "country_id": countryId?.toJson(),
        "country_name": countryName,
        "country_code": countryCode,
        "service_type": serviceType,
        "min_settlement_days": minSettlementDays,
        "max_settlement_days": maxSettlementDays,
        "transaction_fee_type": transactionFeeType,
        "transaction_fee": transactionFee,
        "wallet_fee_type": walletFeeType,
        "topup_fee": topupFee,
        "commision_type": commisionType,
        "amount": amount,
      };
}

class CountryId {
  final String id;
  final String adminId;
  final String countryName;
  final String countryCode;
  final String currencyCode;
  final String timeZone;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String writePermission;

  CountryId({
    required this.id,
    required this.adminId,
    required this.countryName,
    required this.countryCode,
    required this.currencyCode,
    required this.timeZone,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.writePermission,
  });

  factory CountryId.fromJson(Map<String, dynamic> json) => CountryId(
        id: json["_id"],
        adminId: json["adminId"],
        countryName: json["country_name"],
        countryCode: json["country_code"],
        currencyCode: json["currency_code"],
        timeZone: json["time_zone"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        writePermission: json["write_permission"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "country_name": countryName,
        "country_code": countryCode,
        "currency_code": currencyCode,
        "time_zone": timeZone,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "write_permission": writePermission,
      };
}

class AdminWithdrawalFeesList {
  final String id;
  final String adminId;
  final CountryId? countryId;
  final String countryName;
  final String countryCode;
  final String serviceType;
  final int instantWithdrawalFee;
  final String instantWithdrawalFeeType;
  final int normalWithdrawalFee;
  final String normalWithdrawalFeeType;

  AdminWithdrawalFeesList({
    required this.id,
    required this.adminId,
    required this.countryId,
    required this.countryName,
    required this.countryCode,
    required this.serviceType,
    required this.instantWithdrawalFee,
    required this.instantWithdrawalFeeType,
    required this.normalWithdrawalFee,
    required this.normalWithdrawalFeeType,
  });

  factory AdminWithdrawalFeesList.fromJson(Map<String, dynamic> json) =>
      AdminWithdrawalFeesList(
        id: json["_id"],
        adminId: json["adminId"],
        countryId: json["country_id"] == null
            ? null
            : CountryId.fromJson(json["country_id"]),
        countryName: json["country_name"],
        countryCode: json["country_code"],
        serviceType: json["service_type"],
        instantWithdrawalFee: json["instant_withdrawal_fee"],
        instantWithdrawalFeeType: json["instant_withdrawal_fee_type"],
        normalWithdrawalFee: json["normal_withdrawal_fee"],
        normalWithdrawalFeeType: json["normal_withdrawal_fee_type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "country_id": countryId?.toJson(),
        "country_name": countryName,
        "country_code": countryCode,
        "service_type": serviceType,
        "instant_withdrawal_fee": instantWithdrawalFee,
        "instant_withdrawal_fee_type": instantWithdrawalFeeType,
        "normal_withdrawal_fee": normalWithdrawalFee,
        "normal_withdrawal_fee_type": normalWithdrawalFeeType,
      };
}

class AdmintransationlimitList {
  final String id;
  final String adminId;
  final CountryId? countryId;
  final String countryName;
  final String countryCode;
  final String serviceType;
  final int monthlyAmount;
  final int dailyAmount;
  final int perTrasactionAmount;

  AdmintransationlimitList({
    required this.id,
    required this.adminId,
    required this.countryId,
    required this.countryName,
    required this.countryCode,
    required this.serviceType,
    required this.monthlyAmount,
    required this.dailyAmount,
    required this.perTrasactionAmount,
  });

  factory AdmintransationlimitList.fromJson(Map<String, dynamic> json) =>
      AdmintransationlimitList(
        id: json["_id"],
        adminId: json["adminId"],
        countryId: json["country_id"] == null
            ? null
            : CountryId.fromJson(json["country_id"]),
        countryName: json["country_name"],
        countryCode: json["country_code"],
        serviceType: json["service_type"],
        monthlyAmount: json["monthly_amount"],
        dailyAmount: json["daily_amount"],
        perTrasactionAmount: json["per_trasaction_amount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "country_id": countryId?.toJson(),
        "country_name": countryName,
        "country_code": countryCode,
        "service_type": serviceType,
        "monthly_amount": monthlyAmount,
        "daily_amount": dailyAmount,
        "per_trasaction_amount": perTrasactionAmount,
      };
}

// ignore: constant_identifier_names
enum CommisionType { PERCENTAGE, FIXED }

final commisionTypeValues = EnumValues({
  "PERCENTAGE": CommisionType.PERCENTAGE,
  "FIXED": CommisionType.FIXED,
});
