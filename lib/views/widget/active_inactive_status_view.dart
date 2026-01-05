import 'package:bctpay/lib.dart';

class ActiveInactiveStatusView extends StatelessWidget {
  final bool isActive;

  const ActiveInactiveStatusView({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularView(
          isActive: isActive,
        ),
        Text(
          isActive
              ? (appLocalizations(context).active)
              : (appLocalizations(context).inActive),
          style: textTheme(context).bodySmall?.copyWith(
              color: isActive ? Colors.green : Colors.grey,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
