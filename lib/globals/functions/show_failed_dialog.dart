import 'package:bctpay/globals/index.dart';

void showFailedDialog(String msg, context,
    {bool dismissOnTouchOutside = true,
    bool dismissOnBackKeyPress = true,
    void Function()? onTap,
    String? title,
    String? btnOkText,
    DialogType dialogType = DialogType.error,
    Widget? hyperlink}) {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  AwesomeDialog(
    context: context,
    dismissOnTouchOutside: dismissOnTouchOutside,
    dismissOnBackKeyPress: dismissOnBackKeyPress,
    dialogBackgroundColor: isDarkMode ? themeLogoColorBlue : Colors.white,
    title: title ?? appLocalizations(context).failedDialogTitle,
    desc: msg,
    dialogType: dialogType,
    btnOk: Column(
      children: [
        CustomBtn(
          text: btnOkText ?? appLocalizations(context).close,
          onTap: onTap ??
              () {
                Navigator.pop(context);
              },
        ),
        if (hyperlink != null) hyperlink,
      ],
    ),
    // btnCancel: hyperlink,
  ).show();
}
