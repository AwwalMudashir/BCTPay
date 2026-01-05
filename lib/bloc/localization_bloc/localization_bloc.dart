import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class LocalizationBloc
    extends Bloc<LocalizationBlocEvent, LocalizationBlocState> {
  LocalizationBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
      LocalizationBlocEvent event, Emitter<LocalizationBlocState> emit) {
    if (event is ChangeLocaleEvent) {
      emit(ChangeLocaleState(event.locale));
    }
  }
}
