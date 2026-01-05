// To parse this JSON data, do
//
//     final paymentLinkResponseResponse = paymentLinkResponseResponseFromJson(jsonString);

import 'dart:convert';

PaymentLinkResponseResponse paymentLinkResponseResponseFromJson(String str) =>
    PaymentLinkResponseResponse.fromJson(json.decode(str));

String paymentLinkResponseResponseToJson(PaymentLinkResponseResponse data) =>
    json.encode(data.toJson());

class PaymentLinkResponseResponse {
  final int? code;
  final PaymentLinkData? data;
  final String? message;
  final bool? success;

  PaymentLinkResponseResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  factory PaymentLinkResponseResponse.fromJson(Map<String, dynamic> json) =>
      PaymentLinkResponseResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : PaymentLinkData.fromJson(json["data"]),
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

class PaymentLinkData {
  final String? id;
  final String? adminId;
  final String? merchantId;
  final String? titleForGn;
  final String? titleForEn;
  final String? descriptionForGn;
  final String? descriptionForEn;
  final String? webLink;
  final String? status;
  final DateTime? validFrom;
  final DateTime? validTill;
  final List<SlotInfo>? slotInfo;
  final String? eventRefNumber;
  final List<EventBannerInfo>? eventBannerInfo;
  final String? venueAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? paymentLink;
  final String? qrCode;
  final String? bannerImage;
  final String? bannerExtension;
  final String? ticketCounterViewStatus;

  PaymentLinkData({
    this.id,
    this.adminId,
    this.merchantId,
    this.titleForGn,
    this.titleForEn,
    this.descriptionForGn,
    this.descriptionForEn,
    this.webLink,
    this.status,
    this.validFrom,
    this.validTill,
    this.slotInfo,
    this.eventRefNumber,
    this.eventBannerInfo,
    this.venueAddress,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.paymentLink,
    this.qrCode,
    this.bannerImage,
    this.bannerExtension,
    this.ticketCounterViewStatus,
  });

  factory PaymentLinkData.fromJson(Map<String, dynamic> json) =>
      PaymentLinkData(
        id: json["_id"],
        adminId: json["adminId"],
        merchantId: json["merchantId"],
        titleForGn: json["title_for_gn"],
        titleForEn: json["title_for_en"],
        descriptionForGn: json["description_for_gn"],
        descriptionForEn: json["description_for_en"],
        webLink: json["web_link"],
        status: json["status"],
        validFrom: json["valid_from"] == null
            ? null
            : DateTime.parse(json["valid_from"]),
        validTill: json["valid_till"] == null
            ? null
            : DateTime.parse(json["valid_till"]),
        slotInfo: json["slot_info"] == null
            ? []
            : List<SlotInfo>.from(
                json["slot_info"]!.map((x) => SlotInfo.fromJson(x))),
        eventRefNumber: json["event_ref_number"],
        eventBannerInfo: json["event_banner_info"] == null
            ? []
            : List<EventBannerInfo>.from(json["event_banner_info"]!
                .map((x) => EventBannerInfo.fromJson(x))),
        venueAddress: json["venue_address"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        paymentLink: json["payment_link"],
        qrCode: json["qr_code"],
        bannerImage: json["banner_image"],
        bannerExtension: json["banner_extension"],
        ticketCounterViewStatus: json["ticket_counter_view_status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "merchantId": merchantId,
        "title_for_gn": titleForGn,
        "title_for_en": titleForEn,
        "description_for_gn": descriptionForGn,
        "description_for_en": descriptionForEn,
        "web_link": webLink,
        "status": status,
        "valid_from": validFrom?.toIso8601String(),
        "valid_till": validTill?.toIso8601String(),
        "slot_info": slotInfo == null
            ? []
            : List<dynamic>.from(slotInfo!.map((x) => x.toJson())),
        "event_ref_number": eventRefNumber,
        "event_banner_info": eventBannerInfo == null
            ? []
            : List<dynamic>.from(eventBannerInfo!.map((x) => x.toJson())),
        "venue_address": venueAddress,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "payment_link": paymentLink,
        "qr_code": qrCode,
        "banner_image": bannerImage,
        "banner_extension": bannerExtension,
        "ticket_counter_view_status": ticketCounterViewStatus,
      };
}

class EventBannerInfo {
  final String? imageName;
  final String? imageExtension;
  final String? status;
  final String? id;

  EventBannerInfo({
    this.imageName,
    this.imageExtension,
    this.status,
    this.id,
  });

  factory EventBannerInfo.fromJson(Map<String, dynamic> json) =>
      EventBannerInfo(
        imageName: json["image_name"],
        imageExtension: json["image_extension"],
        status: json["status"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "image_name": imageName,
        "image_extension": imageExtension,
        "status": status,
        "_id": id,
      };
}

class SlotInfo {
  final String? slotTypeEn;
  final String? slotTypeGn;
  final String? totalSlot;
  final String? perSlotPrice;
  final String? maxLimit;
  final String? remainingSlot;
  final String? slotStatus;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final String? id;
  final String? paymentStatus;
  int quantity;

  SlotInfo(
      {this.slotTypeEn,
      this.slotTypeGn,
      this.totalSlot,
      this.perSlotPrice,
      this.maxLimit,
      this.remainingSlot,
      this.slotStatus,
      this.startDateTime,
      this.endDateTime,
      this.id,
      this.paymentStatus,
      this.quantity = 1});

  factory SlotInfo.fromJson(Map<String, dynamic> json) => SlotInfo(
        slotTypeEn: json["slot_type_en"],
        slotTypeGn: json["slot_type_gn"],
        totalSlot: json["total_slot"].toString(),
        perSlotPrice: json["per_slot_price"],
        maxLimit: json["max_limit"],
        remainingSlot: json["remaining_slot"].toString(),
        slotStatus: json["slot_status"],
        startDateTime: json["start_date_time"] == null
            ? null
            : DateTime.parse(json["start_date_time"]),
        endDateTime: json["end_date_time"] == null
            ? null
            : DateTime.parse(json["end_date_time"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "slot_type_en": slotTypeEn,
        "slot_type_gn": slotTypeGn,
        "total_slot": totalSlot,
        "per_slot_price": perSlotPrice,
        "max_limit": maxLimit,
        "remaining_slot": remainingSlot,
        "slot_status": slotStatus,
        "start_date_time": startDateTime?.toIso8601String(),
        "end_date_time": endDateTime?.toIso8601String(),
        "_id": id,
      };
}
