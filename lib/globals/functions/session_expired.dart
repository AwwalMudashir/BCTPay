import 'package:bctpay/globals/index.dart';

void sessionExpired(String msg, BuildContext context) {
  showToast(msg);
  SharedPreferenceHelper.setIsLogin(false);
  Navigator.of(context)
      .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
}
