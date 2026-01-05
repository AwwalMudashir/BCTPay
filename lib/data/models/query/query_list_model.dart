// To parse this JSON data, do
//
//     final queriesListResponse = queriesListResponseFromJson(jsonString);

import 'dart:convert';

QueriesListResponse queriesListResponseFromJson(String str) =>
    QueriesListResponse.fromJson(json.decode(str));

String queriesListResponseToJson(QueriesListResponse data) =>
    json.encode(data.toJson());

class QueriesListResponse {
  final int? code;
  final QueryListData? data;
  final String? message;
  final bool? success;

  QueriesListResponse({
    this.code,
    this.data,
    this.message,
    this.success,
  });

  QueriesListResponse copyWith({
    int? code,
    QueryListData? data,
    String? message,
    bool? success,
  }) =>
      QueriesListResponse(
        code: code ?? this.code,
        data: data ?? this.data,
        message: message ?? this.message,
        success: success ?? this.success,
      );

  factory QueriesListResponse.fromJson(Map<String, dynamic> json) =>
      QueriesListResponse(
        code: json["code"],
        data:
            json["data"] == null ? null : QueryListData.fromJson(json["data"]),
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

class QueryListData {
  final List<Query> querieslist;

  QueryListData({required this.querieslist});

  factory QueryListData.fromJson(Map<String, dynamic> json) => QueryListData(
      querieslist:
          List<Query>.from(json["querieslist"].map((e) => Query.fromJson(e))));

  Map<String, dynamic> toJson() => {
        "querieslist": querieslist.map((e) => e.toJson()).toList(),
      };
}

// class Query {
//   final Id? id;
//   final Id? adminId;
//   final String? name;
//   final String? tracingNo;
//   final String? email;
//   final String? userType;
//   final List<QueryMessage>? messages;
//   final String? phonenumber;
//   final Id? customerId;
//   final String? assignAdminId;
//   final String? typeOfQueriesEn;
//   final String? typeOfQueriesGn;
//   final String? status;
//   final String? closeStatus;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;

//   Query({
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

//   factory Query.fromJson(Map<String, dynamic> json) => Query(
//         id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
//         adminId: json["adminId"] == null ? null : Id.fromJson(json["adminId"]),
//         name: json["name"],
//         tracingNo: json["tracing_no"],
//         email: json["email"],
//         userType: json["user_type"],
//         messages: json["messages"] == null
//             ? []
//             : List<QueryMessage>.from(
//                 json["messages"]!.map((x) => QueryMessage.fromJson(x))),
//         phonenumber: json["phonenumber"],
//         customerId:
//             json["customerId"] == null ? null : Id.fromJson(json["customerId"]),
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
//         "_id": id?.toJson(),
//         "adminId": adminId?.toJson(),
//         "name": name,
//         "tracing_no": tracingNo,
//         "email": email,
//         "user_type": userType,
//         "messages": messages == null
//             ? []
//             : List<dynamic>.from(messages!.map((x) => x.toJson())),
//         "phonenumber": phonenumber,
//         "customerId": customerId?.toJson(),
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

// class Id {
//   final String? oid;

//   Id({
//     this.oid,
//   });

//   factory Id.fromJson(Map<String, dynamic> json) => Id(
//         oid: json["\u0024oid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "\u0024oid": oid,
//       };
// }

// class QueryMessage {
//   final String? sender;
//   final String? senderId;
//   final String? receiverId;
//   final List<QueryImage>? queryImage;
//   final String? receiver;
//   final String? message;
//   final String? status;
//   final Id? id;
//   final DateTime? createdAt;

//   QueryMessage({
//     this.sender,
//     this.senderId,
//     this.receiverId,
//     this.queryImage,
//     this.receiver,
//     this.message,
//     this.status,
//     this.id,
//     this.createdAt,
//   });

//   factory QueryMessage.fromJson(Map<String, dynamic> json) => QueryMessage(
//         sender: json["sender"],
//         senderId: json["sender_id"],
//         receiverId: json["receiver_id"],
//         queryImage: json["query_image"] == null
//             ? []
//             : List<QueryImage>.from(
//                 json["query_image"]!.map((x) => QueryImage.fromJson(x))),
//         receiver: json["receiver"],
//         message: json["message"],
//         status: json["status"],
//         id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.tryParse(json["created_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "sender": sender,
//         "sender_id": senderId,
//         "receiver_id": receiverId,
//         "query_image": queryImage == null
//             ? []
//             : List<dynamic>.from(queryImage!.map((x) => x.toJson())),
//         "receiver": receiver,
//         "message": message,
//         "status": status,
//         "_id": id?.toJson(),
//         "created_at": createdAt?.toIso8601String(),
//       };
// }

// class QueryImage {
//   final String? imageName;
//   final String? imageExtension;
//   final Id? id;

//   QueryImage({
//     this.imageName,
//     this.imageExtension,
//     this.id,
//   });

//   factory QueryImage.fromJson(Map<String, dynamic> json) => QueryImage(
//         imageName: json["image_name"],
//         imageExtension: json["image_extension"],
//         id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "image_name": imageName,
//         "image_extension": imageExtension,
//         "_id": id?.toJson(),
//       };
// }

class Query {
  final String? id;
  final String? adminId;
  final String? name;
  final String? tracingNo;
  final String? email;
  final String? userType;
  final List<QueryMessage>? messages;
  final String? phonenumber;
  final String? customerId;
  final String? assignAdminId;
  final String? typeOfQueriesEn;
  final String? typeOfQueriesGn;
  final String? status;
  final String? closeStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? isAttachmentAllowed;

  Query({
    this.id,
    this.adminId,
    this.name,
    this.tracingNo,
    this.email,
    this.userType,
    this.messages,
    this.phonenumber,
    this.customerId,
    this.assignAdminId,
    this.typeOfQueriesEn,
    this.typeOfQueriesGn,
    this.status,
    this.closeStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isAttachmentAllowed,
  });

  Query copyWith({
    String? id,
    String? adminId,
    String? name,
    String? tracingNo,
    String? email,
    String? userType,
    List<QueryMessage>? messages,
    String? phonenumber,
    String? customerId,
    String? assignAdminId,
    String? typeOfQueriesEn,
    String? typeOfQueriesGn,
    String? status,
    String? closeStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? isAttachmentAllowed,
  }) =>
      Query(
        id: id ?? this.id,
        adminId: adminId ?? this.adminId,
        name: name ?? this.name,
        tracingNo: tracingNo ?? this.tracingNo,
        email: email ?? this.email,
        userType: userType ?? this.userType,
        messages: messages ?? this.messages,
        phonenumber: phonenumber ?? this.phonenumber,
        customerId: customerId ?? this.customerId,
        assignAdminId: assignAdminId ?? this.assignAdminId,
        typeOfQueriesEn: typeOfQueriesEn ?? this.typeOfQueriesEn,
        typeOfQueriesGn: typeOfQueriesGn ?? this.typeOfQueriesGn,
        status: status ?? this.status,
        closeStatus: closeStatus ?? this.closeStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        isAttachmentAllowed: isAttachmentAllowed ?? this.isAttachmentAllowed,
      );

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        id: json["_id"],
        adminId: json["adminId"],
        name: json["name"],
        tracingNo: json["tracing_no"],
        email: json["email"],
        userType: json["user_type"],
        messages: json["messages"] == null
            ? []
            : List<QueryMessage>.from(
                json["messages"]!.map((x) => QueryMessage.fromJson(x))),
        phonenumber: json["phonenumber"],
        customerId: json["customerId"],
        assignAdminId: json["assign_admin_id"],
        typeOfQueriesEn: json["type_of_queries_en"],
        typeOfQueriesGn: json["type_of_queries_gn"],
        status: json["status"],
        closeStatus: json["close_status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isAttachmentAllowed: json["is_attachment_allowed"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adminId": adminId,
        "name": name,
        "tracing_no": tracingNo,
        "email": email,
        "user_type": userType,
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
        "phonenumber": phonenumber,
        "customerId": customerId,
        "assign_admin_id": assignAdminId,
        "type_of_queries_en": typeOfQueriesEn,
        "type_of_queries_gn": typeOfQueriesGn,
        "status": status,
        "close_status": closeStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "is_attachment_allowed": isAttachmentAllowed,
      };
}

class QueryMessage {
  final String? sender;
  final String? senderId;
  final String? senderName;
  final String? receiverId;
  final String? receiver;
  final String? message;
  final List<QueryImage>? queryImage;
  final String? status;
  final String? id;
  final DateTime? createdAt;

  QueryMessage({
    this.sender,
    this.senderId,
    this.senderName,
    this.receiverId,
    this.receiver,
    this.message,
    this.queryImage,
    this.status,
    this.id,
    this.createdAt,
  });

  QueryMessage copyWith({
    String? sender,
    String? senderId,
    String? senderName,
    String? receiverId,
    String? receiver,
    String? message,
    List<QueryImage>? queryImage,
    String? status,
    String? id,
    DateTime? createdAt,
  }) =>
      QueryMessage(
        sender: sender ?? this.sender,
        senderId: senderId ?? this.senderId,
        senderName: senderName ?? this.senderName,
        receiverId: receiverId ?? this.receiverId,
        receiver: receiver ?? this.receiver,
        message: message ?? this.message,
        queryImage: queryImage ?? this.queryImage,
        status: status ?? this.status,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
      );

  factory QueryMessage.fromJson(Map<String, dynamic> json) => QueryMessage(
        sender: json["sender"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        senderName: json["sender_name"],
        receiver: json["receiver"],
        message: json["message"],
        queryImage: json["query_image"] == null
            ? []
            : List<QueryImage>.from(
                json["query_image"]!.map((x) => QueryImage.fromJson(x))),
        status: json["status"],
        id: json["_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "sender_id": senderId,
        "sender_name": senderName,
        "receiver_id": receiverId,
        "receiver": receiver,
        "message": message,
        "query_image": queryImage == null
            ? []
            : List<dynamic>.from(queryImage!.map((x) => x.toJson())),
        "status": status,
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
      };
}

class QueryImage {
  final String? imageName;
  final String? imageExtension;
  final String? id;

  QueryImage({
    this.imageName,
    this.imageExtension,
    this.id,
  });

  factory QueryImage.fromJson(Map<String, dynamic> json) => QueryImage(
        imageName: json["image_name"],
        imageExtension: json["image_extension"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "image_name": imageName,
        "image_extension": imageExtension,
        "_id": id,
      };
}
