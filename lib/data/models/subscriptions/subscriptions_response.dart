// To parse this JSON data, do
//
//     final subscriptionListResponse = subscriptionListResponseFromJson(jsonString);

import 'package:bctpay/lib.dart';

SubscriptionsResponse subscriptionListResponseFromJson(String str) =>
    SubscriptionsResponse.fromJson(json.decode(str));

String subscriptionListResponseToJson(SubscriptionsResponse data) =>
    json.encode(data.toJson());

class SubscriptionsResponse {
  final int? code;
  final SubscriptionListData? data;
  final String? message;
  final bool? success;

  SubscriptionsResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  SubscriptionsResponse copyWith({
    int? code,
    SubscriptionListData? data,
    String? message,
    bool? success,
  }) =>
      SubscriptionsResponse(
        code: code ?? this.code,
        data: data ?? this.data,
        message: message ?? this.message,
        success: success ?? this.success,
      );

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) =>
      SubscriptionsResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : SubscriptionListData.fromJson(json["data"]),
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

class SubscriptionListData {
  final List<Subscription>? subscriptions;
  final int? count;

  SubscriptionListData({
    this.subscriptions,
    this.count,
  });

  SubscriptionListData copyWith({
    List<Subscription>? subscriptions,
    int? count,
  }) =>
      SubscriptionListData(
        subscriptions: subscriptions ?? this.subscriptions,
        count: count ?? this.count,
      );

