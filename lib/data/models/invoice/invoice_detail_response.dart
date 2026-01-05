import 'package:bctpay/globals/index.dart';

class InvoiceDetailResponse {
  final int code;
  final InvoiceDetailData? data;
  final String message;
  final bool? success;

  InvoiceDetailResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory InvoiceDetailResponse.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : InvoiceDetailData.fromJson(json["data"]),
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

class InvoiceDetailData {
  final Customer profileDetails;
  final KYCData? kybKycDetails;
  final List<dynamic> accountList;
  final Invoice invoiceData;
  final BankAccount? receiverAccount;

  InvoiceDetailData({
    required this.profileDetails,
    required this.kybKycDetails,
    required this.accountList,
    required this.invoiceData,
    required this.receiverAccount,
  });

  factory InvoiceDetailData.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailData(
        profileDetails: Customer.fromJson(json["ProfileDetails"]),
        kybKycDetails: json["KybKycDetails"] == null
            ? null
            : KYCData.fromJson(json["KybKycDetails"]),
        accountList: List<dynamic>.from(json["AccountList"].map((x) => x)),
        invoiceData: Invoice.fromJson(json["InvoiceData"]),
        receiverAccount: json["receiverAccount"] == null
            ? null
            : BankAccount.fromJson(json["receiverAccount"]),
      );

  Map<String, dynamic> toJson() => {
        "ProfileDetails": profileDetails.toJson(),
        "KybKycDetails": kybKycDetails?.toJson(),
        "AccountList": List<dynamic>.from(accountList.map((x) => x)),
        "InvoiceData": invoiceData.toJson(),
        "receiverAccount": receiverAccount?.toJson(),
      };
}

class Invoice {
  final String id;
  final Customer? merchantData;
  final String invoiceType;
  final String invoiceFor;
  final String userType;
  final String totalTaxAmount;
  final String? shareStatus;
  final String? invoiveNote;
  final String? invoiceTnc;
  final String paymentLink;
  final String status;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final String invoiceNumber;
  final String? merchantName;
  final String? merchantAccountType;
  final String? merchantAccountNumber;
  final String? merchantAccountId;
  final List<ProductInfo> productInfo;
  final String paymentStatus;
  final String totalAmount;
  final String totalTax;
  final String discountValue;
  final String totalGross;
  final String customerName;
  final String? customerEmail;
  final String customerPhoneNumber;
  final String customerPhoneCode;
  final String? customerAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String invoiceqrCode;
  final String? customerBusinessName;

