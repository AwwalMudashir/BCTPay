import 'dart:convert';

class Payload {
  final String id;
  final String type;

  Payload({required this.id, required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
    };
  }

  factory Payload.fromMap(Map<String, dynamic> map) {
    return Payload(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Payload.fromJson(String source) =>
      Payload.fromMap(json.decode(source));
}
