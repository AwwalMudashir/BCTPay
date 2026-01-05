import 'package:bctpay/globals/index.dart';

Widget buildProfileQRScreenshot(
    {required BuildContext context, required UserModel? user}) {
  return LocalizationsPortal(
    context: context,
    child: ProfileQRScreenView(
      user: user,
    ),
  );
}

class ProfileQRScreenView extends StatelessWidget {
  final UserModel? user;
  const ProfileQRScreenView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode(context) ? themeLogoColorBlue : Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QRCodeViewWidget(
            qrCodeString: user?.qrString ?? "",
            logo: "$baseUrlProfileImage${user?.adminLogoForDarkTheme}",
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user?.userName ?? appLocalizations(context).unknown,
            softWrap: true,
            textAlign: TextAlign.center,
            style: textTheme(context).displayLarge,
          ),
          40.height,
          Text(
            appLocalizations(context).scanToPayWithBCTPayApp,
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
