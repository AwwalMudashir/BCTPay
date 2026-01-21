class BankLookupResponse {
  final String code;
  final String desc;
  final List<BankInfo> list;

  BankLookupResponse({
    required this.code,
    required this.desc,
    required this.list,
  });

  bool get isSuccess =>
      code == "00" || code == "000" || code.toUpperCase() == "SUCCESS";

  factory BankLookupResponse.fromJson(Map<String, dynamic> json) {
    final listJson = json["list"] as List? ?? [];
    return BankLookupResponse(
      code: json["code"]?.toString() ?? "",
      desc: json["desc"]?.toString() ?? "",
      list: listJson.map((e) => BankInfo.fromJson(e)).toList(),
    );
  }
}

class BankInfo {
  final String code;
  final String name;

  BankInfo({
    required this.code,
    required this.name,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        code: json["code"]?.toString() ?? "",
        name: json["name"]?.toString() ?? "",
      );
}

