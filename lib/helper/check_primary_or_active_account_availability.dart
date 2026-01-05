import 'package:bctpay/globals/index.dart';

Future<void> checkPrimaryOrActiveAccountAvailability(
    BuildContext context) async {
  var response = await getBankAccountList();
  var accountsList = response.data ?? [];
  if (accountsList.isNotEmpty) {
    var activeAccountsList =
        accountsList.where((account) => account.accountstatus == "1").toList();
    if (activeAccountsList.isEmpty) {
      debugPrint("No active accounts");
      if (!context.mounted) return;
      showCustomDialog(
        appLocalizations(context).pleaseAddAtleastOneactiveAccount,
        context,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        showCancel: false,
        btnOkText: appLocalizations(context).ok,
        onYesTap: () {
          Navigator.popUntil(
              context, (route) => route.settings.name == AppRoutes.bottombar);
        },
      );
    } else {
      debugPrint("Active accounts available");
    }
  } else {
    debugPrint("No accounts");
    if (!context.mounted) return;
    showCustomDialog(
      appLocalizations(context).pleaseAddAtleastOneactiveAccount,
      context,
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      showCancel: false,
      btnOkText: appLocalizations(context).ok,
      onYesTap: () {
        Navigator.popUntil(
            context, (route) => route.settings.name == AppRoutes.bottombar);
      },
    );
  }
}
