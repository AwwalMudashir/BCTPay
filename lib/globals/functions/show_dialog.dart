import 'package:bctpay/globals/index.dart';

void showCustomDialog(String msg, context,
    {bool dismissOnTouchOutside = true,
    bool dismissOnBackKeyPress = true,
    bool showCancel = true,
    void Function()? onYesTap,
    void Function()? onNoTap,
    String? title,
    Widget? body,
    String? btnOkText,
    String? btnNoText,
    Widget? customHeader,
    DialogType dialogType = DialogType.info,
    Color? dialogBackgroundColor}) {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  AwesomeDialog(
    context: context,
    dismissOnTouchOutside: dismissOnTouchOutside,
    dismissOnBackKeyPress: dismissOnBackKeyPress,
    // dialogBackgroundColor: dialogBackgroundColor,
    dialogBackgroundColor: isDarkMode ? themeLogoColorBlue : Colors.white,
    title: title,
    desc: msg,
    body: body,
    dialogType: dialogType,
    barrierColor: Colors.black87,
    customHeader: customHeader,
    btnCancel: showCancel
        ? CustomBtn(
            color: Colors.red,
            text: btnNoText ?? appLocalizations(context).no,
            onTap: onNoTap ??
                () {
                  Navigator.pop(context);
                },
          )
        : null,
    btnOk: CustomBtn(
      text: btnOkText ?? appLocalizations(context).yes,
      onTap: onYesTap ??
          () {
            Navigator.pop(context);
          },
    ),
  ).show();
}
