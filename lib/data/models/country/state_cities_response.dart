// To parse this JSON data, do
//
//     final stateCitiesResponse = stateCitiesResponseFromJson(jsonString);

import 'dart:convert';

StateCitiesResponse stateCitiesResponseFromJson(String str) =>
    StateCitiesResponse.fromJson(json.decode(str));

String stateCitiesResponseToJson(StateCitiesResponse data) =>
    json.encode(data.toJson());

class StateCitiesResponse {
  final int? code;
  final List<StateData>? data;
  final String? message;
  final bool? success;

  StateCitiesResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  StateCitiesResponse copyWith({
    int? code,
    List<StateData>? data,
    String? message,
    bool? success,
  }) =>
      StateCitiesResponse(
        code: code ?? this.code,
        data: data ?? this.data,
        message: message ?? this.message,
        success: success ?? this.success,
      );

  factory StateCitiesResponse.fromJson(Map<String, dynamic> json) =>
      StateCitiesResponse(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<StateData>.from(
                json["data"]!.map((x) => StateData.fromJson(x))),
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

class StateData {
  final String? id;
  final String? state;
  final String? countryId;
  final List<String>? cities;
  final String? countryName;

  StateData({
    this.id,
    this.state,
    this.countryId,
    this.cities,
    this.countryName,
  });

  StateData copyWith({
    String? id,
    String? state,
    String? countryId,
    List<String>? cities,
    String? countryName,
  }) =>
      StateData(
        id: id ?? this.id,
        state: state ?? this.state,
        countryId: countryId ?? this.countryId,
        cities: cities ?? this.cities,
        countryName: countryName ?? this.countryName,
      );

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
        id: json["_id"],
        state: json["state"],
        countryId: json["country_id"],
        cities: json["cities"] == null
            ? []
            : List<String>.from(json["cities"]!.map((x) => x)),
        countryName: json["country_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "state": state,
        "country_id": countryId,
        "cities":
            cities == null ? [] : List<dynamic>.from(cities!.map((x) => x)),
        "country_name": countryName,
      };
}
