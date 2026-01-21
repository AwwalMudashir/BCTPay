import 'package:bctpay/globals/index.dart';

AddBeneficiaryResponse addBeneficiaryResponseFromJson(String str) =>
    AddBeneficiaryResponse.fromJson(json.decode(str));

String addBeneficiaryResponseToJson(AddBeneficiaryResponse data) =>
    json.encode(data.toJson());

class AddBeneficiaryResponse {
  final String code;
  final String desc;
  final String nextURL;
  final String id;
  final String refNo;
  final double amount;
  final String code3;
  final List<Map<String, dynamic>> listData;

  AddBeneficiaryResponse({
    required this.code,
    required this.desc,
    required this.nextURL,
    required this.id,
    required this.refNo,
    required this.amount,
    required this.code3,
    required this.listData,
  });

  bool get isSuccess =>
      code == "00" || code == "000" || code.toUpperCase() == "SUCCESS";
  String get message => desc;
  int? get codeInt => int.tryParse(code);
  bool get isSessionExpired =>
      codeInt == HTTPResponseStatusCodes.sessionExpireCode;

  factory AddBeneficiaryResponse.fromJson(Map<String, dynamic> json) {
    final listJson = json["listData"] as List? ?? [];
    return AddBeneficiaryResponse(
      code: json["code"]?.toString() ?? "",
      desc: json["desc"]?.toString() ?? "",
      nextURL: json["nextURL"]?.toString() ?? "",
      id: json["id"]?.toString() ?? "",
      refNo: json["refNo"]?.toString() ?? "",
      amount: _toDouble(json["amount"]),
      code3: json["code3"]?.toString() ?? "",
      listData: listJson
          .map((e) => (e is Map<String, dynamic>) ? e : <String, dynamic>{})
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
        "nextURL": nextURL,
        "id": id,
        "refNo": refNo,
        "amount": amount,
        "code3": code3,
        "listData": listData,
      };
}

double _toDouble(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0;
}
