import 'package:bctpay/globals/index.dart';

class QueryStatusView extends StatelessWidget {
  final String? queryStatus;
  const QueryStatusView({super.key, required this.queryStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: getQueryStatusColor(queryStatus)),
      child: Text(
        queryStatus == "true"
            ? appLocalizations(context).closed
            : appLocalizations(context).open,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
