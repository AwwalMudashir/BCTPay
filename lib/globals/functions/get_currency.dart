import 'package:bctpay/globals/constants.dart';
import 'package:intl/intl.dart';

String getCurrency() {
  String localeCode = "${selectedLanguage}_${selectedCountry?.countryCode}";
  var currency = NumberFormat.simpleCurrency(locale: localeCode);
  return currency.currencyName ?? "GNF";
}
