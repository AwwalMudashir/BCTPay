import 'package:bctpay/globals/index.dart';

class ApiClient {
  static String appBaseUrl = baseUrl;
  final SharedPreferenceHelper sharedPreferences = SharedPreferenceHelper();
  static const String noInternetMessage = 'No internet';
  final int timeoutInSeconds = 30;

  // ApiClient({required this.appBaseUrl, required this.sharedPreferences});

  static Future<Map<String, String>> header() async => {
        "x-token": await SharedPreferenceHelper.getAccessToken(),
        'Authorization':
            'Bearer ${await SharedPreferenceHelper.getKongServerToken()}',
        'Content-Type': 'application/json',
        'Accept-Language': selectedLanguage,
        // "api-token": wlID,fdfgd
        // 'Access-Control-Allow-Origin': '*',
        // 'Access-Control-Allow-Credentials': 'true',
        // 'Access-Control-Allow-Headers': 'Content-Type',
        // 'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      };
}
