// To parse this JSON data, do
//
//     final thirdPartyListResponse = thirdPartyListResponseFromJson(jsonString);

import 'dart:convert';

ThirdPartyListResponse thirdPartyListResponseFromJson(String str) =>
    ThirdPartyListResponse.fromJson(json.decode(str));

String thirdPartyListResponseToJson(ThirdPartyListResponse data) =>
    json.encode(data.toJson());

class ThirdPartyListResponse {
  final int? code;
  final List<ThirdPartyListData>? data;
  final String? message;
  final bool? success;

  ThirdPartyListResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  factory ThirdPartyListResponse.fromJson(Map<String, dynamic> json) =>
      ThirdPartyListResponse(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<ThirdPartyListData>.from(
                json["data"]!.map((x) => ThirdPartyListData.fromJson(x))),
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

class ThirdPartyListData {
  final List<ThirdParty>? thirdParty;

  ThirdPartyListData({
    this.thirdParty,
  });

  factory ThirdPartyListData.fromJson(Map<String, dynamic> json) =>
      ThirdPartyListData(
        thirdParty: json["third_party"] == null
            ? []
            : List<ThirdParty>.from(
                json["third_party"]!.map((x) => ThirdParty.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "third_party": thirdParty == null
            ? []
            : List<dynamic>.from(thirdParty!.map((x) => x.toJson())),
      };
}

class ThirdParty {
  final String? language;
  final String? thirdPartyName;
  final String? id;

  ThirdParty({
    this.language,
    this.thirdPartyName,
    this.id,
  });

  factory ThirdParty.fromJson(Map<String, dynamic> json) => ThirdParty(
        language: json["language"],
        thirdPartyName: json["third_party_name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "third_party_name": thirdPartyName,
        "_id": id,
      };
}
