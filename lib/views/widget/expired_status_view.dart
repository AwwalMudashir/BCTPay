import 'package:bctpay/lib.dart';

class ExpiredStatusView extends StatelessWidget {
  final bool status;
  const ExpiredStatusView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: getExpiredStatusColor(status)),
      child: Text(
        status
            ? appLocalizations(context).expired
            : appLocalizations(context).active,
        style: textTheme(context)
            .bodySmall
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

Color getExpiredStatusColor(bool status) {
  switch (status) {
    case false:
      return Colors.green;
    case true:
      return Colors.red;
    default:
      return Colors.red;
  }
}
