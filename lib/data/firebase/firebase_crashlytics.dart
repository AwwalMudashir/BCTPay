import 'dart:ui';

import 'package:bctpay/globals/index.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void firebaseCrashlyticsConfig() {
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