  Invoice({
    required this.id,
    required this.merchantData,
    required this.invoiceType,
    required this.invoiceFor,
    required this.userType,
    required this.totalTaxAmount,
    required this.shareStatus,
    required this.invoiveNote,
    required this.invoiceTnc,
    required this.paymentLink,
    required this.status,
    required this.invoiceDate,
    required this.dueDate,
    required this.invoiceNumber,
    required this.merchantName,
    required this.merchantAccountType,
    required this.merchantAccountNumber,
    required this.merchantAccountId,
    required this.productInfo,
    required this.paymentStatus,
    required this.totalAmount,
    required this.totalTax,
    required this.discountValue,
    required this.totalGross,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhoneNumber,
    required this.customerPhoneCode,
    required this.customerAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.invoiceqrCode,
    required this.customerBusinessName,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["_id"],
        merchantData: json["merchantId"] == null
            ? null
            : json["merchantId"] is String
                ? Customer(id: json["merchantId"])
                : Customer.fromJson(json["merchantId"]),
        // merchantData: json["merchantId"] == null
        //     ? null
        //     : MerchantData.fromJson(json["merchantId"]),
        invoiceType: json["invoice_type"],
        invoiceFor: json["invoice_for"],
        userType: json["user_type"],
        totalTaxAmount: json["total_tax_amount"],
        shareStatus: json["share_status"],
        invoiveNote: json["invoive_note"],
        invoiceTnc: json["invoice_tnc"],
        paymentLink: json["payment_link"],
        status: json["status"],
        invoiceDate: DateTime.parse(json["invoice_date"]),
        dueDate: DateTime.parse(json["due_date"]),
        invoiceNumber: json["invoice_number"],
        merchantName: json["merchant_name"],
        merchantAccountType: json["merchant_account_type"],
        merchantAccountNumber: json["merchant_account_number"],
        merchantAccountId: json["merchant_account_id"],
        productInfo: List<ProductInfo>.from(
            json["product_info"].map((x) => ProductInfo.fromJson(x))),
        paymentStatus: json["payment_status"],
        totalAmount: json["total_amount"],
        totalTax: json["total_tax"],
        discountValue: json["discountValue"],
        totalGross: json["total_gross"],
        customerName: json["customer_name"],
        customerEmail: json["customer_email"],
        customerPhoneNumber: json["customer_phone_number"],
        customerPhoneCode: json["customer_phone_code"],
        customerAddress: json["customer_address"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        invoiceqrCode: json["invoiceqr_code"],
        customerBusinessName: json["customer_business_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "merchantId": merchantData?.toJson(),
        "invoice_type": invoiceType,
        "invoice_for": invoiceFor,
        "user_type": userType,
        "total_tax_amount": totalTaxAmount,
        "share_status": shareStatus,
        "invoive_note": invoiveNote,
        "invoice_tnc": invoiceTnc,
        "payment_link": paymentLink,
        "status": status,
        "invoice_date": invoiceDate.toIso8601String(),
        "due_date": dueDate.toIso8601String(),
        "invoice_number": invoiceNumber,
        "merchant_name": merchantName,
        "merchant_account_type": merchantAccountType,
        "merchant_account_number": merchantAccountNumber,
        "merchant_account_id": merchantAccountId,
        "product_info": List<dynamic>.from(productInfo.map((x) => x.toJson())),
        "payment_status": paymentStatus,
        "total_amount": totalAmount,
        "total_tax": totalTax,
        "discountValue": discountValue,
        "total_gross": totalGross,
        "customer_name": customerName,
        "customer_email": customerEmail,
        "customer_phone_number": customerPhoneNumber,
        "customer_phone_code": customerPhoneCode,
        "customer_address": customerAddress,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "invoiceqr_code": invoiceqrCode,
        "customer_business_name": customerBusinessName,
      };
}

class ProductInfo {
  final String? productNameEn;
  final String? productNameGn;
  final String? productId;
  final String? categoryId;
  final String? categoryNameEn;
  final String? categoryNameGn;
  final String? referenceNumber;
  final double? productPrice;
  final int productQuantity;
  final String productTax;
  final double? totalProductPrice;
  final String id;

  ProductInfo({
    required this.productNameEn,
    required this.productNameGn,
    required this.productId,
    required this.categoryId,
    required this.categoryNameEn,
    required this.categoryNameGn,
    required this.referenceNumber,
    required this.productPrice,
    required this.productQuantity,
    required this.productTax,
    required this.totalProductPrice,
    required this.id,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        productNameEn: json["product_name"],
        productNameGn: json["product_name"],
        productId: json["product_id"],
        categoryId: json["category_id"],
        categoryNameEn: json["category_name_en"],
        categoryNameGn: json["category_name_gn"],
        referenceNumber: json["reference_number"],
        productPrice: json["product_price"] is int
            ? json["product_price"].toDouble()
            : json["product_price"],
        productQuantity: json["product_quantity"],
        productTax: json["product_tax"],
        totalProductPrice:
            double.tryParse(json["total_product_price"].toString()),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productNameEn,
        "product_name_gn": productNameGn,
        "product_id": productId,
        "category_id": categoryId,
        "category_name_en": categoryNameEn,
        "category_name_gn": categoryNameGn,
        "reference_number": referenceNumber,
        "product_price": productPrice,
        "product_quantity": productQuantity,
        "product_tax": productTax,
        "total_product_price": totalProductPrice,
        "_id": id,
      };
}

// class Customer {
//   final String id;
//   final String? firstname;
//   final String? lastname;
//   final String? profilePic;
//   final String? email;
//   final String? countryflag;
//   final String? phonenumber;
//   final String? phoneCode;
//   final String? country;
//   final String? businessCategoryName;
//   final String? companyLogo;
//   final String? line1;
//   final String? city;
//   final String? state;

//   Customer({
//     required this.id,
//     this.firstname,
//     this.lastname,
//     this.profilePic,
//     this.email,
//     this.countryflag,
//     this.phonenumber,
//     this.phoneCode,
//     this.country,
//     this.businessCategoryName,
//     this.companyLogo,
//     this.line1,
//     this.city,
//     this.state,
//   });

//   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
//         id: json["_id"],
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         profilePic: json["profile_pic"],
//         email: json["email"],
//         countryflag: json["countryflag"],
//         phonenumber: json["phonenumber"],
//         phoneCode: json["phone_code"],
//         country: json["country"],
//         businessCategoryName: json["business_category_name"],
//         companyLogo: json["company_logo"],
//         line1: json["line1"],
//         city: json["city"],
//         state: json["state"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "firstname": firstname,
//         "lastname": lastname,
//         "profile_pic": profilePic,
//         "email": email,
//         "countryflag": countryflag,
//         "phonenumber": phonenumber,
//         "phone_code": phoneCode,
//         "country": country,
//         "business_category_name": businessCategoryName,
//         "company_logo": companyLogo,
//         "line1": line1,
//         "city": city,
//         "state": state,
//       };
// }
