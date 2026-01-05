import 'package:bctpay/globals/index.dart';

extension IntExtension on int {
  Widget get toSpace => SizedBox(
        height: toDouble(),
        width: toDouble(),
      );

  Widget get height => SizedBox(
        height: toDouble(),
      );

  Widget get width => SizedBox(
        width: toDouble(),
      );
}
