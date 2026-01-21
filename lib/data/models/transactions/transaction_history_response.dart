class TransactionHistoryResponse {
  final String responseCode;
  final String responseMessage;
  final List<TransactionHistoryItem> transHistoryInfoList;

  TransactionHistoryResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.transHistoryInfoList,
  });

  List<TransactionHistoryItem> get items => transHistoryInfoList;

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      responseCode: (json['responseCode'] ?? json['code'] ?? '').toString(),
      responseMessage:
          (json['responseMessage'] ?? json['message'] ?? json['desc'] ?? '')
              .toString(),
      transHistoryInfoList: (json['transHistoryInfoList'] as List? ??
              json['data'] as List? ??
              [])
          .map((e) => TransactionHistoryItem.fromJson(e))
          .toList(),
    );
  }
}

class TransactionHistoryItem {
  final String tranDate;
  final String title;
  final double amount;
  final String transactionType;
  final String status;
  final String logo;
  final String tranRefNo;
  final String tranCode;

  TransactionHistoryItem({
    required this.tranDate,
    required this.title,
    required this.amount,
    required this.transactionType,
    required this.status,
    required this.logo,
    required this.tranRefNo,
    required this.tranCode,
  });

  factory TransactionHistoryItem.fromJson(Map<String, dynamic> json) {
    final amt = json['amount'];
    double parsedAmount;
    if (amt is num) {
      parsedAmount = amt.toDouble();
    } else {
      parsedAmount = double.tryParse(amt?.toString() ?? '0') ?? 0;
    }
    return TransactionHistoryItem(
      tranDate: json['tranDate']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      amount: parsedAmount,
      transactionType: json['transactionType']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
      tranRefNo: json['tranRefNo']?.toString() ?? '',
      tranCode: json['tranCode']?.toString() ?? '',
    );
  }

  bool get isCredit => amount >= 0;

  String get formattedAmount {
    final prefix = isCredit ? '+' : '-';
    return '$prefix${amount.abs().toStringAsFixed(2)}';
  }
}
