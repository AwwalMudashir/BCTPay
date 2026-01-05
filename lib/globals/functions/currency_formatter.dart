import 'package:bctpay/globals/index.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

NumberFormat getNumberFormat() => NumberFormat.currency(
      locale: "${selectedLanguage}_${selectedCountry?.countryCode}",
      symbol: "${selectedCountry?.currencySymbol} ",
    );

CurrencyTextInputFormatter currencyTextInputFormatter =
    CurrencyTextInputFormatter.currency(
  locale: "${selectedLanguage}_${selectedCountry?.countryCode}",
  decimalDigits: 2,
  symbol: "", //selectedCountry?.currencySymbol,
  enableNegative: false,
);

String formatCurrency(String amount) {
  var formatted = getNumberFormat().format(double.parse(amount));

  ///TODO: comment below code if you want currency symbol left side in en locale for GN country
  if (selectedCountry?.countryCode == "GN" && selectedLanguage == "en") {
    formatted = formatted.replaceAll(selectedCountry?.currencyCode ?? "", "");
    formatted = "$formatted ${selectedCountry?.currencySymbol}";
  }
  return formatted.trim();
}
