import 'package:bctpay/globals/index.dart';

class VerifiedNotVerifiedStatusView extends StatelessWidget {
  final bool isVerified;
  const VerifiedNotVerifiedStatusView({super.key, this.isVerified = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      isVerified
          ? appLocalizations(context).verified
          : appLocalizations(context).notVerified,
      style: textTheme(context).bodySmall?.copyWith(
          color: isVerified ? Colors.green : Colors.red,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
    );
  }
}
