import 'package:bctpay/globals/index.dart';
import 'package:bctpay/views/my_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env.production");
  // Bloc.observer = AppBlocObserver();
  firebaseAnalyticsConfig();
  firebaseCrashlyticsConfig();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}
