import 'package:bctpay/data/repository/transaction_repo/send_money/send_money_api.dart';
import 'package:bctpay/globals/index.dart';

class SendBankSummaryScreen extends StatefulWidget {
  const SendBankSummaryScreen({super.key});

  @override
  State<SendBankSummaryScreen> createState() => _SendBankSummaryScreenState();
}

class _SendBankSummaryScreenState extends State<SendBankSummaryScreen> {
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final amount =
        args["amountDisplay"] ?? args["amount"] ?? "₦0.00";
    final bank = args["bank"] ?? "First Bank (FBN)";
    final accountNumber = args["accountNumber"] ?? "30983465472";
    final accountName = args["accountName"] ?? "James David";
    final walletLabel = args["walletLabel"] ?? "NGN";

    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: themeLogoColorBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(appLocalizations(context).transactionSummary,
            style:
                textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                _summaryTile(context,
                    label: appLocalizations(context).amountToSend,
                    value: amount,
                    highlight: true),
                const SizedBox(height: 12),
                _infoCard(context, [
                  _infoRow(appLocalizations(context).bankName, bank),
                  _infoRow(
                      appLocalizations(context).accountNumber, accountNumber),
                  _infoRow(appLocalizations(context).accountName, accountName),
                  _infoRow(appLocalizations(context).walletLabel, walletLabel),
                  _infoRow(
                      appLocalizations(context).narration,
                      (args["note"] as String?)?.isNotEmpty == true
                          ? args["note"]
                          : "Nil"),
                  _infoRow(appLocalizations(context).transferFee, "₦0.00"),
                ]),
                const SizedBox(height: 12),
                _summaryTile(context,
                    label: appLocalizations(context).category,
                    value: appLocalizations(context).orders,
                    trailing: Icons.expand_more),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F9FC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalizations(context).confirm,
                        style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Please review the details before sending.",
                        style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSending ? null : () => _sendMoney(args),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeLogoColorBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    child: _isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(appLocalizations(context).send),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendMoney(Map args) async {
    final amountValue = (args["amountValue"] as double?) ??
        double.tryParse(
            (args["amount"] as String? ?? "0").replaceAll(RegExp(r'[^\d.]'), '')) ??
        0;
    setState(() => _isSending = true);
    try {
      final result = await sendMoney(
        mobileNo: args["mobileNo"] ?? "",
        accountType: args["accountType"] ?? "BANK",
        networkOrBankCode: args["bankCode"] ?? args["bank"] ?? "",
        beneficiaryName: args["accountName"] ?? "",
        amount: amountValue,
        note: args["note"] ?? "",
        accountNo: args["accountNumber"] ?? "",
        externalRefNo: args["externalRefNo"] ?? "",
        ccy: args["currency"] ?? "NGN",
        channel: "MOBILE",
      );
      if (!mounted) return;
      final displayAmount = args["amountDisplay"] ??
          args["amount"] ??
          "₦0.00";
      Navigator.pushNamed(context, AppRoutes.sendBankSuccess, arguments: {
        "bank": args["bank"],
        "accountNumber": args["accountNumber"],
        "accountName": args["accountName"],
        "amount": displayAmount,
        "currency": args["currency"],
        "walletLabel": args["walletLabel"],
        "note": args["note"],
        "responseCode": result.responseCode,
        "responseMessage": result.responseMessage,
        "refNo": result.refNo,
        "status": result.status,
      });
    } catch (e) {
      showFailedDialog(e.toString(), context);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Widget _summaryTile(BuildContext context,
      {required String label,
      required String value,
      bool highlight = false,
      IconData? trailing}) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: textTheme.bodySmall
                      ?.copyWith(color: Colors.grey.shade700)),
              const SizedBox(height: 6),
              Text(
                value,
                style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: highlight ? Colors.black : Colors.black87),
              ),
            ],
          ),
          if (trailing != null)
            Icon(trailing, color: Colors.black54, size: 18)
        ],
      ),
    );
  }

  Widget _infoCard(BuildContext context, List<Widget> rows) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          ...rows,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black87)),
          Text(value,
              style:
                  const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

