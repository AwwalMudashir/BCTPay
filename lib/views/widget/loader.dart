import 'package:bctpay/globals/index.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: themeLogoColorOrange,
          size: 40,
        ),
      ),
    );
  }
}
