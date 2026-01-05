import 'package:bctpay/globals/index.dart';
import 'package:bctpay/views/widget/common_address_view.dart';

class UserInfoView extends StatelessWidget {
  final Customer? user;

  const UserInfoView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.imageView,
                    arguments: ImageView(
                      imageUrl: "$baseUrlProfileImage${user?.companyLogo}",
                    ));
              },
              child: Avatar(
                url: "$baseUrlProfileImage${user?.companyLogo}",
                errorImageUrl: Assets.assetsImagesPerson,
              ),
            )),
        10.height,
        Text(
          user?.businessCategoryName ?? appLocalizations(context).unknown,
          textAlign: TextAlign.center,
          style: textTheme(context)
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail_outline_rounded,
              color: themeLogoColorOrange,
              size: 20,
            ),
            5.width,
            Text(
              user?.email ?? "",
              style: textTheme(context).bodySmall,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountryFlag.fromCountryCode(
              selectedCountry!.countryCode,
              height: 16,
              width: 25,
            ),
            5.width,
            Text(user?.phonenumber ?? ""),
          ],
        ),
        CommonAddressView(
          showAddressIcon: true,
          line1: user?.line1,
          line2: user?.line2,
          city: user?.city,
          country: user?.country,
        ),
      ],
    );
  }
}
