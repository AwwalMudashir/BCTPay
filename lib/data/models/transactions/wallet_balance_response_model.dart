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

  /// Core wallet/coin response additions
  final List<WalletAccount> wallets;
  final List<WalletAccount> coins;
  final double totalBalance;
  final String ccy;
  final String lcy;
  final double lcyBalance;

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
    required this.wallets,
    required this.coins,
    required this.totalBalance,
    required this.ccy,
    required this.lcy,
    required this.lcyBalance,
  });

  List<WalletAccount> get allAccounts => [...wallets, ...coins];

  WalletAccount? get primaryAccount =>
      allAccounts.firstWhere((e) => e.primaryWallet, orElse: () {
        if (allAccounts.isNotEmpty) return allAccounts.first;
        return WalletAccount.empty();
      });

  factory WalletBalanceResponse.fromJson(Map<String, dynamic> json) {
    final walletsJson = json["wallets"] as List? ?? [];
    final coinsJson = json["coins"] as List? ?? [];
    final parsedWallets =
        walletsJson.map((e) => WalletAccount.fromJson(e)).toList();
    final parsedCoins = coinsJson.map((e) => WalletAccount.fromJson(e)).toList();

    String? fallbackCcy = json["ccyCode"]?.toString();
    if ((fallbackCcy == null || fallbackCcy.isEmpty) && parsedWallets.isNotEmpty) {
      fallbackCcy = parsedWallets.first.lcyCcy.isNotEmpty
          ? parsedWallets.first.lcyCcy
          : parsedWallets.first.symbol;
    }

    String? fallbackAccountType = json["accountType"]?.toString();
    if ((fallbackAccountType == null || fallbackAccountType.isEmpty) &&
        parsedWallets.isNotEmpty) {
      fallbackAccountType = parsedWallets.first.accountType;
    }

    String? fallbackAccountNo = json["accountNo"]?.toString();
    if ((fallbackAccountNo == null || fallbackAccountNo.isEmpty) &&
        parsedWallets.isNotEmpty) {
      fallbackAccountNo = parsedWallets.first.accountNo;
    }

    final balanceValue = _toDouble(
      json["balance"] ??
          json["totalBalance"] ??
          json["lcyBalance"] ??
          json["usdBalance"],
    );

    return WalletBalanceResponse(
      responseCode: json["responseCode"]?.toString() ??
          json["code"]?.toString() ??
          "",
      responseMessage: json["responseMessage"]?.toString() ??
          json["desc"]?.toString() ??
          "",
      accountType: fallbackAccountType ?? "",
      accountNo: fallbackAccountNo ?? "",
      commAccountNo: json["commAccountNo"]?.toString() ?? "",
      commBalance: _toDouble(json["commBalance"]),
      ccyCode: fallbackCcy ?? "",
      accountRef: json["accountRef"]?.toString() ?? "",
      accountName: json["accountName"]?.toString() ??
          (parsedWallets.isNotEmpty ? parsedWallets.first.name : ""),
      bankName: json["bankName"]?.toString() ?? "",
      bvn: json["bvn"]?.toString() ?? "",
      balance: balanceValue,
      commission: _toDouble(json["commission"]),
      loanBalance: _toDouble(json["loanBalance"]),
      wallets: parsedWallets,
      coins: parsedCoins,
      totalBalance: _toDouble(json["totalBalance"]),
      ccy: json["ccy"]?.toString() ?? fallbackCcy ?? "",
      lcy: json["lcy"]?.toString() ?? "",
      lcyBalance: _toDouble(json["lcyBalance"] ?? json["balance"]),
    );
  }
}

class WalletAccount {
  final int? id;
  final String accountNo;
  final String virtualAccountNo;
  final String accountType;
  final String entityCode;
  final String symbol;
  final String chain;
  final String username;
  final String publicAddress;
  final String name;
  final String label;
  final double balance;
  final double usdBalance;
  final double lcyBalance;
  final String lcyCcy;
  final String logo;
  final String status;
  final bool primaryWallet;

  WalletAccount({
    required this.id,
    required this.accountNo,
    required this.virtualAccountNo,
    required this.accountType,
    required this.entityCode,
    required this.symbol,
    required this.chain,
    required this.username,
    required this.publicAddress,
    required this.name,
    required this.label,
    required this.balance,
    required this.usdBalance,
    required this.lcyBalance,
    required this.lcyCcy,
    required this.logo,
    required this.status,
    required this.primaryWallet,
  });

  factory WalletAccount.fromJson(Map<String, dynamic> json) => WalletAccount(
        id: json["id"] is int
            ? json["id"]
            : int.tryParse(json["id"]?.toString() ?? ""),
        accountNo: json["accountNo"]?.toString() ?? "",
        virtualAccountNo: json["virtualAccountNo"]?.toString() ?? "",
        accountType: json["accountType"]?.toString() ?? "",
        entityCode: json["entityCode"]?.toString() ?? "",
        symbol: json["symbol"]?.toString() ?? "",
        chain: json["chain"]?.toString() ?? "",
        username: json["username"]?.toString() ?? "",
        publicAddress: json["publicAddress"]?.toString() ?? "",
        name: json["name"]?.toString() ?? "",
        label: json["label"]?.toString() ?? "",
        balance: _toDouble(json["balance"]),
        usdBalance: _toDouble(json["usdBalance"]),
        lcyBalance: _toDouble(json["lcyBalance"]),
        lcyCcy: json["lcyCcy"]?.toString() ?? "",
        logo: json["logo"]?.toString() ?? "",
        status: json["status"]?.toString() ?? "",
        primaryWallet: json["primaryWallet"] == true ||
            json["primaryWallet"]?.toString().toLowerCase() == "true",
      );

  factory WalletAccount.empty() => WalletAccount(
        id: null,
        accountNo: "",
        virtualAccountNo: "",
        accountType: "",
        entityCode: "",
        symbol: "",
        chain: "",
        username: "",
        publicAddress: "",
        name: "",
        label: "",
        balance: 0,
        usdBalance: 0,
        lcyBalance: 0,
        lcyCcy: "",
        logo: "",
        status: "",
        primaryWallet: false,
      );
}

double _toDouble(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0;
}

