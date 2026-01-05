import 'dart:convert';

class OpenExpressAccountBody {
  final String firstName;
  final String lastname;
  final String mobileNo;
  final String gender;
  final String country;
  final String countryOfResidence;
  final String email;
  final String city;
  final String state;
  final String street;

  OpenExpressAccountBody(
      {required this.firstName,
      required this.lastname,
      required this.mobileNo,
      required this.gender,
      required this.country,
      required this.countryOfResidence,
      required this.email,
      required this.city,
      required this.state,
      required this.street});

  Map<String, dynamic> toMap() => {
        'firstName': firstName,
        'lastname': lastname,
        'mobileNo': mobileNo,
        'gender': gender,
        'country': country,
        'countryOfResidence': countryOfResidence,
        'email': email,
        'city': city,
        'state': state,
        'street': street,
        'institution_code': firstName,
        'institution_name': "Ecobank",
      };

  factory OpenExpressAccountBody.fromMap(Map<String, dynamic> map) =>
      OpenExpressAccountBody(
        firstName: map['firstName'] ?? '',
        lastname: map['lastname'] ?? '',
        mobileNo: map['mobileNo'] ?? '',
        gender: map['gender'] ?? '',
        country: map['country'] ?? '',
        countryOfResidence: map['countryOfResidence'] ?? '',
        email: map['email'] ?? '',
        city: map['city'] ?? '',
        state: map['state'] ?? '',
        street: map['street'] ?? '',
      );

  String toJson() => json.encode(toMap());

  factory OpenExpressAccountBody.fromJson(String source) =>
      OpenExpressAccountBody.fromMap(json.decode(source));
}
