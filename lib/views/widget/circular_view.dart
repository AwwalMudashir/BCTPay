import 'package:bctpay/lib.dart';

class CircularView extends StatelessWidget {
  final bool isActive;
  const CircularView({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: isActive ? Colors.green : Colors.grey, shape: BoxShape.circle),
    );
  }
}
