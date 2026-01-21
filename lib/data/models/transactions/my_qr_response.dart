class MyQrResponse {
  final String qrCode;
  final String responseCode;
  final String responseMessage;

  MyQrResponse({
    required this.qrCode,
    required this.responseCode,
    required this.responseMessage,
  });

  factory MyQrResponse.fromJson(Map<String, dynamic> json) => MyQrResponse(
        qrCode: json["qrCode"] ?? "",
        responseCode: json["responseCode"] ?? "",
        responseMessage: json["responseMessage"] ?? "",
      );
}
