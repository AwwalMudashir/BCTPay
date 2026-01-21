class SendMoneyResponse {
  final String responseCode;
  final String responseMessage;
  final String refNo;
  final String status;
  final String codeString;

  SendMoneyResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.refNo,
    required this.status,
    required this.codeString,
  });

  bool get isSuccess =>
      codeString == "00" ||
      codeString == "000" ||
      responseCode == "00" ||
      responseCode == "000" ||
      responseCode == "SUCCESS";

  factory SendMoneyResponse.fromJson(Map<String, dynamic> json) {
    final rc = json["responseCode"]?.toString() ?? json["code"]?.toString() ?? "";
    final msg = json["responseMessage"]?.toString() ??
        json["desc"]?.toString() ??
        json["message"]?.toString() ??
        "";
    return SendMoneyResponse(
      responseCode: rc,
      codeString: rc,
      responseMessage: msg,
      refNo: json["refNo"]?.toString() ?? json["id"]?.toString() ?? "",
      status: json["status"]?.toString() ??
          (msg.toUpperCase().contains("SUCCESS") ? "SUCCESS" : ""),
    );
  }
}

