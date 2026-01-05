import 'package:bctpay/lib.dart';

NotificationsListResponse notificationsListResponseFromJson(String str) =>
    NotificationsListResponse.fromJson(json.decode(str));

String notificationsListResponseToJson(NotificationsListResponse data) =>
    json.encode(data.toJson());

class NotificationsListResponse {
  final int code;
  final NotificationListData? data;
  final String message;
  final bool? success;

  NotificationsListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory NotificationsListResponse.fromJson(Map<String, dynamic> json) =>
      NotificationsListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : NotificationListData.fromJson(json["data"]),
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

class NotificationListData {
  final List<NotificationData> filteredNotifications;
  final int unreadnotificationscount;
  final int totalNotificationscount;

  NotificationListData({
    required this.filteredNotifications,
    required this.unreadnotificationscount,
    required this.totalNotificationscount,
  });

  factory NotificationListData.fromJson(Map<String, dynamic> json) =>
      NotificationListData(
        filteredNotifications: List<NotificationData>.from(
            json["filteredNotifications"]
                .map((x) => NotificationData.fromJson(x))),
        unreadnotificationscount: json["unreadNotificationsCount"],
        totalNotificationscount: json["totalNotificationsCount"],
      );

  Map<String, dynamic> toJson() => {
        "filteredNotifications":
            List<dynamic>.from(filteredNotifications.map((x) => x.toJson())),
        "unreadnotificationscount": unreadnotificationscount,
        "totalNotificationscount": totalNotificationscount,
      };
}

class NotificationData {
  final String id;
  final String recipient;
  final String notificationType;
  final String notificationTitle;
  final String notificationDesc;
  final String? eventId;
  final String status;
  final String view;
  final String read;
  final String? createdbyUserRole;
  final String? createdbyUserName;
  final String? createdbyUserEmail;
  final String? createdbyUserProfilePic;
  final String? updatedbyUserRole;
  final String? updatedbyUserName;
  final String? updatedbyUserEmail;
  final String? updatedbyUserProfilePic;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  NotificationData({
    required this.id,
    required this.recipient,
    required this.notificationType,
    required this.notificationTitle,
    required this.notificationDesc,
    required this.eventId,
    required this.status,
    required this.view,
    required this.read,
    required this.createdbyUserRole,
    required this.createdbyUserName,
    required this.createdbyUserEmail,
    required this.createdbyUserProfilePic,
    required this.updatedbyUserRole,
    required this.updatedbyUserName,
    required this.updatedbyUserEmail,
    required this.updatedbyUserProfilePic,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["_id"],
        recipient: json["recipient"],
        notificationType: json["notification_type"],
        notificationTitle: json["notification_title"],
        notificationDesc: json["notification_desc"],
        eventId: json["event_id"],
        status: json["status"],
        view: json["view"],
        read: json["read"],
        createdbyUserRole: json["createdby_user_role"],
        createdbyUserName: json["createdby_user_name"],
        createdbyUserEmail: json["createdby_user_email"],
        createdbyUserProfilePic: json["createdby_user_profile_pic"],
        updatedbyUserRole: json["updatedby_user_role"],
        updatedbyUserName: json["updatedby_user_name"],
        updatedbyUserEmail: json["updatedby_user_email"],
        updatedbyUserProfilePic: json["updatedby_user_profile_pic"],
        createdAt: DateTime.tryParse(json["createdAt"]),
        updatedAt: DateTime.tryParse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "recipient": recipient,
        "notification_type": notificationType,
        "notification_title": notificationTitle,
        "notification_desc": notificationDesc,
        "event_id": eventId,
        "status": status,
        "view": view,
        "read": read,
        "createdby_user_role": createdbyUserRole,
        "createdby_user_name": createdbyUserName,
        "createdby_user_email": createdbyUserEmail,
        "createdby_user_profile_pic": createdbyUserProfilePic,
        "updatedby_user_role": updatedbyUserRole,
        "updatedby_user_name": updatedbyUserName,
        "updatedby_user_email": updatedbyUserEmail,
        "updatedby_user_profile_pic": updatedbyUserProfilePic,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
