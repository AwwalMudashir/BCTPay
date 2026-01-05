import 'package:bctpay/lib.dart';

class PaymentStatusView extends StatelessWidget {
  final String? paymentStatus;
  const PaymentStatusView({super.key, this.paymentStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: getPaymentStatusColor(paymentStatus)),
      child: Text(
        paymentStatus ?? "",
        style: textTheme(context)
            .bodySmall
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

Color? getPaymentStatusColor(String? status) {
  switch (status?.toLowerCase()) {
    case "paid":
      return Colors.green;
    case "unpaid":
      return Colors.red;
    case "partially paid":
      return themeLogoColorOrange;
    case "expired":
      return Colors.red[900];
    default:
      return Colors.red;
  }
}
