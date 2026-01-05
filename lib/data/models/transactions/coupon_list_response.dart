// To parse this JSON data, do
//
//     final couponListResponse = couponListResponseFromJson(jsonString);

import 'dart:convert';

CouponListResponse couponListResponseFromJson(String str) =>
    CouponListResponse.fromJson(json.decode(str));

String couponListResponseToJson(CouponListResponse data) =>
    json.encode(data.toJson());

class CouponListResponse {
  final int code;
  final List<Coupon>? data;
  final String message;
  final bool? success;

  CouponListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory CouponListResponse.fromJson(Map<String, dynamic> json) =>
      CouponListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<Coupon>.from(json["data"].map((x) => Coupon.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class Coupon {
  final String id;
  final String coupenTitle;
  final String coupenCode;
  final String coupenUses;
  final DateTime startDate;
  final DateTime endDate;
  final String termsAndCondition;
  final String minOrderValue;
  final String maxDiscount;
  final String status;
  final String coupenImage;
  final String countryName;
  final String countryid;
  final String countryFlag;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Coupon({
    required this.id,
    required this.coupenTitle,
    required this.coupenCode,
    required this.coupenUses,
    required this.startDate,
    required this.endDate,
    required this.termsAndCondition,
    required this.minOrderValue,
    required this.maxDiscount,
    required this.status,
    required this.coupenImage,
    required this.countryName,
    required this.countryid,
    required this.countryFlag,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["_id"],
        coupenTitle: json["CoupenTitle"],
        coupenCode: json["CoupenCode"],
        coupenUses: json["CoupenUses"],
        startDate: DateTime.parse(json["StartDate"]),
        endDate: DateTime.parse(json["EndDate"]),
        termsAndCondition: json["TermsAndCondition"],
        minOrderValue: json["MinOrderValue"],
        maxDiscount: json["MaxDiscount"],
        status: json["Status"],
        coupenImage: json["CoupenImage"],
        countryName: json["country_name"],
        countryid: json["countryid"],
        countryFlag: json["country_flag"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "CoupenTitle": coupenTitle,
        "CoupenCode": coupenCode,
        "CoupenUses": coupenUses,
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "TermsAndCondition": termsAndCondition,
        "MinOrderValue": minOrderValue,
        "MaxDiscount": maxDiscount,
        "Status": status,
        "CoupenImage": coupenImage,
        "country_name": countryName,
        "countryid": countryid,
        "country_flag": countryFlag,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