  factory SubscriptionListData.fromJson(Map<String, dynamic> json) =>
      SubscriptionListData(
        subscriptions: json["subscriptions"] == null
            ? []
            : List<Subscription>.from(
                json["subscriptions"]!.map((x) => Subscription.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "subscriptions": subscriptions == null
            ? []
            : List<dynamic>.from(subscriptions!.map((x) => x.toJson())),
        "count": count,
      };
}

class Subscription {
  final SubscriberAccount? subscriberUserAcc;
  final List<Subscriber>? subscriber;

  Subscription({
    this.subscriberUserAcc,
    this.subscriber,
  });

  Subscription copyWith({
    SubscriberAccount? subscriberUserAcc,
    List<Subscriber>? subscriber,
  }) =>
      Subscription(
        subscriberUserAcc: subscriberUserAcc ?? this.subscriberUserAcc,
        subscriber: subscriber ?? this.subscriber,
      );

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        subscriberUserAcc: json["subscriber_user_acc"] == null
            ? null
            : SubscriberAccount.fromJson(json["subscriber_user_acc"]),
        subscriber: json["subscriber"] == null
            ? []
            : List<Subscriber>.from(
                json["subscriber"]!.map((x) => Subscriber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subscriber_user_acc": subscriberUserAcc?.toJson(),
        "subscriber": subscriber == null
            ? []
            : List<dynamic>.from(subscriber!.map((x) => x.toJson())),
      };
}

class Subscriber {
  final String? id;
  final String? adminId;
  final Customer? merchantId;
  final String? subscriptionType;
  final String? shareStatus;
  final String? subscriberPhoneNumber;
  final String? subscriberPhoneCode;
  final String? status;
  final String? paymentStatus;
  final String? customerLastname;
  final String? subscriberUserAccId;
  final String? customerAddress2;
  final String? customerName;
  final String? subscriberId;
  final String? subscriberName;
  final String? subscriberLastName;
  final String? subscriberEmail;
  final String? customerEmail;
  final String? customerPhoneNumber;
  final String? customerPhoneCode;
  final String? customerAddress;
  final String? customerCity;
  final String? customerPincode;
  final String? expired;
  final String? userType;
  final String? userId;
  final List<PlanInfo>? planInfo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? paymentLink;
  final String? planId;
  final String? planName;
  final List<TransactionData>? transactionData;
  final String? qrCode;
  final String? qrCodeLink;

  Subscriber({
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
    this.customerAddress2,
    this.customerName,
    this.subscriberId,
    this.subscriberName,
    this.subscriberLastName,
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
    this.planId,
    this.planName,
    this.transactionData,
    this.qrCode,
    this.qrCodeLink,
  });

  Subscriber copyWith({
    String? id,
    String? adminId,
    Customer? merchantId,
    String? subscriptionType,
    String? shareStatus,
    String? subscriberPhoneNumber,
    String? subscriberPhoneCode,
    String? status,
    String? paymentStatus,
    String? customerLastname,
    String? subscriberUserAccId,
    String? customerAddress2,
    String? customerName,
    String? subscriberId,
    String? subscriberName,
    String? subscriberLastName,
    String? subscriberEmail,
    String? customerEmail,
    String? customerPhoneNumber,
    String? customerPhoneCode,
    String? customerAddress,
    String? customerCity,
    String? customerPincode,
    String? expired,
    String? userType,
    String? userId,
    List<PlanInfo>? planInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? paymentLink,
    String? planId,
    String? planName,
    List<TransactionData>? transactionData,
    String? qrCode,
    String? qrCodeLink,
  }) =>
      Subscriber(
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
        customerAddress2: customerAddress2 ?? this.customerAddress2,
        customerName: customerName ?? this.customerName,
        subscriberId: subscriberId ?? this.subscriberId,
        subscriberName: subscriberName ?? this.subscriberName,
        subscriberLastName: subscriberLastName ?? this.subscriberLastName,
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
        planId: planId ?? this.planId,
        planName: planName ?? this.planName,
        transactionData: transactionData ?? this.transactionData,
        qrCode: qrCode ?? this.qrCode,
        qrCodeLink: qrCodeLink ?? this.qrCodeLink,
      );

  factory Subscriber.fromJson(Map<String, dynamic> json) => Subscriber(
        id: json["_id"],
        adminId: json["adminId"],
        merchantId: json["merchantId"] is String
            ? Customer(id: json["merchantId"])
            : Customer.fromJson(json["merchantId"]),
        subscriptionType: json["subscription_type"],
        shareStatus: json["share_status"],
        subscriberPhoneNumber: json["SubscriberPhone_number"],
        subscriberPhoneCode: json["SubscriberPhone_code"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        customerLastname: json["customer_lastname"],
        subscriberUserAccId: json["subscriber_userAcc_id"],
        customerAddress2: json["customer_address2"],
        customerName: json["customer_name"],
        subscriberId: json["SubscriberId"],
        subscriberName: json["SubscriberName"],
        subscriberLastName: json["SubscriberLastName"],
        subscriberEmail: json["SubscriberEmail"],
        customerEmail: json["customer_email"],
        customerPhoneNumber: json["customer_phone_number"],
        customerPhoneCode: json["customer_phone_code"],
        customerAddress: json["customer_address"],
        customerCity: json["customer_city"],
        customerPincode: json["customer_pincode"],
        expired: json["expired"],
        userType: json["user_type"],
        userId: json["user_id"],
        planInfo: json["plan_info"] == null
            ? []
            : List<PlanInfo>.from(
                json["plan_info"]!.map((x) => PlanInfo.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        paymentLink: json["payment_link"],
        planId: json["plan_id"],
        planName: json["plan_name"],
        transactionData: (json["transaction_details"] == null)
            ? null
            : List<TransactionData>.from(json["transaction_details"]
                .map((x) => TransactionData.fromJson(x))),
        qrCode: json['qr_code'],
        qrCodeLink: json['qr_code_link'],
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
        "payment_status": paymentStatus,
        "customer_lastname": customerLastname,
        "subscriber_userAcc_id": subscriberUserAccId,
        "customer_address2": customerAddress2,
        "customer_name": customerName,
        "SubscriberId": subscriberId,
        "SubscriberName": subscriberName,
        "SubscriberLastName": subscriberLastName,
        "SubscriberEmail": subscriberEmail,
        "customer_email": customerEmail,
        "customer_phone_number": customerPhoneNumber,
        "customer_phone_code": customerPhoneCode,
        "customer_address": customerAddress,
        "customer_city": customerCity,
        "customer_pincode": customerPincode,
        "expired": expired,
        "user_type": userType,
        "user_id": userId,
        "plan_info": planInfo == null
            ? []
            : List<dynamic>.from(planInfo!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "payment_link": paymentLink,
        "plan_id": planId,
        "plan_name": planName,
        "TransactionData": transactionData?.map((e) => e.toJson()).toList(),
        "qr_code": qrCode,
        "qr_code_link": qrCodeLink,
      };
}

class SubscriberAccount {
  final String? id;
  final String? adminId;
  final Customer? merchantId;
  final String? status;
  final String? customerLastname;
  final String? customerAddress2;
  final String? customerName;
  final String? subscriberCategoryId;
  final String? subscriberCategoryName;
  final String? customerEmail;
  final String? customerPhoneNumber;
  final String? customerPhoneCode;
  final String? customerAddress;
  final String? customerCity;
  final String? customerPincode;
  final String? userType;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SubscriberAccount({
    this.id,
    this.adminId,
    this.merchantId,
    this.status,
    this.customerLastname,
    this.customerAddress2,
    this.customerName,
    this.subscriberCategoryId,
    this.subscriberCategoryName,
    this.customerEmail,
    this.customerPhoneNumber,
    this.customerPhoneCode,
    this.customerAddress,
    this.customerCity,
    this.customerPincode,
    this.userType,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  SubscriberAccount copyWith({
    String? id,
    String? adminId,
    Customer? merchantId,
    String? status,
    String? customerLastname,
    String? customerAddress2,
    String? customerName,
    String? subscriberCategoryId,
    String? subscriberCategoryName,
    String? customerEmail,
    String? customerPhoneNumber,
    String? customerPhoneCode,
    String? customerAddress,
    String? customerCity,
    String? customerPincode,
    String? userType,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      SubscriberAccount(
        id: id ?? this.id,
        adminId: adminId ?? this.adminId,
        merchantId: merchantId ?? this.merchantId,
        status: status ?? this.status,
        customerLastname: customerLastname ?? this.customerLastname,
        customerAddress2: customerAddress2 ?? this.customerAddress2,
        customerName: customerName ?? this.customerName,
        subscriberCategoryId: subscriberCategoryId ?? this.subscriberCategoryId,
        subscriberCategoryName:
            subscriberCategoryName ?? this.subscriberCategoryName,
        customerEmail: customerEmail ?? this.customerEmail,
        customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
        customerPhoneCode: customerPhoneCode ?? this.customerPhoneCode,
        customerAddress: customerAddress ?? this.customerAddress,
        customerCity: customerCity ?? this.customerCity,
        customerPincode: customerPincode ?? this.customerPincode,
        userType: userType ?? this.userType,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory SubscriberAccount.fromJson(Map<String, dynamic> json) =>
      SubscriberAccount(
        id: json["_id"],
        adminId: json["adminId"],
        merchantId: json["merchantId"] == null
            ? null
            : Customer.fromJson(json["merchantId"]),
        status: json["status"],
        customerLastname: json["customer_lastname"],
        customerAddress2: json["customer_address2"],
        customerName: json["customer_name"],
        subscriberCategoryId: json["subscriber_category_id"],
        subscriberCategoryName: json["subscriber_category_name"],
        customerEmail: json["customer_email"],
        customerPhoneNumber: json["customer_phone_number"],
        customerPhoneCode: json["customer_phone_code"],
        customerAddress: json["customer_address"],
        customerCity: json["customer_city"],
        customerPincode: json["customer_pincode"],
        userType: json["user_type"],
        userId: json["user_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "merchantId": merchantId?.toJson(),
        "status": status,
        "customer_lastname": customerLastname,
        "customer_address2": customerAddress2,
        "customer_name": customerName,
        "subscriber_category_id": subscriberCategoryId,
        "subscriber_category_name": subscriberCategoryName,
        "customer_email": customerEmail,
        "customer_phone_number": customerPhoneNumber,
        "customer_phone_code": customerPhoneCode,
        "customer_address": customerAddress,
        "customer_city": customerCity,
        "customer_pincode": customerPincode,
        "user_type": userType,
        "user_id": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

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

// // To parse this JSON data, do
// //
// //     final subscriptionsResponse = subscriptionsResponseFromJson(jsonString);

// import 'dart:convert';

// SubscriptionsResponse subscriptionsResponseFromJson(String str) =>
//     SubscriptionsResponse.fromJson(json.decode(str));

// String subscriptionsResponseToJson(SubscriptionsResponse data) =>
//     json.encode(data.toJson());

// class SubscriptionsResponse {
//   final int? code;
//   final SubscriptionData? data;
//   final String? message;
//   final bool? success;

//   SubscriptionsResponse({
//     this.code,
//     this.data,
//     this.message,
//     this.success,
//   });

//   SubscriptionsResponse copyWith({
//     int? code,
//     SubscriptionData? data,
//     String? message,
//     bool? success,
//   }) =>
//       SubscriptionsResponse(
//         code: code ?? this.code,
//         data: data ?? this.data,
//         message: message ?? this.message,
//         success: success ?? this.success,
//       );

//   factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) =>
//       SubscriptionsResponse(
//         code: json["code"],
//         data: json["data"] == null
//             ? null
//             : SubscriptionData.fromJson(json["data"]),
//         message: json["message"],
//         success: json["success"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "data": data?.toJson(),
//         "message": message,
//         "success": success,
//       };
// }

// class SubscriptionData {
//   final List<Subscription>? subscription;

//   SubscriptionData({
//     this.subscription,
//   });

//   SubscriptionData copyWith({
//     List<Subscription>? subscription,
//   }) =>
//       SubscriptionData(
//         subscription: subscription ?? this.subscription,
//       );

//   factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
//       SubscriptionData(
//         subscription: json["subscription"] == null
//             ? []
//             : List<Subscription>.from(
//                 json["subscription"]!.map((x) => Subscription.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "subscription": subscription == null
//             ? []
//             : List<dynamic>.from(subscription!.map((x) => x.toJson())),
//       };
// }

// class Subscription {
//   final String? id;
//   final String? adminId;
//   final MerchantId? merchantId;
//   final String? subscriptionType;
//   final String? status;
//   final List<PlanInfo>? planInfo;
//   final String? paymentStatus;
//   final String? customerLastname;
//   final String? customerAddress2;
//   final String? customerName;
//   final String? subscriberId;
//   final String? customerEmail;
//   final String? customerPhoneNumber;
//   final String? customerPhoneCode;
//   final String? customerAddress;
//   final String? customerCity;
//   final String? customerPincode;
//   final String? expired;
//   final String? userType;
//   final String? userId;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;
//   final String? paymentLink;

//   Subscription({
//     this.id,
//     this.adminId,
//     this.merchantId,
//     this.subscriptionType,
//     this.status,
//     this.planInfo,
//     this.paymentStatus,
//     this.customerLastname,
//     this.customerAddress2,
//     this.customerName,
//     this.subscriberId,
//     this.customerEmail,
//     this.customerPhoneNumber,
//     this.customerPhoneCode,
//     this.customerAddress,
//     this.customerCity,
//     this.customerPincode,
//     this.expired,
//     this.userType,
//     this.userId,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.paymentLink,
//   });

//   Subscription copyWith({
//     String? id,
//     String? adminId,
//     MerchantId? merchantId,
//     String? subscriptionType,
//     String? status,
//     List<PlanInfo>? planInfo,
//     String? paymentStatus,
//     String? customerLastname,
//     String? customerAddress2,
//     String? customerName,
//     String? subscriberId,
//     String? customerEmail,
//     String? customerPhoneNumber,
//     String? customerPhoneCode,
//     String? customerAddress,
//     String? customerCity,
//     String? customerPincode,
//     String? expired,
//     String? userType,
//     String? userId,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     int? v,
//     String? paymentLink,
//   }) =>
//       Subscription(
//         id: id ?? this.id,
//         adminId: adminId ?? this.adminId,
//         merchantId: merchantId ?? this.merchantId,
//         subscriptionType: subscriptionType ?? this.subscriptionType,
//         status: status ?? this.status,
//         planInfo: planInfo ?? this.planInfo,
//         paymentStatus: paymentStatus ?? this.paymentStatus,
//         customerLastname: customerLastname ?? this.customerLastname,
//         customerAddress2: customerAddress2 ?? this.customerAddress2,
//         customerName: customerName ?? this.customerName,
//         subscriberId: subscriberId ?? this.subscriberId,
//         customerEmail: customerEmail ?? this.customerEmail,
//         customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
//         customerPhoneCode: customerPhoneCode ?? this.customerPhoneCode,
//         customerAddress: customerAddress ?? this.customerAddress,
//         customerCity: customerCity ?? this.customerCity,
//         customerPincode: customerPincode ?? this.customerPincode,
//         expired: expired ?? this.expired,
//         userType: userType ?? this.userType,
//         userId: userId ?? this.userId,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         v: v ?? this.v,
//         paymentLink: paymentLink ?? this.paymentLink,
//       );

//   factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
//         id: json["_id"],
//         adminId: json["adminId"],
//         merchantId: json["merchantId"] == null
//             ? null
//             : MerchantId.fromJson(json["merchantId"]),
//         subscriptionType: json["subscription_type"],
//         status: json["status"],
//         planInfo: json["plan_info"] == null
//             ? []
//             : List<PlanInfo>.from(
//                 json["plan_info"]!.map((x) => PlanInfo.fromJson(x))),
//         paymentStatus: json["payment_status"],
//         customerLastname: json["customer_lastname"],
//         customerAddress2: json["customer_address2"],
//         customerName: json["customer_name"],
//         subscriberId: json["SubscriberId"],
//         customerEmail: json["customer_email"],
//         customerPhoneNumber: json["customer_phone_number"],
//         customerPhoneCode: json["customer_phone_code"],
//         customerAddress: json["customer_address"],
//         customerCity: json["customer_city"],
//         customerPincode: json["customer_pincode"],
//         expired: json["expired"],
//         userType: json["user_type"],
//         userId: json["user_id"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.tryParse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.tryParse(json["updatedAt"]),
//         v: json["__v"],
//         paymentLink: json["payment_link"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "adminId": adminId,
//         "merchantId": merchantId?.toJson(),
//         "subscription_type": subscriptionType,
//         "status": status,
//         "plan_info": planInfo == null
//             ? []
//             : List<dynamic>.from(planInfo!.map((x) => x.toJson())),
//         "payment_status": paymentStatus,
//         "customer_lastname": customerLastname,
//         "customer_address2": customerAddress2,
//         "customer_name": customerName,
//         "SubscriberId": subscriberId,
//         "customer_email": customerEmail,
//         "customer_phone_number": customerPhoneNumber,
//         "customer_phone_code": customerPhoneCode,
//         "customer_address": customerAddress,
//         "customer_city": customerCity,
//         "customer_pincode": customerPincode,
//         "expired": expired,
//         "user_type": userType,
//         "user_id": userId,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//         "payment_link": paymentLink,
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

class PlanInfo {
  // final String? planId;
  final String? allowedPaymentType;
  final String? paidAmount;
  final String? paymentStatus;
  final String? categoryName;
  final String? language;
  // final String? planName;
  final String? planPrice;
  final String? plansDurations;
  final String? planDesc;
  final DateTime? dueDate;
  final String? lateFeeValue;
  final String? discountType;
  final String? discountValue;
  String? remainingAmount;
  final String? planStatus;
  final String? categoryId;
  final String? status;
  final String? totalPayableAmount;
  final String? lateFeeAmount;
  final String? dueDays;
  final String? id;
  bool isSelected;
  String? payingAmount;
  String? planInfoId;
  DateTime? startDate;
  DateTime? endDate;
  final String? planDays;

  PlanInfo({
    // this.planId,
    this.allowedPaymentType,
    this.paidAmount,
    this.paymentStatus,
    this.categoryName,
    this.language,
    // this.planName,
    this.planPrice,
    this.plansDurations,
    this.planDesc,
    this.dueDate,
    this.lateFeeValue,
    this.discountType,
    this.discountValue,
    this.remainingAmount,
    this.planStatus,
    this.categoryId,
    this.status,
    this.totalPayableAmount,
    this.lateFeeAmount,
    this.dueDays,
    this.id,
    this.isSelected = false,
    this.payingAmount,
    this.planInfoId,
    this.startDate,
    this.endDate,
    this.planDays,
  });

  PlanInfo copyWith({
    // String? planId,
    String? allowedPaymentType,
    String? paidAmount,
    String? paymentStatus,
    String? categoryName,
    String? language,
    // String? planName,
    String? planPrice,
    String? plansDurations,
    String? planDesc,
    DateTime? dueDate,
    String? lateFeeValue,
    String? discountType,
    String? discountValue,
    String? remainingAmount,
    String? planStatus,
    String? categoryId,
    String? status,
    String? totalPayableAmount,
    String? lateFeeAmount,
    String? dueDays,
    String? id,
    String? planInfoId,
    DateTime? startDate,
    DateTime? endDate,
    String? planDays,
  }) =>
      PlanInfo(
        // planId: planId ?? this.planId,
        allowedPaymentType: allowedPaymentType ?? this.allowedPaymentType,
        paidAmount: paidAmount ?? this.paidAmount,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        categoryName: categoryName ?? this.categoryName,
        language: language ?? this.language,
        // planName: planName ?? this.planName,
        planPrice: planPrice ?? this.planPrice,
        plansDurations: plansDurations ?? this.plansDurations,
        planDesc: planDesc ?? this.planDesc,
        dueDate: dueDate ?? this.dueDate,
        lateFeeValue: lateFeeValue ?? this.lateFeeValue,
        discountType: discountType ?? this.discountType,
        discountValue: discountValue ?? this.discountValue,
        remainingAmount: remainingAmount ?? this.remainingAmount,
        planStatus: planStatus ?? this.planStatus,
        categoryId: categoryId ?? this.categoryId,
        status: status ?? this.status,
        totalPayableAmount: totalPayableAmount ?? this.totalPayableAmount,
        lateFeeAmount: lateFeeAmount ?? this.lateFeeAmount,
        dueDays: dueDays ?? this.dueDays,
        id: id ?? this.id,
        planInfoId: planInfoId ?? this.planInfoId,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        planDays: planDays ?? this.planDays,
      );

  factory PlanInfo.fromJson(Map<String, dynamic> json) => PlanInfo(
        // planId: json["plan_id"],
        allowedPaymentType: json["allowed_payment_type"],
        paidAmount: json["paid_amount"],
        paymentStatus: json["payment_status"],
        categoryName: json["category_name"],
        language: json["language"],
        // planName: json["plan_name"],
        planPrice: json["plan_price"],
        plansDurations: json["plans_durations"],
        planDesc: json["plan_desc"],
        dueDate: json["due_date"] == null
            ? null
            : DateTime.tryParse(json["due_date"]),
        lateFeeValue: json["late_fee_value"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        remainingAmount: json["remaining_amount"],
        planStatus: json["plan_status"],
        categoryId: json["category_id"],
        status: json["status"],
        totalPayableAmount: json["total_payable_amount"],
        lateFeeAmount: json["late_fee_amount"],
        dueDays: json["due_days"],
        id: json["_id"],
        planInfoId: json["plan_info_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.tryParse(json["start_date"]),
        endDate: json["end_date"] == null
            ? null
            : DateTime.tryParse(json["end_date"]),
        planDays: json["plan_days"],
      );

  Map<String, dynamic> toJson() => {
        // "plan_id": planId,
        "allowed_payment_type": allowedPaymentType,
        "paid_amount": paidAmount,
        "payment_status": paymentStatus,
        "category_name": categoryName,
        "language": language,
        // "plan_name": planName,
        "plan_price": planPrice,
        "plans_durations": plansDurations,
        "plan_desc": planDesc,
        "due_date": dueDate?.toIso8601String(),
        "late_fee_value": lateFeeValue,
        "discount_type": discountType,
        "discount_value": discountValue,
        "remaining_amount": remainingAmount,
        "plan_status": planStatus,
        "category_id": categoryId,
        "status": status,
        "total_payable_amount": totalPayableAmount,
        "late_fee_amount": lateFeeAmount,
        "due_days": dueDays,
        "_id": id,
        "plan_info_id": planInfoId,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "plan_days": planDays,
      };
}
