import 'dart:convert';

class FAQsListResponse {
  final int code;
  final FAQsData data;
  final String message;
  final bool success;

  FAQsListResponse({
    required this.code,
    required this.data,
    required this.message,
    required this.success,
  });

  factory FAQsListResponse.fromJson(Map<String, dynamic> json) {
    return FAQsListResponse(
      code: json['code'],
      data: FAQsData.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}

class FAQsData {
  final List<FAQ> faqs;

  FAQsData({required this.faqs});

  factory FAQsData.fromJson(Map<String, dynamic> json) {
    return FAQsData(
      faqs: List<FAQ>.from(
        json['faqs'].map((faqJson) => FAQ.fromJson(faqJson)),
      ),
    );
  }
}

class FAQ {
  final String id;
  final List<Translation> translations;
  // final String answer;
  final DateTime createdAt;

  FAQ({
    required this.id,
    required this.translations,
    // required this.answer,
    required this.createdAt,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      id: json['_id'],
      translations: List<Translation>.from(
        json['translations'].map((faqJson) => Translation.fromMap(faqJson)),
      ),
      // answer: json['answer'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Translation {
  final String language_name;
  final String question;
  final String id;
  final String answer;

  Translation(
      {required this.language_name,
      required this.question,
      required this.id,
      required this.answer});

  Map<String, dynamic> toMap() {
    return {
      'language_name': language_name,
      'question': question,
      'id': id,
      'answer': answer,
    };
  }

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      language_name: map['language_name'] ?? '',
      question: map['question'] ?? '',
      id: map['id'] ?? '',
      answer: map['answer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Translation.fromJson(String source) =>
      Translation.fromMap(json.decode(source));
}
