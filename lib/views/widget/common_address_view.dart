import 'package:bctpay/lib.dart';

class CommonAddressView extends StatelessWidget {
  const CommonAddressView({
    super.key,
    this.showAddressIcon = false,
    this.line1,
    this.line2,
    this.city,
    this.landmark,
    this.country,
    this.textStyle,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.iconSize = 20,
  });

  final bool showAddressIcon;
  final String? line1;
  final String? line2;
  final String? city;
  final String? landmark;
  final String? country;
  final TextStyle? textStyle;
  final MainAxisAlignment mainAxisAlignment;
  final double iconSize;

  bool checkIsEmpty(String? str) => str?.isNotEmpty ?? false;

  String? getAddress({
    String? line1,
    String? line2,
    String? landmark,
    String? city,
    String? state,
    String? country,
  }) {
    String address = "";
    if (line1?.isNotEmpty ?? false) {
      address = address.isNotEmpty ? "$address, $line1" : line1 ?? "";
    }
    if (line2?.isNotEmpty ?? false) {
      address = address.isNotEmpty ? "$address, $line2" : line2 ?? "";
    }
    if (landmark?.isNotEmpty ?? false) {
      address = address.isNotEmpty ? "$address, $landmark" : landmark ?? "";
    }
    if (city?.isNotEmpty ?? false) {
      address = address.isNotEmpty ? "$address, $city" : city ?? "";
    }
    if (state?.isNotEmpty ?? false) {
      address = address.isNotEmpty ? "$address, $state" : state ?? "";
    }
    if (country?.isNotEmpty ?? false) {
      address = address.isNotEmpty ? "$address, $country" : country ?? "";
    }
    return address;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (checkIsEmpty(line1))
          Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showAddressIcon)
                Icon(
                  Icons.location_on_outlined,
                  color: themeLogoColorOrange,
                  size: iconSize,
                ),
              Flexible(
                child: Text(
                  line1 ?? "",
                  maxLines: 2,
                  softWrap: true,
                  style: textStyle ?? textTheme(context).bodySmall,
                ),
              ),
            ],
          ),
        if (checkIsEmpty(line2))
          Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!checkIsEmpty(line1) && showAddressIcon)
                Icon(
                  Icons.location_on_outlined,
                  color: themeLogoColorOrange,
                  size: iconSize,
                ),
              Flexible(
                child: Text(
                  line2 ?? "",
                  maxLines: 2,
                  softWrap: true,
                  style: textStyle ?? textTheme(context).bodySmall,
                ),
              ),
            ],
          ),
        if (getAddress(
                    landmark: landmark ?? "",
                    city: city ?? "",
                    country: country ?? "")
                ?.isNotEmpty ??
            false)
          Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!checkIsEmpty(line1) &&
                  !checkIsEmpty(line2) &&
                  showAddressIcon)
                Icon(
                  Icons.location_on_outlined,
                  color: themeLogoColorOrange,
                  size: iconSize,
                ),
              Flexible(
                child: Text(
                  getAddress(
                          landmark: landmark ?? "",
                          city: city ?? "",
                          country: country ?? "") ??
                      "",
                  maxLines: 2,
                  softWrap: true,
                  style: textStyle ?? textTheme(context).bodySmall,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
