import 'package:firebase_analytics/firebase_analytics.dart';

void firebaseAnalyticsConfig() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen();
}
