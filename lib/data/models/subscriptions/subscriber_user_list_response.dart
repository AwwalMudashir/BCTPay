// To parse this JSON data, do
//
//     final subscriberUserListResponse = subscriberUserListResponseFromJson(jsonString);

import 'package:bctpay/lib.dart';

SubscriberUserListResponse subscriberUserListResponseFromJson(String str) =>
    SubscriberUserListResponse.fromJson(json.decode(str));

String subscriberUserListResponseToJson(SubscriberUserListResponse data) =>
    json.encode(data.toJson());

class SubscriberUserListResponse {
  final int? code;
  final SubscriberUserListData? data;
  final String? message;
  final bool? success;

  SubscriberUserListResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  SubscriberUserListResponse copyWith({
    int? code,
    SubscriberUserListData? data,
    String? message,
    bool? success,
  }) =>
      SubscriberUserListResponse(
        code: code ?? this.code,
        data: data ?? this.data,
        message: message ?? this.message,
        success: success ?? this.success,
      );

  factory SubscriberUserListResponse.fromJson(Map<String, dynamic> json) =>
      SubscriberUserListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : SubscriberUserListData.fromJson(json["data"]),
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

class SubscriberUserListData {
  final List<Subscription>? subscriptions;
  final int? subscriptionscount;

  SubscriberUserListData({
    this.subscriptions,
    this.subscriptionscount,
  });

  SubscriberUserListData copyWith({
    List<Subscription>? subscriptions,
    int? subscriptionscount,
  }) =>
      SubscriberUserListData(
        subscriptions: subscriptions ?? this.subscriptions,
        subscriptionscount: subscriptionscount ?? this.subscriptionscount,
      );

  factory SubscriberUserListData.fromJson(Map<String, dynamic> json) =>
      SubscriberUserListData(
        subscriptions: json["subscriptions"] == null
            ? []
            : List<Subscription>.from(
                json["subscriptions"]!.map((x) => Subscription.fromJson(x))),
        subscriptionscount: json["subscriptionscount"],
      );

