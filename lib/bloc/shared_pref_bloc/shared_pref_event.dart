import 'package:bctpay/globals/index.dart';

@immutable
abstract class SharedPrefEvent {
  Stream<SharedPrefState> applyAsync(
      {SharedPrefState currentState, SharedPrefBloc bloc});
}

class UnSharedPrefEvent extends SharedPrefEvent {
  @override
  Stream<SharedPrefState> applyAsync(
      {SharedPrefState? currentState, SharedPrefBloc? bloc}) async* {
    yield const SharedPrefInitialState();
  }
}

class SharedPrefGetUserDetailEvent extends SharedPrefEvent {
  @override
  Stream<SharedPrefState> applyAsync(
      {SharedPrefState? currentState, SharedPrefBloc? bloc}) async* {
    try {
      var id = await SharedPreferenceHelper.getUserId();
      var customerId = await SharedPreferenceHelper.getCustomerId();
      var userName = await SharedPreferenceHelper.getUserName();
      var email = await SharedPreferenceHelper.getEmail();
      var phone = await SharedPreferenceHelper.getPhoneNumber();
      var profilePic = await SharedPreferenceHelper.getProfilePic();
      var phoneCode = await SharedPreferenceHelper.getPhoneCode();
      var qrString = await SharedPreferenceHelper.getQRString();
      var countryName = await SharedPreferenceHelper.getCountry();
      var city = await SharedPreferenceHelper.getCity();
      var state = await SharedPreferenceHelper.getState();
      var pinCode = await SharedPreferenceHelper.getPincode();
      var address = await SharedPreferenceHelper.getAddress();
      var adminLogoForDarkTheme =
          await SharedPreferenceHelper.getAdminLogoForDarkTheme();
      var adminLogoForWhiteTheme =
          await SharedPreferenceHelper.getAdminLogoForWhiteTheme();
      var line1 = await SharedPreferenceHelper.getLine1();
      var line2 = await SharedPreferenceHelper.getLine2();

      yield SharedPrefGetUserDetailState(UserModel(
        id: id,
        customerId: customerId,
        userName: userName,
        email: email,
        phone: phone,
        profilePic: profilePic,
        phoneCode: phoneCode,
        qrString: qrString,
        countryName: countryName ?? selectedCountry?.countryName ?? "Guinea",
        city: city,
        state: state,
        pinCode: pinCode,
        address: address,
        line1: line1,
        line2: line2,
        adminLogoForDarkTheme: adminLogoForDarkTheme,
        adminLogoForWhiteTheme: adminLogoForWhiteTheme,
      ));
    } catch (e) {
      debugPrint(e.toString());
      yield ErrorSharedPrefState(e.toString());
    }
  }
}
