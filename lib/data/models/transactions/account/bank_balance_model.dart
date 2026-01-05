class CheckBankBalanceResponse {
  final int code;
  final BalanceData? data;
  final String message;
  final bool? success;

  CheckBankBalanceResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory CheckBankBalanceResponse.fromJson(Map<String, dynamic> json) =>
      CheckBankBalanceResponse(
        code: json["code"],
        data: json["data"] == null ? null : BalanceData.fromJson(json["data"]),
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

class BalanceData {
  final int? responseCode;
  final String? responseMessage;
  final ResponseContent? responseContent;
  final DateTime? responseTimestamp;

  BalanceData({
    required this.responseCode,
    required this.responseMessage,
    required this.responseContent,
    required this.responseTimestamp,
  });

  factory BalanceData.fromJson(Map<String, dynamic> json) => BalanceData(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseContent: json["response_content"] == null
            ? null
            : ResponseContent.fromJson(json["response_content"]),
        responseTimestamp: json["response_timestamp"] == null
            ? null
            : DateTime.tryParse(json["response_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_message": responseMessage,
        "response_content": responseContent!.toJson(),
        "response_timestamp": responseTimestamp!.toIso8601String(),
      };
}

class ResponseContent {
  final HostHeaderInfo hostHeaderInfo;
  final String accountNo;
  final String responseCode;
  final String responseMessage;
  final String accountName;
  final String ccy;
  final String branchCode;
  final String customerId;
  final double availableBalance;
  final double currentBalance;
  final int odlimit;
  final String accountType;
  final String accountClass;
  final String accountStatus;

  ResponseContent({
    required this.hostHeaderInfo,
    required this.accountNo,
    required this.responseCode,
    required this.responseMessage,
    required this.accountName,
    required this.ccy,
    required this.branchCode,
    required this.customerId,
    required this.availableBalance,
    required this.currentBalance,
    required this.odlimit,
    required this.accountType,
    required this.accountClass,
    required this.accountStatus,
  });

  factory ResponseContent.fromJson(Map<String, dynamic> json) =>
      ResponseContent(
        hostHeaderInfo: HostHeaderInfo.fromJson(json["hostHeaderInfo"]),
        accountNo: json["accountNo"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        accountName: json["accountName"],
        ccy: json["ccy"],
        branchCode: json["branchCode"],
        customerId: json["customerID"],
        availableBalance: json["availableBalance"]?.toDouble(),
        currentBalance: json["currentBalance"]?.toDouble(),
        odlimit: json["odlimit"],
        accountType: json["accountType"],
        accountClass: json["accountClass"],
        accountStatus: json["accountStatus"],
      );

  Map<String, dynamic> toJson() => {
        "hostHeaderInfo": hostHeaderInfo.toJson(),
        "accountNo": accountNo,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "accountName": accountName,
        "ccy": ccy,
        "branchCode": branchCode,
        "customerID": customerId,
        "availableBalance": availableBalance,
        "currentBalance": currentBalance,
        "odlimit": odlimit,
        "accountType": accountType,
        "accountClass": accountClass,
        "accountStatus": accountStatus,
      };
}

class HostHeaderInfo {
  final String sourceCode;
  final String requestId;
  final String affiliateCode;
  final String responseCode;
  final String responseMessage;

  HostHeaderInfo({
    required this.sourceCode,
    required this.requestId,
    required this.affiliateCode,
    required this.responseCode,
    required this.responseMessage,
  });

  factory HostHeaderInfo.fromJson(Map<String, dynamic> json) => HostHeaderInfo(
        sourceCode: json["sourceCode"],
        requestId: json["requestId"],
        affiliateCode: json["affiliateCode"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
      );

  Map<String, dynamic> toJson() => {
        "sourceCode": sourceCode,
        "requestId": requestId,
        "affiliateCode": affiliateCode,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
      };
}
