class BeneficiaryFetchResponse {
  final String responseCode;
  final String responseMessage;
  final int totalRecords;
  final int pageNumber;
  final int pageSize;
  final List<BeneficiaryItem> beneficiaryList;

  BeneficiaryFetchResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.totalRecords,
    required this.pageNumber,
    required this.pageSize,
    required this.beneficiaryList,
  });

  bool get isSuccess =>
      responseCode == "00" ||
      responseCode == "000" ||
      responseCode.toUpperCase() == "SUCCESS";

  factory BeneficiaryFetchResponse.fromJson(Map<String, dynamic> json) {
    final listJson = (json["data"] as List?) ??
        (json["beneficiaryList"] as List?) ??
        [];
    return BeneficiaryFetchResponse(
      responseCode:
          json["responseCode"]?.toString() ?? json["code"]?.toString() ?? "",
      responseMessage:
          json["responseMessage"]?.toString() ?? json["desc"]?.toString() ?? "",
      totalRecords: _toInt(json["totalRecords"]),
      pageNumber: _toInt(json["pageNumber"]),
      pageSize: _toInt(json["pageSize"]),
      beneficiaryList:
          listJson.map((e) => BeneficiaryItem.fromJson(e)).toList(),
    );
  }
}

class BeneficiaryItem {
  final String id;
  final String beneficiaryName;
  final String beneficiaryAccountNo;
  final String beneficiaryBankName;
  final String beneficiaryBankCode;
  final String status;

  BeneficiaryItem({
    required this.id,
    required this.beneficiaryName,
    required this.beneficiaryAccountNo,
    required this.beneficiaryBankName,
    required this.beneficiaryBankCode,
    required this.status,
  });

  factory BeneficiaryItem.fromJson(Map<String, dynamic> json) => BeneficiaryItem(
        id: json["id"]?.toString() ?? "",
        beneficiaryName: json["beneficiaryName"]?.toString() ?? "",
        beneficiaryAccountNo: json["beneficiaryAccountNo"]?.toString() ?? "",
        beneficiaryBankName: json["beneficiaryBankName"]?.toString() ?? "",
        beneficiaryBankCode: json["beneficiaryBankCode"]?.toString() ?? "",
        status: json["status"]?.toString() ?? "",
      );
}

int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString()) ?? 0;
}

