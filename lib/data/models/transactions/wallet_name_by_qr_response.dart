class WalletNameByQrResponse {
  final String responseCode;
  final String responseMessage;
  final String accountType;
  final String accountNo;
  final String ccyCode;
  final String accountName;

  WalletNameByQrResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.accountType,
    required this.accountNo,
    required this.ccyCode,
    required this.accountName,
  });

  factory WalletNameByQrResponse.fromJson(Map<String, dynamic> json) =>
      WalletNameByQrResponse(
        responseCode: json["responseCode"] ?? "",
        responseMessage: json["responseMessage"] ?? "",
        accountType: json["accountType"] ?? "",
        accountNo: json["accountNo"] ?? "",
        ccyCode: json["ccyCode"] ?? "",
        accountName: json["accountName"] ?? "",
      );
}
