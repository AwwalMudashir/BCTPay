import 'dart:convert';

import 'package:bctpay/data/models/api_body/txn_filter_model.dart';

class SubscriptionFilterModel {
  final String? name;
  final List<String>? subscriptionType;
  final List<String>? paymentStatus;
  // final List<String>? payment;
  final DateFilter? date;

  SubscriptionFilterModel(
      {required this.name,
      required this.subscriptionType,
      required this.paymentStatus,
      // required this.payment,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'name': name ?? "",
      'subscription_type': subscriptionType,
      'payment_status': paymentStatus,
      // 'payment': payment,
      'date': date?.toMap(),
    };
  }

  factory SubscriptionFilterModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionFilterModel(
      name: map['name'],
      subscriptionType: List<String>.from(map['subscription_type']),
      paymentStatus: List<String>.from(map['payment_status']),
      // payment: List<String>.from(map['payment']),
      date: map['date'] != null ? DateFilter.fromMap(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionFilterModel.fromJson(String source) =>
      SubscriptionFilterModel.fromMap(json.decode(source));
}

// class DateFilter {
//   final DateTime? start;
//   final DateTime? end;
//   DateFilter({
//     this.start,
//     this.end,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'start': start?.toString() ?? "",
//       'end': end?.toString() ?? "",
//     };
//   }

//   factory DateFilter.fromMap(Map<String, dynamic> map) {
//     return DateFilter(
//       start: map['start'] != null ? DateTime.tryParse(map['start']) : null,
//       end: map['end'] != null ? DateTime.tryParse(map['end']) : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory DateFilter.fromJson(String source) =>
//       DateFilter.fromMap(json.decode(source));
// }
