import 'dart:convert';

class NotificationFilterModel {
  final String? customerId;
  final List<String>? notificationTypes;
  // final List<String>? paymentStatus;
  // final List<String>? payment;
  // final DateFilter? date;

  NotificationFilterModel({
    required this.customerId,
    required this.notificationTypes,
    // required this.paymentStatus,
    // required this.payment,
    // required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'name': name ?? "",
      // 'payment_type': paymentType,
      // 'payment_status': paymentStatus,
      // 'payment': payment,
      // 'date': date?.toMap(),
      "customerId": " ",
      "notificationTypes": ["updatd Kyb", "payment_received"]
    };
  }

  factory NotificationFilterModel.fromMap(Map<String, dynamic> map) {
    return NotificationFilterModel(
      customerId: map['customerId'],
      notificationTypes: List<String>.from(map['notificationTypes']),
      // paymentStatus: List<String>.from(map['payment_status']),
      // payment: List<String>.from(map['payment']),
      // date: map['date'] != null ? DateFilter.fromMap(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationFilterModel.fromJson(String source) =>
      NotificationFilterModel.fromMap(json.decode(source));
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
