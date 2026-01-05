import 'package:bctpay/globals/index.dart';

Widget buildSubscriptionQRScreenshot(
    {required BuildContext context, required Subscriber? subscriber}) {
  return LocalizationsPortal(
    context: context,
    child: SubscriptionQRScreenView(
      subscriber: subscriber,
    ),
  );
}

class SubscriptionQRScreenView extends StatelessWidget {
  final Subscriber? subscriber;
  const SubscriptionQRScreenView({super.key, required this.subscriber});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode(context) ? themeLogoColorBlue : Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SubscriberListItem(subscriber: subscriber!),
          10.height,
          QRCodeViewWidget(
            qrCodeString: subscriber?.paymentLink ?? "",
            logo: subscriber?.merchantId?.companyLogo?.isNotEmpty ?? false
                ? "$baseUrlProfileImage${subscriber?.merchantId?.companyLogo}"
                : null,
          ),
          10.height,
          Text(
            subscriber?.merchantId?.businessCategoryName ?? "",
            style: textTheme(context).displayLarge,
          ),
          40.height,
          Text(
            appLocalizations(context).scanTheQRCodeToViewSubscriptionDetails,
            style: textTheme(context)
                .headlineLarge
                ?.copyWith(color: themeLogoColorOrange),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
