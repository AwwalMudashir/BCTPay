import 'package:bctpay/globals/index.dart';

abstract class SelectionBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectCountryEvent extends SelectionBlocEvent {
  final Country selectedCountry;
  final CountryData countryData;
  SelectCountryEvent(this.selectedCountry, this.countryData);
  @override
  List<Object?> get props => [selectedCountry, countryData];
}

class SelectStateEvent extends SelectionBlocEvent {
  final StateData state;
  SelectStateEvent(this.state);
  @override
  List<Object?> get props => [state];
}

class SelectProviderEvent extends SelectionBlocEvent {
  final ProviderListItem provider;
  SelectProviderEvent(this.provider);
  @override
  List<Object?> get props => [provider];
}

class SelectThemeEvent extends SelectionBlocEvent {
  final ThemeMode themeMode;
  SelectThemeEvent(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}

class SelectImageEvent extends SelectionBlocEvent {
  final XFile? image;
  SelectImageEvent(this.image);
  @override
  List<Object?> get props => [image];
}

class SelectMultipleMediaEvent extends SelectionBlocEvent {
  final List<XFile?> files;
  SelectMultipleMediaEvent(this.files);
  @override
  List<Object?> get props => [files];
}

class SelectBankEvent extends SelectionBlocEvent {
  final Bank? bank;
  SelectBankEvent(this.bank);
  @override
  List<Object?> get props => [bank];
}

class SelectAccountEvent extends SelectionBlocEvent {
  final BankAccount? account;
  SelectAccountEvent(this.account);
  @override
  List<Object?> get props => [account];
}

class SelectKYCDocTypeEvent extends SelectionBlocEvent {
  final KYCDocData? kycDoc;
  SelectKYCDocTypeEvent(this.kycDoc);
  @override
  List<Object?> get props => [kycDoc];
}

class SelectStringEvent extends SelectionBlocEvent {
  final String? value;
  final bool? isSelected;
  SelectStringEvent(this.value, {this.isSelected});
  @override
  List<Object?> get props => [value, isSelected];
}

class SelectBoolEvent extends SelectionBlocEvent {
  final bool value;
  SelectBoolEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectIntEvent extends SelectionBlocEvent {
  final int value;
  SelectIntEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectDateRangeEvent extends SelectionBlocEvent {
  final DateTimeRange? value;
  SelectDateRangeEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectDateEvent extends SelectionBlocEvent {
  final DateTime value;
  SelectDateEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectIdProofEvent extends SelectionBlocEvent {
  final IdentityProof value;
  SelectIdProofEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class RemoveIdProofEvent extends SelectionBlocEvent {
  final IdentityProof value;
  RemoveIdProofEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectQueryTypeEvent extends SelectionBlocEvent {
  final QueryType value;
  SelectQueryTypeEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectPayWithEvent extends SelectionBlocEvent {
  final PayWith value;
  SelectPayWithEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectPaymentTypeEvent extends SelectionBlocEvent {
  final PaymentType value;
  SelectPaymentTypeEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectCardEvent extends SelectionBlocEvent {
  final CardData? value;
  SelectCardEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectListEvent extends SelectionBlocEvent {
  final List<String>? value;
  SelectListEvent(this.value);
  @override
  List<Object?> get props => [value];
}
