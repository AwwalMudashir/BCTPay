import 'package:bctpay/globals/index.dart';

class ReceiverAccountStatusResponse {
  final int code;
  final ReceiverAccountStatusData? data;
  final String message;
  final bool? success;

  ReceiverAccountStatusResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ReceiverAccountStatusResponse.fromJson(Map<String, dynamic> json) =>
      ReceiverAccountStatusResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : ReceiverAccountStatusData.fromJson(json["data"]),
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

class ReceiverAccountStatusData {
  final String status;
  final BankAccount? receiverDetails;

  ReceiverAccountStatusData({
    required this.status,
    required this.receiverDetails,
  });

  factory ReceiverAccountStatusData.fromJson(Map<String, dynamic> json) =>
      ReceiverAccountStatusData(
        status: json["status"],
        receiverDetails: json["receiverDetails"] == null
            ? null
            : BankAccount.fromJson(json["receiverDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "receiverDetails": receiverDetails?.toJson(),
      };
}

class ReceiverDetails {
  final String id;
  final String customerId;
  final String bctpayCustomerId;
  final String beneficiaryName;
  final String institutionName;
  final String accountLogo;
  final String accountNo;
  final String accountType;
  final String phoneCode;
  final String verifyStatus;
  final String accountStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String userType;

  ReceiverDetails({
    required this.id,
    required this.customerId,
    required this.bctpayCustomerId,
    required this.beneficiaryName,
    required this.institutionName,
    required this.accountLogo,
    required this.accountNo,
    required this.accountType,
    required this.phoneCode,
    required this.verifyStatus,
    required this.accountStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.userType,
  });

  factory ReceiverDetails.fromJson(Map<String, dynamic> json) =>
      ReceiverDetails(
        id: json["_id"],
        customerId: json["customerId"],
        bctpayCustomerId: json["bctpay_customer_id"],
        beneficiaryName: json["beneficiary_name"],
        institutionName: json["institution_name"],
        accountLogo: json["account_logo"],
        accountNo: json["account_no"],
        accountType: json["account_type"],
        phoneCode: json["phone_code"],
        verifyStatus: json["verify_status"],
        accountStatus: json["account_status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "bctpay_customer_id": bctpayCustomerId,
        "beneficiary_name": beneficiaryName,
        "institution_name": institutionName,
        "account_logo": accountLogo,
        "account_no": accountNo,
        "account_type": accountType,
        "phone_code": phoneCode,
        "verify_status": verifyStatus,
        "account_status": accountStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "user_type": userType,
      };
}
