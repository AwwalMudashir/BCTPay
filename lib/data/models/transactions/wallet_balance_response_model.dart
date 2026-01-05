class WalletBalanceResponse {
  final String responseCode;
  final String responseMessage;
  final String accountType;
  final String accountNo;
  final String commAccountNo;
  final double commBalance;
  final String ccyCode;
  final String accountRef;
  final String accountName;
  final String bankName;
  final String bvn;
  final double balance;
  final double commission;
  final double loanBalance;

  WalletBalanceResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.accountType,
    required this.accountNo,
    required this.commAccountNo,
    required this.commBalance,
    required this.ccyCode,
    required this.accountRef,
    required this.accountName,
    required this.bankName,
    required this.bvn,
    required this.balance,
    required this.commission,
    required this.loanBalance,
  });

  factory WalletBalanceResponse.fromJson(Map<String, dynamic> json) =>
      WalletBalanceResponse(
        responseCode: json["responseCode"] ?? "",
        responseMessage: json["responseMessage"] ?? "",
        accountType: json["accountType"] ?? "",
        accountNo: json["accountNo"] ?? "",
        commAccountNo: json["commAccountNo"] ?? "",
        commBalance: (json["commBalance"] ?? 0).toDouble(),
        ccyCode: json["ccyCode"] ?? "",
        accountRef: json["accountRef"] ?? "",
        accountName: json["accountName"] ?? "",
        bankName: json["bankName"] ?? "",
        bvn: json["bvn"] ?? "",
        balance: (json["balance"] ?? 0).toDouble(),
        commission: (json["commission"] ?? 0).toDouble(),
        loanBalance: (json["loanBalance"] ?? 0).toDouble(),
      );
}

