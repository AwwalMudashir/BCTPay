import 'package:bctpay/globals/index.dart';

extension StringExtension on String {
  String showLast4HideAll() =>
      "********${replaceAll(removeAllExceptLast4Regex, "")}";
}
