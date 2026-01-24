// Enums for better type safety and consistency

enum KYCTier {
  tier1('Tier 1'),
  tier2('Tier 2'),
  tier3('Tier 3');

  const KYCTier(this.value);
  final String value;

  static KYCTier fromString(String value) {
    return KYCTier.values.firstWhere(
      (tier) => tier.value == value,
      orElse: () => KYCTier.tier1,
    );
  }
}

enum KYCStatus {
  none('NONE'),
  pending('PENDING'),
  approved('APPROVED'),
  rejected('REJECTED'),
  expired('EXPIRED');

  const KYCStatus(this.value);
  final String value;

  static KYCStatus fromString(String value) {
    return KYCStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => KYCStatus.none,
    );
  }
}

enum KYCDocumentCode {
  bvn('BVN'),
  personalDetail('PERSONAL_DETAIL'),
  idDocument('ID_DOCUMENT'),
  utilityBill('UTILITY_BILL'),
  nin('NIN'),
  incomeData('INCOME_DATA'),
  livenessCheck('LIVENESS_CHECK');

  const KYCDocumentCode(this.value);
  final String value;

  static KYCDocumentCode fromString(String value) {
    return KYCDocumentCode.values.firstWhere(
      (code) => code.value == value,
      orElse: () => KYCDocumentCode.bvn,
    );
  }
}

enum EntityCode {
  ftd('FTD'),
  p2p('P2P'),
  merchant('MERCHANT');

  const EntityCode(this.value);
  final String value;

  static EntityCode? fromString(String? value) {
    if (value == null) return null;
    return EntityCode.values.firstWhere(
      (code) => code.value == value,
      orElse: () => EntityCode.ftd,
    );
  }
}

// Core KYC Item model
class KYCItem {
  final int? id;
  final KYCDocumentCode code;
  final EntityCode? entityCode;
  final String title;
  final String subTitle;
  final String? kycValue;
  final String? kycLink;
  final KYCStatus status;
  final String? kycDataType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? expiryDate;
  final String? rejectionReason;

  KYCItem({
    this.id,
    required this.code,
    this.entityCode,
    required this.title,
    required this.subTitle,
    this.kycValue,
    this.kycLink,
    required this.status,
    this.kycDataType,
    this.createdAt,
    this.updatedAt,
    this.expiryDate,
    this.rejectionReason,
  });

