// To parse this JSON data, do
//
//     final subscriberUserDetailResponse = subscriberUserDetailResponseFromJson(jsonString);

import 'dart:convert';

SubscriberUserDetailResponse subscriberUserDetailResponseFromJson(String str) =>
    SubscriberUserDetailResponse.fromJson(json.decode(str));

String subscriberUserDetailResponseToJson(SubscriberUserDetailResponse data) =>
    json.encode(data.toJson());

class SubscriberUserDetailResponse {
  final int? code;
  final SubscriberUserDetailData? data;
  final String? message;
  final bool? success;

  SubscriberUserDetailResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  SubscriberUserDetailResponse copyWith({
    int? code,
    SubscriberUserDetailData? data,
    String? message,
    bool? success,
  }) =>
      SubscriberUserDetailResponse(
        code: code ?? this.code,
        data: data ?? this.data,
        message: message ?? this.message,
        success: success ?? this.success,
      );

  factory SubscriberUserDetailResponse.fromJson(Map<String, dynamic> json) =>
      SubscriberUserDetailResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : SubscriberUserDetailData.fromJson(json["data"]),
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

class SubscriberUserDetailData {
  final List<Subscriptionslist>? subscriptionslist;

  SubscriberUserDetailData({
    this.subscriptionslist,
  });

  SubscriberUserDetailData copyWith({
    List<Subscriptionslist>? subscriptionslist,
  }) =>
      SubscriberUserDetailData(
        subscriptionslist: subscriptionslist ?? this.subscriptionslist,
      );

