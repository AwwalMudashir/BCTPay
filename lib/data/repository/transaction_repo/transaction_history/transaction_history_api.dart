import 'package:bctpay/globals/index.dart';
import 'package:bctpay/data/repository/transaction_repo/transaction_history/get_transaction_history_api.dart'
  as core_api;

/// Use core public transaction history endpoint to keep behavior consistent
Future<TransactionHistoryResponse> transactionHistory({
  required int page,
  required int limit,
  required TxnFilterModel? filter,
}) async {
  // Delegate to the core GET-based implementation used by dashboard
  final response = await core_api.getTransactionHistory(pageSize: limit, pageNumber: page);
  return response as TransactionHistoryResponse;
}
