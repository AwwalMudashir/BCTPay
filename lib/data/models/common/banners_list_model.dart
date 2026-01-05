class BannersListResponse {
  final int code;
  final BannerList? data;
  final String message;
  final bool? success;

  BannersListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory BannersListResponse.fromJson(Map<String, dynamic> json) =>
      BannersListResponse(
        code: json["code"],
        data: json["data"] == null ? null : BannerList.fromJson(json["data"]),
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

class BannerList {
  final List<BannerData> promotionList;
  final int count;

  BannerList({
    required this.promotionList,
    required this.count,
  });

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        promotionList: List<BannerData>.from(
            json["promotionList"].map((x) => BannerData.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "promotionList":
            List<dynamic>.from(promotionList.map((x) => x.toJson())),
        "count": count,
      };
}

class BannerData {
  final String id;
  final String promotionName;
  final String description;
  final String? promotionType;
  final String? promotionForRole;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;
  final String? discountType;
  final int? discountValue;
  final String? termsAndConditions;
  final String promotionBanner;
  final String? applicableCountryName;
  final String? applicableCountryId;
  final String? applicableCountryFlag;
  final String createdbyUserRole;
  final String createdbyUserName;
  final String createdbyUserEmail;
  final String createdbyUserProfilePic;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  BannerData({
    required this.id,
    required this.promotionName,
    required this.description,
    required this.promotionType,
    required this.promotionForRole,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.discountType,
    required this.discountValue,
    required this.termsAndConditions,
    required this.promotionBanner,
    required this.applicableCountryName,
    required this.applicableCountryId,
    required this.applicableCountryFlag,
    required this.createdbyUserRole,
    required this.createdbyUserName,
    required this.createdbyUserEmail,
    required this.createdbyUserProfilePic,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["_id"],
        promotionName: json["promotion_name"],
        description: json["description"],
        promotionType: json["promotion_type"],
        promotionForRole: json["promotion_for_role"],
        startDate: DateTime.tryParse(json["start_date"]),
        endDate: DateTime.tryParse(json["end_date"]),
        status: json["status"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        termsAndConditions: json["terms_and_conditions"],
        promotionBanner: json["promotion_banner"],
        applicableCountryName: json["applicable_country_name"],
        applicableCountryId: json["applicable_country_id"],
        applicableCountryFlag: json["applicable_country_flag"],
        createdbyUserRole: json["createdby_user_role"],
        createdbyUserName: json["createdby_user_name"],
        createdbyUserEmail: json["createdby_user_email"],
        createdbyUserProfilePic: json["createdby_user_profile_pic"],
        createdAt: DateTime.tryParse(json["createdAt"]),
        updatedAt: DateTime.tryParse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "promotion_name": promotionName,
        "description": description,
        "promotion_type": promotionType,
        "promotion_for_role": promotionForRole,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "discount_type": discountType,
        "discount_value": discountValue,
        "terms_and_conditions": termsAndConditions,
        "promotion_banner": promotionBanner,
        "applicable_country_name": applicableCountryName,
        "applicable_country_id": applicableCountryId,
        "applicable_country_flag": applicableCountryFlag,
        "createdby_user_role": createdbyUserRole,
        "createdby_user_name": createdbyUserName,
        "createdby_user_email": createdbyUserEmail,
        "createdby_user_profile_pic": createdbyUserProfilePic,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
