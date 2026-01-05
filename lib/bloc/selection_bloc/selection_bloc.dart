import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class SelectionBloc extends Bloc<SelectionBlocEvent, SelectionBlocState> {
  SelectionBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
      SelectionBlocEvent event, Emitter<SelectionBlocState> emit) {
    if (event is SelectCountryEvent) {
      emit(SelectCountryState(event.selectedCountry, event.countryData));
    }

    if (event is SelectStateEvent) {
      emit(SelectStateState(event.state));
    }

    if (event is SelectProviderEvent) {
      emit(SelectProviderState(event.provider));
    }
    if (event is SelectThemeEvent) {
      emit(SelectThemeState(event.themeMode));
    }
    if (event is SelectImageEvent) {
      emit(SelectImageState(event.image));
    }
    if (event is SelectMultipleMediaEvent) {
      emit(SelectMultipleMediaState(event.files));
    }
    if (event is SelectBankEvent) {
      emit(SelectBankState(event.bank));
    }
    if (event is SelectAccountEvent) {
      emit(SelectAccountState(event.account));
    }
    if (event is SelectKYCDocTypeEvent) {
      emit(SelectKYCDocTypeState(event.kycDoc));
    }
    if (event is SelectStringEvent) {
      emit(SelectStringState(event.value, isSelected: event.isSelected));
    }
    if (event is SelectBoolEvent) {
      emit(SelectBoolState(event.value));
    }

    if (event is SelectIntEvent) {
      emit(SelectIntState(event.value));
    }

    if (event is SelectDateRangeEvent) {
      emit(SelectDateRangeState(event.value));
    }

    if (event is SelectDateEvent) {
      emit(SelectDateState(event.value));
    }

    if (event is SelectIdProofEvent) {
      emit(SelectIdProofState(event.value));
    }

    if (event is RemoveIdProofEvent) {
      emit(RemoveIdProofState(event.value));
    }

    if (event is SelectQueryTypeEvent) {
      emit(SelectQueryTypeState(event.value));
    }

    if (event is SelectPayWithEvent) {
      emit(SelectPayWithState(event.value));
    }

    if (event is SelectPaymentTypeEvent) {
      emit(SelectPaymentTypeState(event.value));
    }

    if (event is SelectCardEvent) {
      emit(SelectCardState(event.value));
    }
    if (event is SelectListEvent) {
      emit(SelectListState(event.value));
    }
  }
}
