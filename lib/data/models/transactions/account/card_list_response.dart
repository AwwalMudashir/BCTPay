// To parse this JSON data, do
//
//     final cardsListResponse = cardsListResponseFromJson(jsonString);

import 'dart:convert';

CardsListResponse cardsListResponseFromJson(String str) =>
    CardsListResponse.fromJson(json.decode(str));

String cardsListResponseToJson(CardsListResponse data) =>
    json.encode(data.toJson());

class CardsListResponse {
  final int? code;
  final List<CardData>? data;
  final String? message;
  final bool? success;

  CardsListResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  factory CardsListResponse.fromJson(Map<String, dynamic> json) =>
      CardsListResponse(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<CardData>.from(
                json["data"]!.map((x) => CardData.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class CardData {
  final String? alias;
  final String? cardOnFileId;
  final String? last4Digits;
  final DateTime? expires;
  final String? status;
  final String? bin;
  final int? userId;
  final String? externalUniqueId;

  CardData({
    this.alias,
    this.cardOnFileId,
    this.last4Digits,
    this.expires,
    this.status,
    this.bin,
    this.userId,
    this.externalUniqueId,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
        alias: json["alias"],
        cardOnFileId: json["cardOnFileId"],
        last4Digits: json["last4Digits"],
        expires:
            json["expires"] == null ? null : DateTime.parse(json["expires"]),
        status: json["status"],
        bin: json["bin"],
        userId: json["userId"],
        externalUniqueId: json["externalUniqueId"],
      );

  Map<String, dynamic> toJson() => {
        "alias": alias,
        "cardOnFileId": cardOnFileId,
        "last4Digits": last4Digits,
        "expires": expires?.toIso8601String(),
        "status": status,
        "bin": bin,
        "userId": userId,
        "externalUniqueId": externalUniqueId,
      };
}
