import 'package:bctpay/globals/index.dart';
import 'package:bctpay/views/my_app.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void firebaseAnalyticsConfig(){
  //TODO: Implement firebase analytics
}

void firebaseCrashlyticsConfig(){
  //TODO: Implement firebase crashlytics
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  // Bloc.observer = AppBlocObserver();
  firebaseAnalyticsConfig();
  firebaseCrashlyticsConfig();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}