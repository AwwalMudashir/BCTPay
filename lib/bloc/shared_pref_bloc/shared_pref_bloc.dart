import 'dart:developer' as developer;

import 'package:bctpay/globals/index.dart';

class SharedPrefBloc extends Bloc<SharedPrefEvent, SharedPrefState> {
  SharedPrefBloc(super.initialState) {
    on<SharedPrefEvent>((event, emit) {
      return emit.forEach<SharedPrefState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error',
              name: 'SharedPrefBloc', error: error, stackTrace: stackTrace);
          return ErrorSharedPrefState(error.toString());
        },
      );
    });
  }
}