  Map<String, dynamic> toJson() => {
        "subscriptions": subscriptions == null
            ? []
            : List<dynamic>.from(subscriptions!.map((x) => x.toJson())),
        "subscriptionscount": subscriptionscount,
      };
}

// class Subscription {
//   final String? id;
//   final String? adminId;
//   final MerchantData? merchantId;
//   final String? status;
//   final String? customerLastname;
//   final String? customerAddress2;
//   final String? customerName;
//   final String? subscriberCategoryId;
//   final String? subscriberCategoryName;
//   final String? customerEmail;
//   final String? customerPhoneNumber;
//   final String? customerPhoneCode;
//   final String? customerAddress;
//   final String? customerCity;
//   final String? customerPincode;
//   final String? userType;
//   final String? userId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;
//   final String? customerState;

//   Subscription({
//     this.id,
//     this.adminId,
//     this.merchantId,
//     this.status,
//     this.customerLastname,
//     this.customerAddress2,
//     this.customerName,
//     this.subscriberCategoryId,
//     this.subscriberCategoryName,
//     this.customerEmail,
//     this.customerPhoneNumber,
//     this.customerPhoneCode,
//     this.customerAddress,
//     this.customerCity,
//     this.customerPincode,
//     this.userType,
//     this.userId,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.customerState,
//   });

//   Subscription copyWith({
//     String? id,
//     String? adminId,
//     MerchantData? merchantId,
//     String? status,
//     String? customerLastname,
//     String? customerAddress2,
//     String? customerName,
//     String? subscriberCategoryId,
//     String? subscriberCategoryName,
//     String? customerEmail,
//     String? customerPhoneNumber,
//     String? customerPhoneCode,
//     String? customerAddress,
//     String? customerCity,
//     String? customerPincode,
//     String? userType,
//     String? userId,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     int? v,
//     String? customerState,
//   }) =>
//       Subscription(
//         id: id ?? this.id,
//         adminId: adminId ?? this.adminId,
//         merchantId: merchantId ?? this.merchantId,
//         status: status ?? this.status,
//         customerLastname: customerLastname ?? this.customerLastname,
//         customerAddress2: customerAddress2 ?? this.customerAddress2,
//         customerName: customerName ?? this.customerName,
//         subscriberCategoryId: subscriberCategoryId ?? this.subscriberCategoryId,
//         subscriberCategoryName:
//             subscriberCategoryName ?? this.subscriberCategoryName,
//         customerEmail: customerEmail ?? this.customerEmail,
//         customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
//         customerPhoneCode: customerPhoneCode ?? this.customerPhoneCode,
//         customerAddress: customerAddress ?? this.customerAddress,
//         customerCity: customerCity ?? this.customerCity,
//         customerPincode: customerPincode ?? this.customerPincode,
//         userType: userType ?? this.userType,
//         userId: userId ?? this.userId,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         v: v ?? this.v,
//         customerState: customerState ?? this.customerState,
//       );

//   factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
//         id: json["_id"],
//         adminId: json["adminId"],
//         merchantId: json["merchantId"] == null
//             ? null
//             : MerchantData.fromJson(json["merchantId"]),
//         status: json["status"],
//         customerLastname: json["customer_lastname"],
//         customerAddress2: json["customer_address2"],
//         customerName: json["customer_name"],
//         subscriberCategoryId: json["subscriber_category_id"],
//         subscriberCategoryName: json["subscriber_category_name"],
//         customerEmail: json["customer_email"],
//         customerPhoneNumber: json["customer_phone_number"],
//         customerPhoneCode: json["customer_phone_code"],
//         customerAddress: json["customer_address"],
//         customerCity: json["customer_city"],
//         customerPincode: json["customer_pincode"],
//         userType: json["user_type"],
//         userId: json["user_id"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         customerState: json["customer_state"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "adminId": adminId,
//         "merchantId": merchantId?.toJson(),
//         "status": status,
//         "customer_lastname": customerLastname,
//         "customer_address2": customerAddress2,
//         "customer_name": customerName,
//         "subscriber_category_id": subscriberCategoryId,
//         "subscriber_category_name": subscriberCategoryName,
//         "customer_email": customerEmail,
//         "customer_phone_number": customerPhoneNumber,
//         "customer_phone_code": customerPhoneCode,
//         "customer_address": customerAddress,
//         "customer_city": customerCity,
//         "customer_pincode": customerPincode,
//         "user_type": userType,
//         "user_id": userId,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//         "customer_state": customerState,
//       };
// }

// class MerchantId {
//   final String? id;
//   final String? companyLogo;
//   final String? firstname;
//   final String? lastname;
//   final String? profilePic;
//   final String? email;
//   final String? countryflag;
//   final String? phonenumber;
//   final String? phoneCode;
//   final String? line1;
//   final String? line2;
//   final String? country;
//   final String? businessCategoryName;

//   MerchantId({
//     this.id,
//     this.companyLogo,
//     this.firstname,
//     this.lastname,
//     this.profilePic,
//     this.email,
//     this.countryflag,
//     this.phonenumber,
//     this.phoneCode,
//     this.line1,
//     this.line2,
//     this.country,
//     this.businessCategoryName,
//   });

//   MerchantId copyWith({
//     String? id,
//     String? companyLogo,
//     String? firstname,
//     String? lastname,
//     String? profilePic,
//     String? email,
//     String? countryflag,
//     String? phonenumber,
//     String? phoneCode,
//     String? line1,
//     String? line2,
//     String? country,
//     String? businessCategoryName,
//   }) =>
//       MerchantId(
//         id: id ?? this.id,
//         companyLogo: companyLogo ?? this.companyLogo,
//         firstname: firstname ?? this.firstname,
//         lastname: lastname ?? this.lastname,
//         profilePic: profilePic ?? this.profilePic,
//         email: email ?? this.email,
//         countryflag: countryflag ?? this.countryflag,
//         phonenumber: phonenumber ?? this.phonenumber,
//         phoneCode: phoneCode ?? this.phoneCode,
//         line1: line1 ?? this.line1,
//         line2: line2 ?? this.line2,
//         country: country ?? this.country,
//         businessCategoryName: businessCategoryName ?? this.businessCategoryName,
//       );

//   factory MerchantId.fromJson(Map<String, dynamic> json) => MerchantId(
//         id: json["_id"],
//         companyLogo: json["company_logo"],
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         profilePic: json["profile_pic"],
//         email: json["email"],
//         countryflag: json["countryflag"],
//         phonenumber: json["phonenumber"],
//         phoneCode: json["phone_code"],
//         line1: json["line1"],
//         line2: json["line2"],
//         country: json["country"],
//         businessCategoryName: json["business_category_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "company_logo": companyLogo,
//         "firstname": firstname,
//         "lastname": lastname,
//         "profile_pic": profilePic,
//         "email": email,
//         "countryflag": countryflag,
//         "phonenumber": phonenumber,
//         "phone_code": phoneCode,
//         "line1": line1,
//         "line2": line2,
//         "country": country,
//         "business_category_name": businessCategoryName,
//       };
// }
