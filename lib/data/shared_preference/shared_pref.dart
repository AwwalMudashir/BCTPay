import 'package:bctpay/globals/index.dart';

class SharedPreferenceHelper {
  static const String _idKey = "id";
  static const String _isLoginKey = "isLogin";
  static const String _accessTokenKey = "accessToken";
  static const String _kongServerTokenKey = "kongServerToken";
  static const String _phoneKey = "phone";
  static const String _passwordKey = "password";
  static const String _isRememberKey = "isRemember";
  static const String _customerIdKey = "customerId";
  static const String _emailKey = "email";
  static const String _usernameKey = "username";
  static const String _profilePicKey = "profilePic";
  static const String _isTourNavigationShowedKey = "isTourNavigationShowed";
  static const String _languageCodeKey = "languageCode";
  static const String _isIntroShowedKey = "isIntroShowed";
  static const String _qrStringKey = "qrString";
  static const String _phoneCodeKey = "phoneCode";
  static const String _countryKey = "country";
  static const String _cityKey = "city";
  static const String _stateKey = "state";
  static const String _pinCodeKey = "pinCode";
  static const String _addressKey = "address";
  static const String _adminLogoForDarkThemeKey = "adminLogoForDarkThemeKey";
  static const String _adminLogoForWhiteThemeKey = "adminLogoForWhiteThemeKey";
  static const String _line1 = "line1";
  static const String _line2 = "line2";
  static const String _genderKey = "gender";

  static Future saveLoginData(LoginResponse loginResponse) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool(_isLoginKey, true);
    await pref.setString(_accessTokenKey, loginResponse.data!.token);
    await pref.setString(
        _kongServerTokenKey, loginResponse.data?.kongServerToken ?? "");
    // Persist basic identity details from login payload (fallback to tokens-only if absent)
    if (loginResponse.data?.email != null) {
      await pref.setString(_emailKey, loginResponse.data!.email ?? "");
    }
    if (loginResponse.data?.mobileNo != null) {
      await pref.setString(_phoneKey, loginResponse.data!.mobileNo ?? "");
    }
    if (loginResponse.data?.customerId != null) {
      await pref.setString(_customerIdKey, loginResponse.data!.customerId ?? "");
    }
    if (loginResponse.data?.country != null) {
      await pref.setString(_countryKey, loginResponse.data!.country ?? "");
    }
    if (loginResponse.data?.gender != null) {
      await pref.setString(_genderKey, loginResponse.data!.gender ?? "");
    }
    final userName =
        loginResponse.data?.fullname ?? loginResponse.data?.username ?? "";
    if (userName.isNotEmpty) {
      await pref.setString(_usernameKey, userName);
    }
  }

  static Future saveLoginCredentials(
      {required String mobile,
      required String password,
      required bool isRemember}) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString(_phoneKey, mobile);
    await pref.setString(_passwordKey, password);
    await pref.setBool(_isRememberKey, isRemember);
  }

  static Future<bool> getisRemember() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(_isRememberKey) ?? false;
  }

  static Future<String> getPassword() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_passwordKey) ?? "";
  }

  static Future saveProfileData(ProfileResponse profileResponse) async {
    if (profileResponse.data != null) {
      var pref = await SharedPreferences.getInstance();
      await pref.setBool(_isLoginKey, true);
      await pref.setString(_accessTokenKey, profileResponse.data!.token ?? "");
      await pref.setString(_idKey, profileResponse.data!.id ?? "");
      await pref.setString(
          _customerIdKey, profileResponse.data!.customerId ?? "");
      await pref.setString(_emailKey, profileResponse.data!.email ?? "");
      await pref.setString(_phoneKey, profileResponse.data!.phonenumber ?? "");
      await pref.setString(_usernameKey,
          "${profileResponse.data!.firstname} ${profileResponse.data!.lastname ?? ""}");
      await pref.setString(
          _profilePicKey, profileResponse.data!.profilePic ?? "");
      await pref.setString(
          _qrStringKey, profileResponse.data!.profileLink ?? "");
      await pref.setString(
          _phoneCodeKey, profileResponse.data!.phoneCode ?? "");
      await pref.setString(_countryKey, profileResponse.data!.country ?? "");
      await pref.setString(_cityKey, profileResponse.data!.city ?? "");
      await pref.setString(_stateKey, profileResponse.data!.state ?? "");
      await pref.setString(_pinCodeKey, profileResponse.data!.postalcode ?? "");
      await pref.setString(_addressKey, profileResponse.data!.line1 ?? "");
      await pref.setString(_adminLogoForDarkThemeKey,
          profileResponse.data!.adminLogoForDarkTheme ?? "");
      await pref.setString(_adminLogoForWhiteThemeKey,
          profileResponse.data!.adminLogoForWhiteTheme ?? "");
      await pref.setString(_line1, profileResponse.data!.line1 ?? "");
      await pref.setString(_line2, profileResponse.data!.line2 ?? "");
      if (profileResponse.data!.gender != null) {
        await pref.setString(_genderKey, profileResponse.data!.gender ?? "");
      }
    }
  }

  static Future<bool> setIsLogin(bool isLogin) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setBool(_isLoginKey, isLogin);
  }

  static Future<bool> getIsLogin() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(_isLoginKey) ?? false;
  }

  static Future<bool> setIsTourNavigationShowed(
      bool isTourNavigationShowed) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setBool(_isTourNavigationShowedKey, isTourNavigationShowed);
  }

  static Future<bool> getIsTourNavigationShowed() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(_isTourNavigationShowedKey) ?? false;
  }

  static Future<bool> setIsIntroShowed(bool isIntroShowed) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setBool(_isIntroShowedKey, isIntroShowed);
  }

  static Future<bool> getIsIntroShowed() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(_isIntroShowedKey) ?? false;
  }

  static Future<String> getAccessToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_accessTokenKey) ?? "";
  }

  static Future<String> getKongServerToken() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_kongServerTokenKey) ?? "";
  }

  static Future<String> getUserId() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_idKey) ?? "";
  }

  static Future<String> getCustomerId() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_customerIdKey) ?? "";
  }

  static Future<String> getEmail() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_emailKey) ?? "";
  }

  static Future<String> getPhoneNumber() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_phoneKey) ?? "";
  }

  static Future<String> getUserName() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_usernameKey) ?? "";
  }

  static Future<String> getProfilePic() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_profilePicKey) ?? "";
  }

  static Future<String> getQRString() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_qrStringKey) ?? "";
  }

  static Future<String> getPhoneCode() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_phoneCodeKey) ?? "";
  }

  static void clearAll() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  static Future<bool> setLanguage(String languageCode) async {
    var pref = await SharedPreferences.getInstance();
    return pref.setString(_languageCodeKey, languageCode);
  }

  static Future<String?> getLanguage() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_languageCodeKey);
  }

  static Future<String?> getCountry() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_countryKey);
  }

  static Future<String?> getCity() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_cityKey);
  }

  static Future<String?> getState() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_stateKey);
  }

  static Future<String?> getPincode() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_pinCodeKey);
  }

  static Future<String?> getAddress() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_addressKey);
  }

  static Future<String?> getAdminLogoForDarkTheme() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_adminLogoForDarkThemeKey);
  }

  static Future<String?> getAdminLogoForWhiteTheme() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_adminLogoForWhiteThemeKey);
  }

  static Future<String?> getLine1() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_line1);
  }

  static Future<String?> getLine2() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_line2);
  }

  static Future<String?> getGender() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(_genderKey);
  }
}
