import 'package:bctpay/globals/index.dart';

class PaymentMethodListItem extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final void Function()? onTap;
  const PaymentMethodListItem(
      {super.key, required this.paymentMethod, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        decoration: shadowDecoration,
        child: Image.asset("assets/images/${paymentMethod.image}.png"),
      ),
    );
  }
}
