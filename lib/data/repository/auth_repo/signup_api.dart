import 'package:bctpay/globals/index.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<Response> signup({
  required String email,
  required String phoneCode,
  required String phoneNumber,
  required String password,
  required String firstName,
  String? lastName,
  String? address,
  String? pinCode,
  String? city,
  String? country,
  String? gender,
}) async {
  var body = {
    "email": email,
    "phone_code": phoneCode,
    "phonenumber": phoneNumber,
    "password": password,
    "firstname": firstName,
    "state": "",
    "device_name": await DeviceInfo.getDeviceName(),
    "device_id": await DeviceInfo.getDeviceId(),
    "device_token": Platform.isIOS
        ? (kReleaseMode ? await getFcmToken() : "12345")
        : await getFcmToken(),
    "last_login_ip": "106.76.92.240",
    "model": await DeviceInfo.getDeviceModel(),
    "os": Platform.operatingSystem,
    "os_version": await DeviceInfo.getDeviceOSVersion()
  };

  if (lastName != null) body["lastname"] = lastName;
  if (address != null) body["line1"] = address;
  if (pinCode != null) body["postalcode"] = pinCode;
  if (city != null) body["city"] = city;
  if (country != null) body["country"] = country;
  if (gender != null) body["gender"] = gender;
  var response = await http.post(
    Uri.parse("$baseUrlPublic/${ApiEndpoint.signUp}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );
  log("${ApiEndpoint.signUp} ${jsonEncode(body)}");
  log("Header ${jsonEncode(await ApiClient.header())}");

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    log(jsonEncode(data));
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
