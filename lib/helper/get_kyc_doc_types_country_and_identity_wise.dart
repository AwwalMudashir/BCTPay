import 'package:bctpay/globals/globals.dart';

List<KYCDocData> getKYCDocTypesCountryAndIdentityWise(
        {List<KYCDocData>? kycDocsList,
        required String identityTypeForIdentity}) =>
    kycDocsList!
        .where((e) =>
            (e.countryCode == selectedCountry?.countryCode ||
                e.accessType == "GLOBAL") &&
            e.identityType?.toLowerCase() ==
                identityTypeForIdentity.toLowerCase())
        .toList();
