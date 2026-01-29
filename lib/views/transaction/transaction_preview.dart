import 'package:bctpay/globals/index.dart';
import 'package:intl/intl.dart';
import 'package:bctpay/data/models/transactions/transaction_history_response.dart';

class TransactionPreviewScreen extends StatelessWidget {
  const TransactionPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final TransactionHistoryItem txn;
    String currency = 'GNF';
    if (args is Map) {
      txn = args['transaction'] as TransactionHistoryItem;
      currency = (args['currency'] as String?) ?? 'GNF';
    } else {
      txn = args as TransactionHistoryItem;
    }
    final isCredit = txn.isCredit;
    final amountColor = isCredit ? const Color(0xFF00A389) : const Color(0xFFE53935);
    final formatter = NumberFormat('#,##0.00');
    final amt = (isCredit ? '+' : '-') + formatter.format(txn.amount.abs());
    final amountDisplay = currency.toUpperCase() == 'GNF' ? '$amt GNF' : (currency.isNotEmpty ? '$currency $amt' : amt);

    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).transactionDetails),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  amountDisplay,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: amountColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(txn.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(txn.tranDate, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.withOpacity(0.2)),
              const SizedBox(height: 8),
              Text('Status', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
              Text(txn.status, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Text('Transaction ID', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
              Text(txn.tranRefNo.isNotEmpty ? txn.tranRefNo : 'N/A', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              Text('Type', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
              Text(txn.transactionType.isNotEmpty ? txn.transactionType : 'N/A', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              Expanded(child: Container()),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(appLocalizations(context).close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
