import 'package:bctpay/globals/index.dart';

void showSuccessDialog(
  String msg,
  context, {
  bool redirectToLogin = false,
  bool dismissOnTouchOutside = true,
  bool dismissOnBackKeyPress = true,
  onOkBtnPressed,
}) {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  AwesomeDialog(
      context: context,
      title: "${appLocalizations(context).dialogTitleSuccess}!",
      dismissOnTouchOutside: dismissOnTouchOutside,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      dialogBackgroundColor: isDarkMode ? themeLogoColorBlue : Colors.white,
      desc: msg,
      dialogType: DialogType.success,
      btnOk: CustomBtn(
        text: appLocalizations(context).ok,
        onTap: onOkBtnPressed ??
            () {
              if (redirectToLogin) {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
      )).show();
}
