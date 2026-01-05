import 'package:bctpay/lib.dart';
import 'package:bctpay/views/widget/common_address_view.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var deleteCustomerAccountBloc = ApisBloc(ApisBlocInitialState());

    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations(context).accountDetail,
        actions: [],
      ),
      body: BlocConsumer(
          bloc: deleteCustomerAccountBloc,
          listener: (context, state) {
            if (state is DeleteCustomerAccountState) {
              int? code = state.value.code;
              String msg = state.value.message ?? state.value.error ?? "";
              if (code == 200) {
                showSuccessDialog(msg, context, dismissOnTouchOutside: false,
                    onOkBtnPressed: () {
                  saveLoginDataAndClearAllAndNavigateToLogin(context);
                });
              } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(msg, context);
              } else {
                showFailedDialog(msg, context);
              }
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: Loader(),
              inAsyncCall: state is ApisBlocLoadingState,
              child: ListView(
                padding: EdgeInsets.all(5),
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ProfileQRCodeBtn(
                      enableBorder: true,
                    ),
                  ),
                  ProfilePicView(
                    dimension: height * 0.18,
                  ),
                  20.height,
                  _buildUserDetails(),
                  40.height,
                  AccountMenu(
                    enableBorder: true,
                    title: appLocalizations(context).editProfile,
                    icon: Icon(Icons.edit_outlined),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.updateProfile);
                    },
                  ),
                  AccountMenu(
                    enableBorder: true,
                    title: appLocalizations(context).changePassword,
                    icon: Icon(Icons.lock_reset_outlined),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.changePassword);
                    },
                  ),
                  AccountMenu(
                    enableBorder: true,
                    title: appLocalizations(context).kycDocuments,
                    icon: Icon(Icons.account_box_outlined),
                    suffix: const MyKYCStatusView(),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
                    },
                  ),
                  AccountMenu(
                    enableBorder: true,
                    title: appLocalizations(context).banksAndWallets,
                    icon: Icon(Icons.account_balance_outlined),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.accountsList,
                          arguments: AccountsListScreen(
                            showAppbar: true,
                            titleText:
                                appLocalizations(context).banksAndWallets,
                          ));
                    },
                  ),
                  AccountMenu(
                    enableBorder: true,
                    title: appLocalizations(context).deleteAccount,
                    icon: Icon(
                      Icons.delete_outline_rounded,
                    ),
                    onTap: () {
                      showCustomDialog(
                        appLocalizations(context)
                            .doYouReallyWantToDeleteThisAccount,
                        context,
                        title: appLocalizations(context).warning,
                        dialogType: DialogType.warning,
                        onYesTap: () {
                          deleteCustomerAccountBloc
                              .add(DeleteCustomerAccountEvent());
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }

  BlocBuilder<SharedPrefBloc, Object?> _buildUserDetails() {
    getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
    kycBloc.add(GetKYCDetailEvent());
    return BlocBuilder(
      bloc: getProfileDetailFromLocalBloc,
      builder: (context, state) {
        if (state is SharedPrefGetUserDetailState) {
          var user = state.user;
          return Column(
            children: [
              Text(
                user.userName,
                style: textTheme(context).displayLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mail_outline_rounded,
                    color: themeLogoColorOrange,
                    size: 20,
                  ),
                  5.width,
                  Text(
                    user.email,
                    style: textTheme(context).bodySmall,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountryFlag.fromCountryCode(
                    selectedCountry?.countryCode ?? "",
                    height: 16,
                    width: 25,
                  ),
                  5.width,
                  Text(user.phone),
                ],
              ),
              CommonAddressView(
                showAddressIcon: true,
                line1: user.line1,
                line2: user.line2,
                city: user.city,
                country: user.countryName,
              ),
            ],
          );
        }
        return Loader();
      },
    );
  }
}
