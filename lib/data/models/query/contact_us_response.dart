class ContactUsResponse {
  final int code;
  // final BanksListData? data;
  final String message;
  final bool? success;

  ContactUsResponse({
    required this.code,
    // required this.data,
    required this.message,
    required this.success,
  });

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) =>
      ContactUsResponse(
        code: json["code"],
        // data:
        //     json["data"] == null ? null : BanksListData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        // "data": data?.toJson(),
        "message": message,
        "success": success,
      };
}
