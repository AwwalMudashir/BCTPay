import 'package:bctpay/data/repository/auth_repo/verify_registration_otp_api.dart';
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
  var response = await http.post(
      Uri.parse("$baseUrlPublic/${ApiEndpoint.login}"),
      headers: await ApiClient.header(),
      body: jsonEncode(loginBody?.toJson()));

  log("${ApiEndpoint.login} ${jsonEncode(loginBody?.toJson())}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    log("${ApiEndpoint.login} Resp: ${jsonEncode(data)}");
    return LoginResponse.fromJson(data);
  } else {
    throw ExceptionHandler.handleHttpResponse(response);
  }
}
