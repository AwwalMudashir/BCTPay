import 'package:bctpay/globals/index.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentPage = 0;
  final imageHeight = 220.0;
  final titleFontSize = 26.0;
  final titleFontWeight = FontWeight.w900;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var pages = [
      PageViewModel(
        image: SizedBox(
          height: imageHeight,
          child: Image.asset(Assets.assetsImagesNewIntro1),
        ),
        decoration: const PageDecoration(
          bodyAlignment: Alignment.center,
          pageColor: backgroundColor,
        ),
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations(context).meetYourBusiness,
              style: textTheme.displayMedium,
            ),
            Row(
              children: [
                Text(
                  "${appLocalizations(context).goals} ",
                  style: textTheme.displayMedium,
                ),
                Text(
                  appLocalizations(context).faster,
                  style: textTheme.displayMedium
                      ?.copyWith(color: const Color(0xffEEAB00)),
                ),
              ],
            ),
          ],
        ),
        bodyWidget: Text(
          appLocalizations(context)
              .bCTPayCanHelpYouReachAWideUserBaseWithTargetedCampaignsDesignedToMeetYourBusinessNeeds,
        ),
      ),
      PageViewModel(
        image: SizedBox(
          height: imageHeight,
          child: Image.asset(Assets.assetsImagesNewIntro2),
        ),
        decoration: const PageDecoration(
          bodyAlignment: Alignment.center,
          pageColor: backgroundColor,
        ),
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations(context).easiestWayToManage,
              style: textTheme.displayMedium,
            ),
            Row(
              children: [
                Text(
                  "${appLocalizations(context).your} ",
                  style: textTheme.displayMedium,
                ),
                Text(
                  appLocalizations(context).wallet,
                  style: textTheme.displayMedium
                      ?.copyWith(color: const Color(0xffEEAB00)),
                ),
              ],
            ),
          ],
        ),
        bodyWidget: Text(
          appLocalizations(context)
              .yourGoalsWillHelpUsToFormulateTheRightRecommendationsForSuccess,
        ),
      ),
      PageViewModel(
        image: SizedBox(
          height: imageHeight,
          child: Image.asset(Assets.assetsImagesNewIntro3),
        ),
        decoration: const PageDecoration(
          bodyAlignment: Alignment.center,
          pageColor: backgroundColor,
        ),
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations(context).makeOnline,
              style: textTheme.displayMedium,
            ),
            Row(
              children: [
                Text(
                  "${appLocalizations(context).paymentN} ",
                  style: textTheme.displayMedium,
                ),
                Text(
                  appLocalizations(context).enjoy,
                  style: textTheme.displayMedium
                      ?.copyWith(color: const Color(0xffEEAB00)),
                ),
              ],
            ),
          ],
        ),
        bodyWidget: Text(
          appLocalizations(context)
              .youCanDoAnyOnlinePaymentFromAnyCardOrAccountJustScanTheQRCodeNEnjoy,
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      body: IntroductionScreen(
        globalBackgroundColor: backgroundColor,
        onChange: (value) {
          currentPage = value;
        },
        pages: pages,
        showNextButton: false,
        showDoneButton: true,
        done: Text(appLocalizations(context).done),
        dotsDecorator: DotsDecorator(
            size: const Size(35, 8),
            activeColor: const Color(0xffEEAB00),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onDone: () {
          SharedPreferenceHelper.setIsIntroShowed(true);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        },
      ),
    );
  }
}
