import 'dart:convert';

import 'package:bctpay/data/models/api_body/txn_filter_model.dart';

class QueryFilterModel {
  final String? name;
  // final List<String>? paymentType;
  final List<String>? queryTypes;
  // final List<String>? payment;
  final DateFilter? date;

  QueryFilterModel(
      {required this.name,
      // required this.paymentType,
      required this.queryTypes,
      // required this.payment,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'name': name ?? "",
      // 'payment_type': paymentType,
      'type_of_queries_en': queryTypes,
      // 'payment': payment,
      'date': date?.toMap(),
    };
  }

  factory QueryFilterModel.fromMap(Map<String, dynamic> map) {
    return QueryFilterModel(
      name: map['name'],
      // paymentType: List<String>.from(map['payment_type']),
      queryTypes: List<String>.from(map['type_of_queries_en']),
      // payment: List<String>.from(map['payment']),
      date: map['date'] != null ? DateFilter.fromMap(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QueryFilterModel.fromJson(String source) =>
      QueryFilterModel.fromMap(json.decode(source));
}
