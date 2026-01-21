import 'package:bctpay/globals/index.dart';

class ApiClient {
  static String appBaseUrl = baseUrl;
  final SharedPreferenceHelper sharedPreferences = SharedPreferenceHelper();
  static const String noInternetMessage = 'No internet';
  final int timeoutInSeconds = 30;

  // ApiClient({required this.appBaseUrl, required this.sharedPreferences});

  static Future<Map<String, String>> header({bool useCore = false}) async {
    final headers = <String, String>{
        "x-token": await SharedPreferenceHelper.getAccessToken(),
      'Authorization': 'Bearer ${await SharedPreferenceHelper.getKongServerToken()}',
        'Content-Type': 'application/json',
        'Accept-Language': selectedLanguage,
        // "api-token": wlID,fdfgd
        // 'Access-Control-Allow-Origin': '*',
        // 'Access-Control-Allow-Credentials': 'true',
        // 'Access-Control-Allow-Headers': 'Content-Type',
        // 'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      };

    if (useCore) {
      headers.addAll({
        'x-client-id': 'TST03054745785188010772',
        'x-client-secret': 'TST03722175625334233555707073458615741827171811840881',
        'x-source-code': 'BCTPAY',
      });
    }

    return headers;
  }
}
