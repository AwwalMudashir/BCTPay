import 'package:bctpay/globals/index.dart';

class ListAnimation extends StatelessWidget {
  final int index;
  final Widget child;
  const ListAnimation({super.key, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 300),
        child: SlideAnimation(
            verticalOffset: 200.0,
            horizontalOffset: 200.0,
            curve: Curves.fastOutSlowIn,
            child: FadeInAnimation(
              child: child,
            )));
  }
}
