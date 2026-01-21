class MomoLookupResponse {
  final String code;
  final String desc;
  final List<MomoInfo> list;

  MomoLookupResponse({
    required this.code,
    required this.desc,
    required this.list,
  });

  factory MomoLookupResponse.fromJson(Map<String, dynamic> json) {
    return MomoLookupResponse(
      code: json['code']?.toString() ?? '',
      desc: json['desc']?.toString() ?? '',
      list: (json['list'] as List? ?? [])
          .map((e) => MomoInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MomoInfo {
  final String code;
  final String name;
  final String description;
  final String otherInfo;

  MomoInfo({
    required this.code,
    required this.name,
    required this.description,
    required this.otherInfo,
  });

  factory MomoInfo.fromJson(Map<String, dynamic> json) {
    return MomoInfo(
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      otherInfo: json['otherInfo']?.toString() ?? '',
    );
  }
}
