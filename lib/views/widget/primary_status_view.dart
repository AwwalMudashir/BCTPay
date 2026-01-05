import 'package:bctpay/globals/index.dart';

class PrimaryStatusView extends StatelessWidget {
  const PrimaryStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(10)),
      child: Text(
        appLocalizations(context).primary,
        style: textTheme.headlineSmall
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
