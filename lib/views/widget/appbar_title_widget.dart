import 'package:bctpay/globals/index.dart';

class AppBarTitleWidget extends StatelessWidget {
  const AppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isDarkMode(context)
          ? Assets.assetsImagesBCTLogoLight
          : Assets.assetsImagesBCTLogoDark,
      height: 30,
    );
  }
}
