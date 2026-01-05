import 'package:bctpay/globals/index.dart';

class InvoiceListResponse {
  final int code;
  final InvoiceListData? data;
  final String message;
  final bool? success;

  InvoiceListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory InvoiceListResponse.fromJson(Map<String, dynamic> json) =>
      InvoiceListResponse(
        code: json["code"],
        data: json["data"] == null
            ? null
            : InvoiceListData.fromJson(json["data"]),
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

class InvoiceListData {
  final List<InvoiceData>? invoicelist;

  InvoiceListData({
    this.invoicelist,
  });

  InvoiceListData copyWith({
    List<InvoiceData>? invoicelist,
  }) =>
      InvoiceListData(
        invoicelist: invoicelist ?? this.invoicelist,
      );

  factory InvoiceListData.fromJson(Map<String, dynamic> json) =>
      InvoiceListData(
        invoicelist: json["invoicelist"] == null
            ? []
            : List<InvoiceData>.from(
                json["invoicelist"]!.map((x) => InvoiceData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "invoicelist": invoicelist == null
            ? []
            : List<dynamic>.from(invoicelist!.map((x) => x.toJson())),
      };
}

class InvoiceData {
  final Invoice? invoiceDetails;
  final TransactionData? transactionDetails;

  InvoiceData({
    this.invoiceDetails,
    this.transactionDetails,
  });

  InvoiceData copyWith({
    Invoice? invoiceDetails,
    TransactionData? transactionDetails,
  }) =>
      InvoiceData(
        invoiceDetails: invoiceDetails ?? this.invoiceDetails,
        transactionDetails: transactionDetails ?? this.transactionDetails,
      );

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        invoiceDetails: json["invoice_details"] == null
            ? null
            : Invoice.fromJson(json["invoice_details"]),
        transactionDetails: json["transaction_details"] == null
            ? null
            : TransactionData.fromJson(json["transaction_details"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_details": invoiceDetails?.toJson(),
        "transaction_details": transactionDetails?.toJson(),
      };
}


// class InvoiceListData {
//   final List<InvoiceData> invoicelist;

//   InvoiceListData({
//     required this.invoicelist,
//   });

//   factory InvoiceListData.fromJson(Map<String, dynamic> json) =>
//       InvoiceListData(
//         invoicelist: List<InvoiceData>.from(
//             json["invoicelist"].map((x) => InvoiceData.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "invoicelist": List<dynamic>.from(invoicelist.map((x) => x.toJson())),
//       };
// }
