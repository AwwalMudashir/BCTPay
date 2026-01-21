
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<LoginResponse> login({
  required LoginBody? loginBody,
}) async {
  final otp = loginBody?.otp;
  if ((otp ?? "").isNotEmpty) {
    await verifyRegistrationOtp(
      email: loginBody?.email ?? "",
      otp: otp!,
    );
  }

  // Encrypt password using help2pay/Fortitude scheme (AES/CBC/PKCS7 with fixed key/iv)
  final rawPwd = loginBody?.password ?? "";
  final encodedPassword = hashPwdAndEncrypt(rawPwd);

  final payload = {
    'entityCode': 'BCT',
    'channelType': 'MOBILE',
    'username': loginBody?.email ?? '',
    'password': encodedPassword,
    'deviceId': loginBody?.deviceId ?? '',
  };

  print("${ApiEndpoint.login} URL: $baseUrlCorePublic/${ApiEndpoint.login}");
  final headers = await ApiClient.header(useCore: true);
  print("${ApiEndpoint.login} Headers: ${jsonEncode(headers)}");
  print("${ApiEndpoint.login} Request: ${jsonEncode(payload)}");

  final response = await http.post(
    Uri.parse("$baseUrlCorePublic/${ApiEndpoint.login}"),
    headers: headers,
    body: jsonEncode(payload),
  );

  print("${ApiEndpoint.login} Response [${response.statusCode}]: ${response.body}");

  final raw = json.decode(response.body);

  // Normalize code/message/success for Fortitude login shape
  String? codeString;
  int? parsedCode;
  String? message;
  bool successFlag = false;
  dynamic data;

  if (raw is Map) {
    final rc = raw["responseCode"] ?? raw["code"];
    codeString = rc?.toString();
    if (rc is int) {
      parsedCode = rc;
    } else if (rc is String) {
      parsedCode = int.tryParse(rc);
    }

    message = raw["responseMessage"] ?? raw["message"] ?? raw["desc"] ?? raw["error"];

    final ticket = raw["ticketID"] ?? raw["token"];
    data = {
      "token": ticket ?? "",
      "kong_server_token": ticket ?? "",
      "username": raw["username"]?.toString(),
      "fullname": raw["fullname"]?.toString(),
      "email": raw["email"]?.toString(),
      "mobileNo": raw["mobileNo"]?.toString(),
      "userRole": raw["userRole"]?.toString(),
      "customerId": raw["customerId"]?.toString(),
      "country": raw["country"]?.toString(),
      "language": raw["language"]?.toString(),
      "lastLoginDate": raw["lastLoginDate"]?.toString(),
      "ccy": raw["ccy"]?.toString(),
      "partnerLink": raw["partnerLink"]?.toString(),
      "responseCode": codeString,
      "responseMessage": message,
    };

    successFlag = codeString == "00" ||
        codeString == "000" ||
        codeString == "0" ||
        parsedCode == 200 ||
        parsedCode == 201 ||
        (message?.toUpperCase().contains("SUCCESS") ?? false);
  }

  final normalized = {
    "code": parsedCode,
    "codeString": codeString,
    "message": message,
    "success": successFlag,
    "error": (raw is Map) ? (raw["error"] ?? raw["errorMessage"]) : null,
    "data": data,
  };

  if (response.statusCode == 200) {
    print("${ApiEndpoint.login} Normalized Resp: ${jsonEncode(normalized)}");
    return LoginResponse.fromJson(normalized);
  } else {
    throw ExceptionHandler.handleHttpResponse(response);
  }
}