  factory SubscriberUserDetailData.fromJson(Map<String, dynamic> json) =>
      SubscriberUserDetailData(
        subscriptionslist: json["subscriptionslist"] == null
            ? []
            : List<Subscriptionslist>.from(json["subscriptionslist"]!
                .map((x) => Subscriptionslist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subscriptionslist": subscriptionslist == null
            ? []
            : List<dynamic>.from(subscriptionslist!.map((x) => x.toJson())),
      };
}

class Subscriptionslist {
  final String? id;
  final String? adminId;
  final String? merchantId;
  final String? subscriptionType;
  final String? shareStatus;
  final String? subscriberPhoneNumber;
  final String? subscriberPhoneCode;
  final String? status;
  final PaymentStatus? paymentStatus;
  final String? customerLastname;
  final String? subscriberUserAccId;
  final String? customerName;
  final String? subscriberCategoryId;
  final String? subscriberCategoryName;
  final String? subscriberId;
  final String? subscriberName;
  final String? subscriberEmail;
  final String? customerEmail;
  final String? customerPhoneNumber;
  final String? customerPhoneCode;
  final String? customerAddress;
  final String? customerCity;
  final String? customerPincode;
  final String? expired;
  final UserType? userType;
  final String? userId;
  final List<Map<String, String?>>? planInfo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? paymentLink;
  final String? planName;
  final String? customerAddress2;

  Subscriptionslist({
    this.id,
    this.adminId,
    this.merchantId,
    this.subscriptionType,
    this.shareStatus,
    this.subscriberPhoneNumber,
    this.subscriberPhoneCode,
    this.status,
    this.paymentStatus,
    this.customerLastname,
    this.subscriberUserAccId,
    this.customerName,
    this.subscriberCategoryId,
    this.subscriberCategoryName,
    this.subscriberId,
    this.subscriberName,
    this.subscriberEmail,
    this.customerEmail,
    this.customerPhoneNumber,
    this.customerPhoneCode,
    this.customerAddress,
    this.customerCity,
    this.customerPincode,
    this.expired,
    this.userType,
    this.userId,
    this.planInfo,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.paymentLink,
    this.planName,
    this.customerAddress2,
  });

  Subscriptionslist copyWith({
    String? id,
    String? adminId,
    String? merchantId,
    String? subscriptionType,
    String? shareStatus,
    String? subscriberPhoneNumber,
    String? subscriberPhoneCode,
    String? status,
    PaymentStatus? paymentStatus,
    String? customerLastname,
    String? subscriberUserAccId,
    String? customerName,
    String? subscriberCategoryId,
    String? subscriberCategoryName,
    String? subscriberId,
    String? subscriberName,
    String? subscriberEmail,
    String? customerEmail,
    String? customerPhoneNumber,
    String? customerPhoneCode,
    String? customerAddress,
    String? customerCity,
    String? customerPincode,
    String? expired,
    UserType? userType,
    String? userId,
    List<Map<String, String?>>? planInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? paymentLink,
    String? planName,
    String? customerAddress2,
  }) =>
      Subscriptionslist(
        id: id ?? this.id,
        adminId: adminId ?? this.adminId,
        merchantId: merchantId ?? this.merchantId,
        subscriptionType: subscriptionType ?? this.subscriptionType,
        shareStatus: shareStatus ?? this.shareStatus,
        subscriberPhoneNumber:
            subscriberPhoneNumber ?? this.subscriberPhoneNumber,
        subscriberPhoneCode: subscriberPhoneCode ?? this.subscriberPhoneCode,
        status: status ?? this.status,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        customerLastname: customerLastname ?? this.customerLastname,
        subscriberUserAccId: subscriberUserAccId ?? this.subscriberUserAccId,
        customerName: customerName ?? this.customerName,
        subscriberCategoryId: subscriberCategoryId ?? this.subscriberCategoryId,
        subscriberCategoryName:
            subscriberCategoryName ?? this.subscriberCategoryName,
        subscriberId: subscriberId ?? this.subscriberId,
        subscriberName: subscriberName ?? this.subscriberName,
        subscriberEmail: subscriberEmail ?? this.subscriberEmail,
        customerEmail: customerEmail ?? this.customerEmail,
        customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
        customerPhoneCode: customerPhoneCode ?? this.customerPhoneCode,
        customerAddress: customerAddress ?? this.customerAddress,
        customerCity: customerCity ?? this.customerCity,
        customerPincode: customerPincode ?? this.customerPincode,
        expired: expired ?? this.expired,
        userType: userType ?? this.userType,
        userId: userId ?? this.userId,
        planInfo: planInfo ?? this.planInfo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        paymentLink: paymentLink ?? this.paymentLink,
        planName: planName ?? this.planName,
        customerAddress2: customerAddress2 ?? this.customerAddress2,
      );

  factory Subscriptionslist.fromJson(Map<String, dynamic> json) =>
      Subscriptionslist(
        id: json["_id"],
        adminId: json["adminId"],
        merchantId: json["merchantId"],
        subscriptionType: json["subscription_type"],
        shareStatus: json["share_status"],
        subscriberPhoneNumber: json["SubscriberPhone_number"],
        subscriberPhoneCode: json["SubscriberPhone_code"],
        status: json["status"],
        paymentStatus: paymentStatusValues.map[json["payment_status"]]!,
        customerLastname: json["customer_lastname"],
        subscriberUserAccId: json["subscriber_userAcc_id"],
        customerName: json["customer_name"],
        subscriberCategoryId: json["subscriber_category_id"],
        subscriberCategoryName: json["subscriber_category_name"],
        subscriberId: json["SubscriberId"],
        subscriberName: json["SubscriberName"],
        subscriberEmail: json["SubscriberEmail"],
        customerEmail: json["customer_email"],
        customerPhoneNumber: json["customer_phone_number"],
        customerPhoneCode: json["customer_phone_code"],
        customerAddress: json["customer_address"],
        customerCity: json["customer_city"],
        customerPincode: json["customer_pincode"],
        expired: json["expired"],
        userType: userTypeValues.map[json["user_type"]]!,
        userId: json["user_id"],
        planInfo: json["plan_info"] == null
            ? []
            : List<Map<String, String?>>.from(json["plan_info"]!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        paymentLink: json["payment_link"],
        planName: json["plan_name"],
        customerAddress2: json["customer_address2"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "merchantId": merchantId,
        "subscription_type": subscriptionType,
        "share_status": shareStatus,
        "SubscriberPhone_number": subscriberPhoneNumber,
        "SubscriberPhone_code": subscriberPhoneCode,
        "status": status,
        "payment_status": paymentStatusValues.reverse[paymentStatus],
        "customer_lastname": customerLastname,
        "subscriber_userAcc_id": subscriberUserAccId,
        "customer_name": customerName,
        "subscriber_category_id": subscriberCategoryId,
        "subscriber_category_name": subscriberCategoryName,
        "SubscriberId": subscriberId,
        "SubscriberName": subscriberName,
        "SubscriberEmail": subscriberEmail,
        "customer_email": customerEmail,
        "customer_phone_number": customerPhoneNumber,
        "customer_phone_code": customerPhoneCode,
        "customer_address": customerAddress,
        "customer_city": customerCity,
        "customer_pincode": customerPincode,
        "expired": expired,
        "user_type": userTypeValues.reverse[userType],
        "user_id": userId,
        "plan_info": planInfo == null
            ? []
            : List<dynamic>.from(planInfo!.map((x) =>
                Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "payment_link": paymentLink,
        "plan_name": planName,
        "customer_address2": customerAddress2,
      };
}

enum PaymentStatus { PAID, UNPAID }

final paymentStatusValues =
    EnumValues({"PAID": PaymentStatus.PAID, "UNPAID": PaymentStatus.UNPAID});

enum UserType { CUSTOMER, OTHER }

final userTypeValues =
    EnumValues({"Customer": UserType.CUSTOMER, "Other": UserType.OTHER});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
