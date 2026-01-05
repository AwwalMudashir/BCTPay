class SetPrimaryAccountResponse {
  final int code;
  final PrimaryAccountData? data;
  final String message;
  final bool? success;

  SetPrimaryAccountResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory SetPrimaryAccountResponse.fromJson(Map<String, dynamic> json) =>
      SetPrimaryAccountResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : PrimaryAccountData.fromJson(json["data"]),
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

class PrimaryAccountData {
  final bool acknowledged;
  final int modifiedCount;
  final dynamic upsertedId;
  final int upsertedCount;
  final int matchedCount;

  PrimaryAccountData({
    required this.acknowledged,
    required this.modifiedCount,
    required this.upsertedId,
    required this.upsertedCount,
    required this.matchedCount,
  });

  factory PrimaryAccountData.fromJson(Map<String, dynamic> json) =>
      PrimaryAccountData(
        acknowledged: json["acknowledged"],
        modifiedCount: json["modifiedCount"],
        upsertedId: json["upsertedId"],
        upsertedCount: json["upsertedCount"],
        matchedCount: json["matchedCount"],
      );

  Map<String, dynamic> toJson() => {
        "acknowledged": acknowledged,
        "modifiedCount": modifiedCount,
        "upsertedId": upsertedId,
        "upsertedCount": upsertedCount,
        "matchedCount": matchedCount,
      };
}
