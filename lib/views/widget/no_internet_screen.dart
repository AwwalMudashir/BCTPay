import 'package:bctpay/globals/index.dart';

class NoInternetScreen extends StatelessWidget {
  final void Function()? onTap;
  const NoInternetScreen({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            appLocalizations(context).oopsNoInternet,
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            appLocalizations(context).pleaseCheckYourNetworkConnection,
            style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomBtn(
            text: appLocalizations(context).tryAgain,
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
