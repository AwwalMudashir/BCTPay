import 'package:bctpay/lib.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            color: Color(0X40000000),
            blurRadius: 4,
          ),
        ],
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: const Icon(
        Icons.close,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
