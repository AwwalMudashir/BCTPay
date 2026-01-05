import 'package:bctpay/globals/index.dart';

TextStyle decorationStyle =
    const TextStyle(color: Colors.white, fontSize: 16.0);

class Countdown extends AnimatedWidget {
  const Countdown({super.key, required this.animation})
      : super(listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: shadowDecoration,
      child: Text(
        "00:${animation.value < 10 ? "0" : ""}${animation.value}",
        style: const TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
  }
}
