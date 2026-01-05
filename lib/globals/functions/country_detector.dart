import 'package:bctpay/globals/index.dart';

Future<CountryData?> seperatePhoneAndDialCode(String phoneWithDialCode,
    {bool changeCountry = true, SelectionBloc? selectPhoneCountryBloc}) async {
  try {
    var allCountries = await getCountryList();
    CountryData? foundedCountry;
    for (CountryData country in allCountries.data ?? []) {
      String dialCode = "+${country.phoneCode}";
      if (phoneWithDialCode.contains(dialCode)) {
        foundedCountry = country;
      }
    }

    if (foundedCountry != null) {
      if (changeCountry) {
        (selectPhoneCountryBloc ?? selectCountryBloc).add(SelectCountryEvent(
            Country.parse(foundedCountry.countryCode), foundedCountry));
      }
      return foundedCountry;
    } else {
      return null;
    }
  } catch (e) {
    if (e is TooManyRequestException) {
      showToast(e.error);
    }
    throw Exception(e);
  }
}

Future<CountryData?> getCountryWithCountryName(String? countryName) async {
  try {
    var allCountries = await getCountryList();
    CountryData? foundedCountry;
    for (CountryData country in allCountries.data ?? []) {
      String name = country.countryName.toString();
      if (countryName?.contains(name) ?? false) {
        foundedCountry = country;
        selectedCountry = country;
      } else {
       // log("Country not found with name: $countryName");
      }
    }
    return foundedCountry;
  } catch (e) {
    if (e is TooManyRequestException) {
      showToast(e.error);
    }
    throw Exception(e);
  }
}