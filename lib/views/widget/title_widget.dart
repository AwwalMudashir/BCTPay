import 'package:bctpay/globals/index.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Color? color;

  const TitleWidget({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Text(
      title,
      style: textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
