import 'package:bctpay/lib.dart';

class DateView extends StatelessWidget {
  final String date;

  const DateView({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        color: Colors.grey,
      ),
      child: Text(
        date,
        style: textTheme(context).bodySmall!.copyWith(
              color: Colors.white,
              fontSize: 10,
            ),
      ),
    );
  }
}
