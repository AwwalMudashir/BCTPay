import 'package:bctpay/lib.dart';

class ProductRow extends StatelessWidget {
  final String subtitle;
  final String value;
  const ProductRow({
    super.key,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          subtitle,
          style: textTheme(context).bodyMedium!.copyWith(color: Colors.grey),
        ),
        Text(value),
      ],
    );
  }
}
