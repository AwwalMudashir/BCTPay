class SendMoneyResponse {
  final String responseCode;
  final String responseMessage;
  final String refNo;
  final String status;

  SendMoneyResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.refNo,
    required this.status,
  });

  factory SendMoneyResponse.fromJson(Map<String, dynamic> json) =>
      SendMoneyResponse(
        responseCode: json["responseCode"] ?? "",
        responseMessage: json["responseMessage"] ?? "",
        refNo: json["refNo"] ?? "",
        status: json["status"] ?? "",
      );
}

