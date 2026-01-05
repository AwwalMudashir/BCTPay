import 'package:bctpay/globals/index.dart';

Color getQueryStatusColor(String? status) {
  switch (status) {
    case "true":
      return Colors.red;
    case "false":
      return Colors.green;
    case null:
      return Colors.red;
    default:
      return Colors.red;
  }
}
