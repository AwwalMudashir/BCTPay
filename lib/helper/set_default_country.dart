import 'package:bctpay/globals/index.dart';

void setDefaultCountry(List<CountryData> countries) {
  selectCountryBloc.stream.listen((state) {
    if (state is SelectCountryState) {
      selectedCountry = state.countryData;
    }
  });
  if (countries.isNotEmpty) {
    int index = countries.indexWhere((element) => element.countryCode == 'NG');
    if (index != -1) {
      selectCountryBloc.add(SelectCountryEvent(
          Country.parse(countries[index].countryCode), countries[index]));
    } else {
      selectCountryBloc.add(SelectCountryEvent(
          Country.parse(countries.first.countryCode), countries.first));
    }
  }
}
