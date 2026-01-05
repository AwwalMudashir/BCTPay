// To parse this JSON data, do
//
//     final queryTypeResponse = queryTypeResponseFromJson(jsonString);

import 'dart:convert';

QueryTypeResponse queryTypeResponseFromJson(String str) =>
    QueryTypeResponse.fromJson(json.decode(str));

String queryTypeResponseToJson(QueryTypeResponse data) =>
    json.encode(data.toJson());

class QueryTypeResponse {
  final int? code;
  final List<QueryType>? data;
  final String? message;
  final bool? success;

  QueryTypeResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  QueryTypeResponse copyWith({
    int? code,
    List<QueryType>? data,
    String? message,
    bool? success,
  }) =>
      QueryTypeResponse(
        code: code ?? this.code,
        data: data ?? this.data,
        message: message ?? this.message,
        success: success ?? this.success,
      );

  factory QueryTypeResponse.fromJson(Map<String, dynamic> json) =>
      QueryTypeResponse(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<QueryType>.from(
                json["data"]!.map((x) => QueryType.fromJson(x))),
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

class QueryType {
  final String? id;
  final String? adminId;
  final String? status;
  final String? typeOfQueriesEn;
  final String? typeOfQueriesGn;
  final String? deleteStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  QueryType({
    this.id,
    this.adminId,
    this.status,
    this.typeOfQueriesEn,
    this.typeOfQueriesGn,
    this.deleteStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  QueryType copyWith({
    String? id,
    String? adminId,
    String? status,
    String? typeOfQueriesEn,
    String? typeOfQueriesGn,
    String? deleteStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      QueryType(
        id: id ?? this.id,
        adminId: adminId ?? this.adminId,
        status: status ?? this.status,
        typeOfQueriesEn: typeOfQueriesEn ?? this.typeOfQueriesEn,
        typeOfQueriesGn: typeOfQueriesGn ?? this.typeOfQueriesGn,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory QueryType.fromJson(Map<String, dynamic> json) => QueryType(
        id: json["_id"],
        adminId: json["adminId"],
        status: json["status"],
        typeOfQueriesEn: json["type_of_queries_en"],
        typeOfQueriesGn: json["type_of_queries_gn"],
        deleteStatus: json["delete_status"],
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
        "status": status,
        "type_of_queries_en": typeOfQueriesEn,
        "type_of_queries_gn": typeOfQueriesGn,
        "delete_status": deleteStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
