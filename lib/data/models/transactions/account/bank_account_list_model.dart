import 'package:bctpay/globals/index.dart';

class BankAccountListResponse {
  final int code;
  final List<BankAccount>? data;
  final String message;
  final bool? success;

  BankAccountListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory BankAccountListResponse.fromJson(Map<String, dynamic> json) =>
      BankAccountListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<BankAccount>.from(
                json["data"].map((x) => BankAccount.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class BankAccount extends Equatable {
  final String id;
  final String? customerId;
  final String? bctpayCustomerId;
  final String? merchantId;
  final String accountRole;
  final String? phoneCode;
  final String? walletPhonenumber;
  final String? verifystatus;
  final String? accountstatus;
  final String? primaryaccount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? beneficiaryname;
  final String? accountnumber;
  final String? clientId;
  final String? bankname;
  final String? bankcode;
  final String? logo;
  final String? userType;

  const BankAccount({
    required this.id,
    this.customerId,
    this.bctpayCustomerId,
    this.merchantId,
    required this.accountRole,
    this.phoneCode,
    this.walletPhonenumber,
    this.verifystatus,
    this.accountstatus,
    this.primaryaccount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.beneficiaryname,
    this.accountnumber,
    this.clientId,
    this.bankname,
    this.bankcode,
    this.logo,
    this.userType,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
        id: json["_id"],
        customerId: json["customerId"],
        bctpayCustomerId: json["bctpay_customer_id"],
        merchantId: json["merchantId"],
        accountRole: json["account_type"],
        phoneCode: json["phone_code"],
        walletPhonenumber: json["wallet_phonenumber"],
        verifystatus: json["verify_status"],
        accountstatus: json["account_status"],
        primaryaccount: json["primary_account"],
        createdAt: DateTime.tryParse(json["createdAt"]),
        updatedAt: DateTime.tryParse(json["updatedAt"]),
        v: json["__v"],
        beneficiaryname: json["beneficiary_name"],
        accountnumber: json["account_no"],
        clientId: json["clientId"],
        bankname: json["institution_name"],
        bankcode: json["institution_code"],
        logo: json["account_logo"] ?? json["account_image"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "bctpay_customer_id": bctpayCustomerId,
        "merchantId": merchantId,
        "account_type": accountRole,
        "phone_code": phoneCode,
        "wallet_phonenumber": walletPhonenumber,
        "verify_status": verifystatus,
        "account_status": accountstatus,
        "primary_account": primaryaccount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "beneficiary_name": beneficiaryname,
        "account_no": accountnumber,
        "clientId": clientId,
        "institution_name": bankname,
        "institution_code": bankcode,
        "account_logo": logo,
        "user_type": userType,
      };

  @override
  List<Object?> get props => [
        id,
        customerId,
        bctpayCustomerId,
        accountRole,
        phoneCode,
        walletPhonenumber,
        verifystatus,
        accountstatus,
        primaryaccount,
        createdAt,
        updatedAt,
        v,
        beneficiaryname,
        accountnumber,
        clientId,
        bankname,
        bankcode,
        logo,
        userType
      ];
}
