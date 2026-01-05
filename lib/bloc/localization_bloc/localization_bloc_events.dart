import 'package:bctpay/globals/index.dart';

abstract class LocalizationBlocEvent extends Equatable {}

class ChangeLocaleEvent extends LocalizationBlocEvent {
  final Locale locale;
  ChangeLocaleEvent(this.locale);
  @override
  List<Object?> get props => [locale];
}
