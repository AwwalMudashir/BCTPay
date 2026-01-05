import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<Response> updateProfile({
  String? email,
  required String phoneCode,
  String? phoneNumber,
  String? password,
  String? firstName,
  String? lastName,
  String? address,
  String? pinCode,
  String? city,
  String? country,
  String? state,
  String? gender,
}) async {
  var body = {};
  if (email != null && email != "") body["email"] = email;
  if (phoneNumber != null && phoneNumber != "") {
    body["phone_code"] = phoneCode;
    body["phonenumber"] = phoneNumber;
  }
  if (password != null && password != "") body["password"] = password;
  if (firstName != null && firstName != "") body["firstname"] = firstName;
  if (lastName != null && lastName != "") body["lastname"] = lastName;
  if (address != null && address != "") body["line1"] = address;
  if (pinCode != null && pinCode != "") body["postalcode"] = pinCode;
  if (city != null && city != "") body["city"] = city;
  if (country != null && country != "") body["country"] = country;
  if (state != null && state != "") body["state"] = state;
  if (gender != null && gender != "") body["gender"] = gender;
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.updateProfile}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return Response.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
