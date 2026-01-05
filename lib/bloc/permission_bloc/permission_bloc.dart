import 'package:bctpay/globals/index.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
      PermissionEvent event, Emitter<PermissionState> emit) async {
    if (event is PermissionRequestEvent) {
      await event.permission.status.then((value) async {
        switch (value) {
          case PermissionStatus.denied:
            value = await event.permission.request();
            break;
          case PermissionStatus.granted:
            break;
          case PermissionStatus.restricted:
            value = await event.permission.request();
            break;
          case PermissionStatus.limited:
            value = await event.permission.request();
            break;
          case PermissionStatus.permanentlyDenied:
            // openAppSettings();
            break;
          case PermissionStatus.provisional:
            value = await event.permission.request();
            break;
        }
        emit(PermissionRequestState(value));
      });
    }
    return null;
  }
}
