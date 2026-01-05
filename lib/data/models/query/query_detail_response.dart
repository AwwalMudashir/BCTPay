// To parse this JSON data, do
//
//     final queriesDetailResponse = queriesDetailResponseFromJson(jsonString);

import 'package:bctpay/globals/index.dart';

QueryDetailResponse queriesDetailResponseFromJson(String str) =>
    QueryDetailResponse.fromJson(json.decode(str));

String queriesDetailResponseToJson(QueryDetailResponse data) =>
    json.encode(data.toJson());

class QueryDetailResponse {
  final int? code;
  final Query? data;
  final String? message;
  final bool? success;

  QueryDetailResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  QueryDetailResponse copyWith({
    int? code,
    Query? data,
    String? message,
    bool? success,
  }) =>
      QueryDetailResponse(
        code: code ?? this.code,
        data: data ?? this.data,
        message: message ?? this.message,
        success: success ?? this.success,
      );

  factory QueryDetailResponse.fromJson(Map<String, dynamic> json) =>
      QueryDetailResponse(
        code: json["code"],
        data: json["data"] == null ? null : Query.fromJson(json["data"]),
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

// class Data {
//   final String? id;
//   final String? adminId;
//   final String? name;
//   final String? tracingNo;
//   final String? email;
//   final String? userType;
//   final List<Message>? messages;
//   final String? phonenumber;
//   final String? customerId;
//   final String? assignAdminId;
//   final String? typeOfQueriesEn;
//   final String? typeOfQueriesGn;
//   final String? status;
//   final String? closeStatus;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Data({
//     this.id,
//     this.adminId,
//     this.name,
//     this.tracingNo,
//     this.email,
//     this.userType,
//     this.messages,
//     this.phonenumber,
//     this.customerId,
//     this.assignAdminId,
//     this.typeOfQueriesEn,
//     this.typeOfQueriesGn,
//     this.status,
//     this.closeStatus,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   Data copyWith({
//     String? id,
//     String? adminId,
//     String? name,
//     String? tracingNo,
//     String? email,
//     String? userType,
//     List<Message>? messages,
//     String? phonenumber,
//     String? customerId,
//     String? assignAdminId,
//     String? typeOfQueriesEn,
//     String? typeOfQueriesGn,
//     String? status,
//     String? closeStatus,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     int? v,
//   }) =>
//       Data(
//         id: id ?? this.id,
//         adminId: adminId ?? this.adminId,
//         name: name ?? this.name,
//         tracingNo: tracingNo ?? this.tracingNo,
//         email: email ?? this.email,
//         userType: userType ?? this.userType,
//         messages: messages ?? this.messages,
//         phonenumber: phonenumber ?? this.phonenumber,
//         customerId: customerId ?? this.customerId,
//         assignAdminId: assignAdminId ?? this.assignAdminId,
//         typeOfQueriesEn: typeOfQueriesEn ?? this.typeOfQueriesEn,
//         typeOfQueriesGn: typeOfQueriesGn ?? this.typeOfQueriesGn,
//         status: status ?? this.status,
//         closeStatus: closeStatus ?? this.closeStatus,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         v: v ?? this.v,
//       );

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["_id"],
//         adminId: json["adminId"],
//         name: json["name"],
//         tracingNo: json["tracing_no"],
//         email: json["email"],
//         userType: json["user_type"],
//         messages: json["messages"] == null
//             ? []
//             : List<Message>.from(
//                 json["messages"]!.map((x) => Message.fromJson(x))),
//         phonenumber: json["phonenumber"],
//         customerId: json["customerId"],
//         assignAdminId: json["assign_admin_id"],
//         typeOfQueriesEn: json["type_of_queries_en"],
//         typeOfQueriesGn: json["type_of_queries_gn"],
//         status: json["status"],
//         closeStatus: json["close_status"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "adminId": adminId,
//         "name": name,
//         "tracing_no": tracingNo,
//         "email": email,
//         "user_type": userType,
//         "messages": messages == null
//             ? []
//             : List<dynamic>.from(messages!.map((x) => x.toJson())),
//         "phonenumber": phonenumber,
//         "customerId": customerId,
//         "assign_admin_id": assignAdminId,
//         "type_of_queries_en": typeOfQueriesEn,
//         "type_of_queries_gn": typeOfQueriesGn,
//         "status": status,
//         "close_status": closeStatus,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Message {
//   final String? sender;
//   final String? senderId;
//   final String? receiverId;
//   final String? receiver;
//   final String? message;
//   final String? status;
//   final String? id;
//   final DateTime? createdAt;

//   Message({
//     this.sender,
//     this.senderId,
//     this.receiverId,
//     this.receiver,
//     this.message,
//     this.status,
//     this.id,
//     this.createdAt,
//   });

//   Message copyWith({
//     String? sender,
//     String? senderId,
//     String? receiverId,
//     String? receiver,
//     String? message,
//     String? status,
//     String? id,
//     DateTime? createdAt,
//   }) =>
//       Message(
//         sender: sender ?? this.sender,
//         senderId: senderId ?? this.senderId,
//         receiverId: receiverId ?? this.receiverId,
//         receiver: receiver ?? this.receiver,
//         message: message ?? this.message,
//         status: status ?? this.status,
//         id: id ?? this.id,
//         createdAt: createdAt ?? this.createdAt,
//       );

//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//         sender: json["sender"],
//         senderId: json["sender_id"],
//         receiverId: json["receiver_id"],
//         receiver: json["receiver"],
//         message: json["message"],
//         status: json["status"],
//         id: json["_id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "sender": sender,
//         "sender_id": senderId,
//         "receiver_id": receiverId,
//         "receiver": receiver,
//         "message": message,
//         "status": status,
//         "_id": id,
//         "created_at": createdAt?.toIso8601String(),
//       };
// }
