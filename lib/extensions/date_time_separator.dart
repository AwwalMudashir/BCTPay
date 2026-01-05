import 'package:bctpay/lib.dart';
import 'package:intl/intl.dart';

const String dateTimeFormatString = "dd MMM yyyy";

extension DateTimeSeparator on DateTime {
  String separateDateTime() => toString().split(".").first;
  String separateDate() => toString().split(" ").first;
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  String formattedDate() =>
      DateFormat.yMMMMd(selectedLanguage).format(toLocal());

  String formattedDateTime() {
    final isFrench = selectedLanguage == 'fr';
    final dateFormat = DateFormat.yMMMMd(selectedLanguage); // Localized date
    final timeFormat = DateFormat(isFrench ? 'HH:mm' : 'h:mm a',
        selectedLanguage); // Time based on locale
    return '${dateFormat.format(this)} ${timeFormat.format(this)}';
  }

  String formatValidityDateTime() =>
      DateFormat.yMMMMd(selectedLanguage).format(toLocal());

  bool isSameDay(DateTime date) =>
      day == date.day && month == date.month && year == date.year;

  bool isExpired() => isBefore(DateTime.now().toLocal());

  String formatRelativeDateTime(BuildContext context) =>
      dateTimeFormat(this, context: context);
}
