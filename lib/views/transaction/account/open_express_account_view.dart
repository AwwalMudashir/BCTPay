import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class OpenExpressAccountView extends StatelessWidget {
  const OpenExpressAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var isDarkmode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: shadowDecoration.copyWith(
          color: isDarkmode ? themeLogoColorBlue : tileColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const Icon(Icons.account_balance),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations(context).openXpressAccountViewTitle,
                  style: textTheme.bodySmall?.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 5)),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.openExpressAccount);
              },
              child: Text(
                appLocalizations(context).openAccount,
                style: textTheme.bodySmall
                    ?.copyWith(fontSize: 10, color: Colors.black),
              )),
        ],
      ),
    );
  }
}
