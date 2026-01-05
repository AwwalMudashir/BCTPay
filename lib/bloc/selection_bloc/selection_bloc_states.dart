import 'package:bctpay/globals/index.dart';

abstract class SelectionBlocState extends Equatable {}

class SelectionBlocInitialState extends SelectionBlocState {
  @override
  List<Object?> get props => [];
}

class SelectionBlocLoadingState extends SelectionBlocState {
  @override
  List<Object?> get props => [];
}

class SelectCountryState extends SelectionBlocState {
  final Country selectedCountry;
  final CountryData countryData;
  SelectCountryState(this.selectedCountry, this.countryData);
  @override
  List<Object?> get props => [selectedCountry, countryData];
}

class SelectStateState extends SelectionBlocState {
  final StateData state;
  SelectStateState(this.state);
  @override
  List<Object?> get props => [state];
}

class SelectProviderState extends SelectionBlocState {
  final ProviderListItem provider;
  SelectProviderState(this.provider);
  @override
  List<Object?> get props => [provider];
}

class SelectThemeState extends SelectionBlocState {
  final ThemeMode themeMode;

  SelectThemeState(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class SelectImageState extends SelectionBlocState {
  final XFile? image;
  SelectImageState(this.image);
  @override
  List<Object?> get props => [image];
}

class SelectMultipleMediaState extends SelectionBlocState {
  final List<XFile?> files;
  SelectMultipleMediaState(this.files);
  @override
  List<Object?> get props => [files];
}

class SelectBankState extends SelectionBlocState {
  final Bank? bank;
  SelectBankState(this.bank);
  @override
  List<Object?> get props => [bank];
}

class SelectAccountState extends SelectionBlocState {
  final BankAccount? account;
  SelectAccountState(this.account);
  @override
  List<Object?> get props => [account];
}

class SelectKYCDocTypeState extends SelectionBlocState {
  final KYCDocData? kycDoc;
  SelectKYCDocTypeState(this.kycDoc);
  @override
  List<Object?> get props => [kycDoc];
}

class SelectStringState extends SelectionBlocState {
  final String? value;
  final bool? isSelected;
  SelectStringState(this.value, {this.isSelected});
  @override
  List<Object?> get props => [value, isSelected];
}

class SelectBoolState extends SelectionBlocState {
  final bool value;
  SelectBoolState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectIntState extends SelectionBlocState {
  final int value;
  SelectIntState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectDateRangeState extends SelectionBlocState {
  final DateTimeRange? value;
  SelectDateRangeState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectDateState extends SelectionBlocState {
  final DateTime value;
  SelectDateState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectIdProofState extends SelectionBlocState {
  final IdentityProof value;
  SelectIdProofState(this.value);
  @override
  List<Object?> get props => [value];
}

class RemoveIdProofState extends SelectionBlocState {
  final IdentityProof value;
  RemoveIdProofState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectQueryTypeState extends SelectionBlocState {
  final QueryType value;
  SelectQueryTypeState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectPayWithState extends SelectionBlocState {
  final PayWith value;
  SelectPayWithState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectPaymentTypeState extends SelectionBlocState {
  final PaymentType value;
  SelectPaymentTypeState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectCardState extends SelectionBlocState {
  final CardData? value;
  SelectCardState(this.value);
  @override
  List<Object?> get props => [value];
}

class SelectListState extends SelectionBlocState {
  final List<String>? value;
  SelectListState(this.value);
  @override
  List<Object?> get props => [value];
}
