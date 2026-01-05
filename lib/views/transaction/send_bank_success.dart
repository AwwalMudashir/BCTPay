import 'package:bctpay/globals/index.dart';

class SendBankSuccessScreen extends StatelessWidget {
  const SendBankSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final amount = args["amount"] ?? "₦0.00";
    final responseMessage = args["responseMessage"] ?? "Payment complete";
    final refNo = args["refNo"] ?? "";
    final status = args["status"] ?? "";
    final bank = args["bank"] ?? "Bank";
    final accountNumber = args["accountNumber"] ?? "";
    final accountName = args["accountName"] ?? "";
    final note = args["note"] ?? "Nil";

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.popUntil(
              context, ModalRoute.withName(AppRoutes.dashboard)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 12),
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.green.withValues(alpha: 0.15),
                child: const Icon(Icons.check, color: Colors.green, size: 28),
              ),
              const SizedBox(height: 12),
              Text(appLocalizations(context).paymentSent,
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              _summaryTile(context,
                  label: appLocalizations(context).paymentSent,
                  value: amount,
                  highlight: true),
              const SizedBox(height: 12),
              _infoCard(context, [
                _infoRow(appLocalizations(context).response, responseMessage),
                if (refNo.isNotEmpty)
                  _infoRow(appLocalizations(context).reference, refNo),
                if (status.isNotEmpty)
                  _infoRow(appLocalizations(context).status, status),
              ]),
              const SizedBox(height: 12),
              _infoCard(context, [
                _infoRow(appLocalizations(context).bankName, bank),
                _infoRow(appLocalizations(context).accountNumber, accountNumber),
                _infoRow(appLocalizations(context).accountName, accountName),
                _infoRow(appLocalizations(context).walletLabel, "NGN"),
                _infoRow(appLocalizations(context).narration, note),
                _infoRow(appLocalizations(context).transferFee, "₦0.00"),
              ]),
              const SizedBox(height: 12),
              _summaryTile(context,
                  label: appLocalizations(context).category,
                  value: appLocalizations(context).orders,
                  trailing: Icons.expand_more),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.popUntil(
                          context, ModalRoute.withName(AppRoutes.dashboard)),
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(appLocalizations(context).close),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeLogoColorBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      child: Text(appLocalizations(context).share),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
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