  factory KYCItem.fromJson(Map<String, dynamic> json) {
    return KYCItem(
      id: json['id'],
      code: KYCDocumentCode.fromString(json['code']),
      entityCode: EntityCode.fromString(json['entityCode']),
      title: json['title'] ?? '',
      subTitle: json['subTitle'] ?? '',
      kycValue: json['kycValue'],
      kycLink: json['kycLink'],
      status: KYCStatus.fromString(json['status']),
      kycDataType: json['kycDataType'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      expiryDate:
          json['expiryDate'] != null
              ? DateTime.parse(json['expiryDate'])
              : null,
      rejectionReason: json['rejectionReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code.value,
      'entityCode': entityCode?.value,
      'title': title,
      'subTitle': subTitle,
      'kycValue': kycValue,
      'kycLink': kycLink,
      'status': status.value,
      'kycDataType': kycDataType,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'rejectionReason': rejectionReason,
    };
  }

  KYCItem copyWith({
    int? id,
    KYCDocumentCode? code,
    EntityCode? entityCode,
    String? title,
    String? subTitle,
    String? kycValue,
    String? kycLink,
    KYCStatus? status,
    String? kycDataType,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? expiryDate,
    String? rejectionReason,
  }) {
    return KYCItem(
      id: id ?? this.id,
      code: code ?? this.code,
      entityCode: entityCode ?? this.entityCode,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      kycValue: kycValue ?? this.kycValue,
      kycLink: kycLink ?? this.kycLink,
      status: status ?? this.status,
      kycDataType: kycDataType ?? this.kycDataType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      expiryDate: expiryDate ?? this.expiryDate,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

  bool get isRequired => id != null || status != KYCStatus.none;
  bool get hasDocument => kycLink != null;
  bool get isCompleted => status == KYCStatus.approved;
  bool get isPending => status == KYCStatus.pending;
  bool get isRejected => status == KYCStatus.rejected;
  bool get isExpired => status == KYCStatus.expired;
}

// Main KYC Response model
class KYCResponse {
  final String responseCode;
  final String responseMessage;
  final KYCTier? tier;
  final List<KYCItem>? kycList;
  final double? completionPercentage;
  final DateTime? lastUpdated;
  final String? customerId;

  KYCResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.tier,
    required this.kycList,
    this.completionPercentage,
    this.lastUpdated,
    this.customerId,
  });

  factory KYCResponse.fromJson(Map<String, dynamic> json) {
    return KYCResponse(
      responseCode: json['responseCode'] ?? '',
      responseMessage: json['responseMessage'] ?? '',
      tier: json['tier'] != null ? KYCTier.fromString(json['tier']) : null,
      kycList:
          json['kycList'] != null
              ? (json['kycList'] as List<dynamic>)
                  .map((item) => KYCItem.fromJson(item))
                  .toList()
              : null,
      completionPercentage: json['completionPercentage']?.toDouble(),
      lastUpdated:
          json['lastUpdated'] != null
              ? DateTime.parse(json['lastUpdated'])
              : null,
      customerId: json['customerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'responseMessage': responseMessage,
      'tier': tier?.value ?? '',
      'kycList': kycList?.map((item) => item.toJson()).toList(),
      'completionPercentage': completionPercentage,
      'lastUpdated': lastUpdated?.toIso8601String(),
      'customerId': customerId,
    };
  }

  // Convenience getters
  bool get isSuccess => responseCode == '000' || responseCode == '00';
  bool get isError => !isSuccess;
}

// KYC Summary for analytics/dashboard
class KYCSummary {
  final KYCTier? tier;
  final int? totalDocuments;
  final int? completedDocuments;
  final int? pendingDocuments;
  final int? rejectedDocuments;
  final double? completionRate;
  final KYCItem? nextRequiredDocument;
  final bool? isFullyVerified;

  KYCSummary({
    required this.tier,
    required this.totalDocuments,
    required this.completedDocuments,
    required this.pendingDocuments,
    required this.rejectedDocuments,
    required this.completionRate,
    this.nextRequiredDocument,
    required this.isFullyVerified,
  });
}

// KYC Document Upload Request
class KYCUploadRequest {
  final KYCDocumentCode documentCode;
  final String documentPath; // File path for Flutter
  final String? documentValue;
  final EntityCode? entityCode;

  KYCUploadRequest({
    required this.documentCode,
    required this.documentPath,
    this.documentValue,
    this.entityCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'documentCode': documentCode.value,
      'documentPath': documentPath,
      'documentValue': documentValue,
      'entityCode': entityCode?.value,
    };
  }
}

// KYC Document Upload Response
class KYCUploadResponse {
  final bool success;
  final String message;
  final int? documentId;
  final KYCStatus status;
  final DateTime uploadedAt;

  KYCUploadResponse({
    required this.success,
    required this.message,
    this.documentId,
    required this.status,
    required this.uploadedAt,
  });

  factory KYCUploadResponse.fromJson(Map<String, dynamic> json) {
    return KYCUploadResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      documentId: json['documentId'],
      status: KYCStatus.fromString(json['status']),
      uploadedAt: DateTime.parse(json['uploadedAt']),
    );
  }
}

// KYC Validation Rules
class KYCValidationRule {
  final KYCDocumentCode documentCode;
  final bool required;
  final List<String> allowedFormats;
  final double maxSizeInMB;
  final String? validationPattern;
  final KYCTier tier;

  KYCValidationRule({
    required this.documentCode,
    required this.required,
    required this.allowedFormats,
    required this.maxSizeInMB,
    this.validationPattern,
    required this.tier,
  });
}

// KYC Helper class with utility methods
class KYCHelper {
  /// Calculate completion percentage for KYC
  static double calculateCompletionPercentage(List<KYCItem> kycList) {
    if (kycList.isEmpty) return 0.0;

    final completedCount =
        kycList.where((item) => item.status == KYCStatus.approved).length;

    return (completedCount / kycList.length) * 100;
  }

  /// Generate KYC summary from response
  static KYCSummary generateSummary(KYCResponse kycResponse) {
    final kycList = kycResponse.kycList;

    final totalDocuments = kycList?.length;
    final completedDocuments =
        kycList?.where((item) => item.status == KYCStatus.approved).length;
    final pendingDocuments =
        kycList?.where((item) => item.status == KYCStatus.pending).length;
    final rejectedDocuments =
        kycList?.where((item) => item.status == KYCStatus.rejected).length;
    final completionRate = calculateCompletionPercentage(kycList ?? []);

    final nextRequiredDocument =
        kycList != null
            ? kycList
                    .where(
                      (item) =>
                          item.status == KYCStatus.none ||
                          item.status == KYCStatus.rejected,
                    )
                    .isNotEmpty
                ? kycList
                    .where(
                      (item) =>
                          item.status == KYCStatus.none ||
                          item.status == KYCStatus.rejected,
                    )
                    .first
                : null
            : null;

    final isFullyVerified = completedDocuments == totalDocuments;

    return KYCSummary(
      tier: kycResponse.tier,
      totalDocuments: totalDocuments,
      completedDocuments: completedDocuments,
      pendingDocuments: pendingDocuments,
      rejectedDocuments: rejectedDocuments,
      completionRate: completionRate,
      nextRequiredDocument: nextRequiredDocument,
      isFullyVerified: isFullyVerified,
    );
  }

  /// Get documents by status
  static List<KYCItem> getDocumentsByStatus(
    List<KYCItem> kycList,
    KYCStatus status,
  ) {
    return kycList.where((item) => item.status == status).toList();
  }

  /// Get pending documents
  static List<KYCItem> getPendingDocuments(List<KYCItem> kycList) {
    return getDocumentsByStatus(kycList, KYCStatus.pending);
  }

  /// Get completed documents
  static List<KYCItem> getCompletedDocuments(List<KYCItem> kycList) {
    return getDocumentsByStatus(kycList, KYCStatus.approved);
  }

  /// Get rejected documents
  static List<KYCItem> getRejectedDocuments(List<KYCItem> kycList) {
    return getDocumentsByStatus(kycList, KYCStatus.rejected);
  }

  /// Check if KYC is fully completed
  static bool isKYCComplete(List<KYCItem> kycList) {
    return kycList.every((item) => item.status == KYCStatus.approved);
  }

  /// Get next document to complete
  static KYCItem? getNextDocumentToComplete(List<KYCItem> kycList) {
    // First check for rejected documents
    final rejectedDocs = getRejectedDocuments(kycList);
    if (rejectedDocs.isNotEmpty) return rejectedDocs.first;

    // Then check for documents that haven't been started
    final noneDocs = getDocumentsByStatus(kycList, KYCStatus.none);
    if (noneDocs.isNotEmpty) return noneDocs.first;

    return null;
  }

  /// Validate document format
  static bool isValidDocumentFormat(
    String fileName,
    List<String> allowedFormats,
  ) {
    final extension = fileName.split('.').last.toLowerCase();
    return allowedFormats
        .map((format) => format.toLowerCase())
        .contains(extension);
  }
}