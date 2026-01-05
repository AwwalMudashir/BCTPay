import 'package:bctpay/globals/index.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg, {Color? backgroundColor}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: backgroundColor,
  );
}
