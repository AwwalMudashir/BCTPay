class PaymentLinkGenerateResponse {
  final int? id;
  final String? accountNo;
  final String? virtualAccountNo;
  final String? accountType;
  final String? entityCode;
  final String? symbol;
  final String? chain;
  final String? username;
  final String? publicAddress;
  final String? name;
  final String? label;
  final num? balance;
  final num? usdBalance;
  final num? lcyBalance;
  final String? lcyCcy;
  final String? logo;
  final String? status;
  final bool? primaryWallet;

  PaymentLinkGenerateResponse({
    this.id,
    this.accountNo,
    this.virtualAccountNo,
    this.accountType,
    this.entityCode,
    this.symbol,
    this.chain,
    this.username,
    this.publicAddress,
    this.name,
    this.label,
    this.balance,
    this.usdBalance,
    this.lcyBalance,
    this.lcyCcy,
    this.logo,
    this.status,
    this.primaryWallet,
  });

  factory PaymentLinkGenerateResponse.fromJson(Map<String, dynamic> json) {
    return PaymentLinkGenerateResponse(
      id: json["id"],
      accountNo: json["accountNo"],
      virtualAccountNo: json["virtualAccountNo"],
      accountType: json["accountType"],
      entityCode: json["entityCode"],
      symbol: json["symbol"],
      chain: json["chain"],
      username: json["username"],
      publicAddress: json["publicAddress"],
      name: json["name"],
      label: json["label"],
      balance: json["balance"],
      usdBalance: json["usdBalance"],
      lcyBalance: json["lcyBalance"],
      lcyCcy: json["lcyCcy"],
      logo: json["logo"],
      status: json["status"],
      primaryWallet: json["primaryWallet"],
    );
  }
}
