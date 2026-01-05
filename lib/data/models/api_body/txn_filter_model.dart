import 'dart:convert';

class TxnFilterModel {
  final String? name;
  final List<String>? paymentType;
  final List<String>? paymentStatus;
  final List<String>? payment;
  final DateFilter? date;

  TxnFilterModel(
      {required this.name,
      required this.paymentType,
      required this.paymentStatus,
      required this.payment,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'name': name ?? "",
      'payment_type': paymentType,
      'payment_status': paymentStatus,
      'payment': payment,
      'date': date?.toMap(),
    };
  }

  factory TxnFilterModel.fromMap(Map<String, dynamic> map) {
    return TxnFilterModel(
      name: map['name'],
      paymentType: List<String>.from(map['payment_type']),
      paymentStatus: List<String>.from(map['payment_status']),
      payment: List<String>.from(map['payment']),
      date: map['date'] != null ? DateFilter.fromMap(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TxnFilterModel.fromJson(String source) =>
      TxnFilterModel.fromMap(json.decode(source));
}

class DateFilter {
  final DateTime? start;
  final DateTime? end;
  DateFilter({
    this.start,
    this.end,
  });

  Map<String, dynamic> toMap() {
    return {
      'start': start?.toString() ?? "",
      'end': end?.toString() ?? "",
    };
  }

  factory DateFilter.fromMap(Map<String, dynamic> map) {
    return DateFilter(
      start: map['start'] != null ? DateTime.tryParse(map['start']) : null,
      end: map['end'] != null ? DateTime.tryParse(map['end']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DateFilter.fromJson(String source) =>
      DateFilter.fromMap(json.decode(source));
}
