import 'package:bctpay/lib.dart';
import 'package:intl/intl.dart';

String dateTimeFormat(DateTime date1, {required BuildContext context}) {
  var date = date1.toLocal();
  return (date.isToday())
      ? '${appLocalizations(context).today} @ ${DateFormat(selectedLanguage == 'fr' ? "HH:mm" : 'h:mm a', selectedLanguage).format(date)}'
      : (date.isYesterday())
          ? '${appLocalizations(context).yesterday} @ ${DateFormat(selectedLanguage == 'fr' ? "HH:mm" : 'h:mm a', selectedLanguage).format(date)}'
          : DateFormat.yMMMMd(selectedLanguage).format(date);
}

class DateTimeHelper {
  static DateTime? tryParse(String value) =>
      DateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z")
          .tryParse(value, true)
          ?.toLocal();
}
