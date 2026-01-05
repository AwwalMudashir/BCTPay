import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:scratcher/widgets.dart';

class CouponDetailView extends StatelessWidget {
  final Coupon? coupon;

  const CouponDetailView({super.key, this.coupon});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as CouponDetailView;
    var coupon = args.coupon;
    const space = 3.0;
    var bodyColor = isDarkMode(context) ? Colors.white : Colors.black;
    return Scaffold(
      appBar: const CustomAppBar(title: ""),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          CachedNetworkImage(
            imageUrl: baseUrlBanner + (coupon?.coupenImage ?? ""),
            fit: BoxFit.cover,
            progressIndicatorBuilder: progressIndicatorBuilder,
            errorWidget: (context, url, error) => const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.card_giftcard_rounded,
                size: 100,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            coupon?.coupenTitle ?? "",
            style: textTheme(context).headlineLarge?.copyWith(),
          ),
          const SizedBox(
            height: 10,
          ),
          Scratcher(
            brushSize: 30,
            threshold: 50,
            color: Colors.blue,
            child: SizedBox(
              height: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      coupon?.coupenCode ?? "",
                      style: textTheme(context)
                          .headlineLarge
                          ?.copyWith(color: themeLogoColorOrange),
                    ),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(
                                  ClipboardData(text: coupon?.coupenCode ?? ""))
                              .whenComplete(() {
                            if (!context.mounted) return;
                            showToast(appLocalizations(context).copied);
                          });
                        },
                        icon: const Icon(
                          Icons.file_copy_outlined,
                          size: 20,
                        ))
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(appLocalizations(context).scratchHere)),
          const SizedBox(
            height: 10,
          ),
          ExpansionTile(
            initiallyExpanded: true,
            title: TitleWidget(title: appLocalizations(context).details),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "• ${appLocalizations(context).valid} ${coupon?.coupenUses}",
                style: textTheme(context)
                    .headlineSmall
                    ?.copyWith(color: bodyColor),
              ),
              const SizedBox(
                height: space,
              ),
              Text(
                "• ${appLocalizations(context).minimumOrderValueIs} ${coupon?.minOrderValue}",
                style: textTheme(context)
                    .headlineSmall
                    ?.copyWith(color: bodyColor),
              ),
              const SizedBox(
                height: space,
              ),
              Text(
                "• ${appLocalizations(context).youCanGetUpto} ${coupon?.maxDiscount}",
                style: textTheme(context)
                    .headlineSmall
                    ?.copyWith(color: bodyColor),
              ),
              const SizedBox(
                height: space,
              ),
              Text(
                "• ${appLocalizations(context).validFrom} ${coupon?.startDate.formatRelativeDateTime(context) ?? ""} ${appLocalizations(context).upto} ${coupon?.endDate.formatRelativeDateTime(context) ?? ""}",
                style: textTheme(context)
                    .headlineSmall
                    ?.copyWith(color: bodyColor),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          ExpansionTile(
            title: TitleWidget(title: appLocalizations(context).couponTnc),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${coupon?.termsAndCondition}",
                style: textTheme(context)
                    .headlineSmall
                    ?.copyWith(color: bodyColor),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
