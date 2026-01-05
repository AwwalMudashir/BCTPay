import 'package:bctpay/globals/index.dart';

void selectProfileCountry(BuildContext context) {
  if (selectedCountry == null) {
    SharedPreferenceHelper.getCountry().then((countryName) {
      if (countryName != null) {
        getCountryWithCountryName(countryName);
      } else {
        profileBloc.stream.listen((state) {
          if (state is GetProfileState) {
            if (state.value.code == 200) {
              SharedPreferenceHelper.saveProfileData(state.value);
              if (state.value.data?.country != null) {
                getCountryWithCountryName(state.value.data!.country ?? "");
              }
            } else if (state.value.code ==
                HTTPResponseStatusCodes.sessionExpireCode) {
              if (!context.mounted) return;
              sessionExpired(state.value.message, context);
            } else {
              showToast(state.value.message);
            }
          }
        });
        profileBloc.add(GetProfileEvent());
      }
    });
  } else {
  }
}
