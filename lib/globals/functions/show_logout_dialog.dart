import 'package:bctpay/globals/index.dart';

void showLogoutDialog(BuildContext context) {
  var textTheme = Theme.of(context).textTheme;
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  AwesomeDialog(
      context: context,
      dialogBackgroundColor: isDarkMode ? themeLogoColorBlue : Colors.white,
      dialogType: DialogType.question,
      title: AppLocalizations.of(context)!.doYouReallyWantToLogout,
      titleTextStyle: textTheme.titleMedium,
      btnOkText: AppLocalizations.of(context)!.yes,
      btnCancelText: AppLocalizations.of(context)!.no,
      btnOkColor: Colors.red,
      btnCancelColor: Colors.green,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        saveLoginDataAndClearAllAndNavigateToLogin(context);
      }).show();
}

void saveLoginDataAndClearAllAndNavigateToLogin(BuildContext context) async {
  bool isTourNavigationShowed =
      await SharedPreferenceHelper.getIsTourNavigationShowed();
  bool isIntroShowed = await SharedPreferenceHelper.getIsIntroShowed();
  bool isRemember = await SharedPreferenceHelper.getisRemember();
  if (isRemember) {
    String mobile = await SharedPreferenceHelper.getPhoneNumber();
    String password = await SharedPreferenceHelper.getPassword();
    SharedPreferenceHelper.clearAll();
    SharedPreferenceHelper.saveLoginCredentials(
        mobile: mobile, password: password, isRemember: isRemember);
  } else {
    SharedPreferenceHelper.clearAll();
  }
  SharedPreferenceHelper.setIsTourNavigationShowed(isTourNavigationShowed);
  SharedPreferenceHelper.setIsIntroShowed(isIntroShowed);
  if (!context.mounted) return;
  Navigator.of(context)
      .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
}
