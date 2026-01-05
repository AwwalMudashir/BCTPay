import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyAhJDW_r12p_0jg-_MxSD31ZEdou9moMkI",
      appId: "1:993786256233:web:8a9acf05e066ecbef9fbf8",
      messagingSenderId: "993786256233",
      projectId: "bct-pay-3ca3b",
      authDomain: "bct-pay-3ca3b.firebaseapp.com",
      storageBucket: "bct-pay-3ca3b.appspot.com",
      measurementId: "G-SY1SRSJE5K");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCND-P0gAcAG0cxOjHxnuM23oxfGgVcOOY',
    appId: '1:993786256233:android:ae52574da5b963c4f9fbf8',
    messagingSenderId: '993786256233',
    projectId: 'bct-pay-3ca3b',
    // databaseURL:
    // 'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'bct-pay-3ca3b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDv0ynvFllyrwS69dTstcYKq0rWaiyBuKU',
    appId: '1:993786256233:ios:dcc9e81921879eb7f9fbf8',
    messagingSenderId: '993786256233',
    projectId: 'bct-pay-3ca3b',
    // databaseURL:
    // 'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'bct-pay-3ca3b.appspot.com',
    // androidClientId:
    // '406099696497-tvtvuiqogct1gs1s6lh114jeps7hpjm5.apps.googleusercontent.com',
    // iosClientId:
    // '406099696497-taeapvle10rf355ljcvq5dt134mkghmp.apps.googleusercontent.com',
    iosBundleId: 'com.bctpay',
  );
}
