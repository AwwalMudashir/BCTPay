import 'dart:convert';

import 'package:bctpay/data/models/api_body/txn_filter_model.dart';

class InvoiceFilterModel {
  final String? name;
  // final List<String>? paymentType;
  final List<String>? paymentStatus;
  // final List<String>? payment;
  final DateFilter? date;

  InvoiceFilterModel(
      {required this.name,
      // required this.paymentType,
      required this.paymentStatus,
      // required this.payment,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'globalSearch': name ?? "",
      // 'payment_type': paymentType,
      'payment_status': paymentStatus,
      // 'payment': payment,
      'date': date?.toMap(),
    };
  }

  factory InvoiceFilterModel.fromMap(Map<String, dynamic> map) {
    return InvoiceFilterModel(
      name: map['name'],
      // paymentType: List<String>.from(map['payment_type']),
      paymentStatus: List<String>.from(map['payment_status']),
      // payment: List<String>.from(map['payment']),
      date: map['date'] != null ? DateFilter.fromMap(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceFilterModel.fromJson(String source) =>
      InvoiceFilterModel.fromMap(json.decode(source));
}
