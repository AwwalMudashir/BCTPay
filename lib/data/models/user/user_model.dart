class UserModel {
  final String id;
  final String customerId;
  final String userName;
  final String email;
  final String phone;
  final String profilePic;
  final String phoneCode;
  final String qrString;
  final String countryName;
  final String? city;
  final String? state;
  final String? pinCode;
  final String? address;
  final String? adminLogoForDarkTheme;
  final String? adminLogoForWhiteTheme;
  final String? line1;
  final String? line2;

  UserModel({
    required this.id,
    required this.customerId,
    required this.userName,
    required this.email,
    required this.phone,
    required this.profilePic,
    required this.phoneCode,
    required this.qrString,
    required this.countryName,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.address,
    required this.adminLogoForDarkTheme,
    required this.adminLogoForWhiteTheme,
    required this.line1,
    required this.line2,
  });
}
