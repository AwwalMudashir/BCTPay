import 'package:bctpay/globals/index.dart';

class BanksListResponse {
  final int code;
  final BanksListData? data;
  final String message;
  final bool? success;

  BanksListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory BanksListResponse.fromJson(Map<String, dynamic> json) =>
      BanksListResponse(
        code: json["code"],
        data:
            json["data"] == null ? null : BanksListData.fromJson(json["data"]),
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

class BanksListData {
  final List<Bank> bankList;
  final int count;

  BanksListData({
    required this.bankList,
    required this.count,
  });

  factory BanksListData.fromJson(Map<String, dynamic> json) => BanksListData(
        bankList:
            List<Bank>.from(json["bankList"].map((x) => Bank.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "bankList": List<dynamic>.from(bankList.map((x) => x.toJson())),
        "count": count,
      };
}

class Bank extends Equatable {
  final String id;
  final String name;
  final String accountType;
  final String? logo;
  final String status;
  final String countryId;
  final String countryName;
  final String countryCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  const Bank({
    required this.id,
    required this.name,
    required this.accountType,
    required this.logo,
    required this.status,
    required this.countryId,
    required this.countryName,
    required this.countryCode,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["_id"],
        name: json["name"],
        accountType: json["account_type"],
        logo: json["logo"],
        status: json["status"],
        countryId: json["country_id"],
        countryName: json["country_name"],
        countryCode: json["country_code"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "account_type": accountType,
        "logo": logo,
        "status": status,
        "country_id": countryId,
        "country_name": countryName,
        "country_code": countryCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        accountType,
        logo,
        status,
        countryId,
        countryName,
        countryCode,
        createdAt,
        updatedAt,
        v,
      ];
}
