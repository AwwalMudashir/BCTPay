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
                    icon: const Icon(Icons.edit_note_rounded),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.updateProfile);
                    },
                  ),
                  AccountMenu(
                    enableBorder: true,
                    title: appLocalizations(context).changePassword,
                    icon: const Icon(Icons.lock_person_outlined),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.changePassword);
                    },
                  ),
                  AccountMenu(
                    enableBorder: true,
                    title: "Change PIN",
                    icon: const Icon(Icons.key_rounded),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.changePin);
                    },
                  ),
                  AccountMenu(
                    enableBorder: true,
                    title: "Forgot PIN",
                    icon: const Icon(Icons.key_off_outlined),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.forgotPin);
                    },
                  ),
                  AccountMenu(
                    enableBorder: true,
                    title: appLocalizations(context).kycDocuments,
                    icon: Icon(Icons.account_box_outlined),
                    suffix: const MyKYCStatusView(),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.kyc);
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
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFFF4F7FB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 6))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfilePicView(
                      dimension: 70,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.userName,
                            style: textTheme(context).titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.alternate_email_rounded,
                                  size: 16, color: Colors.black54),
                              6.width,
                              Expanded(
                                child: Text(
                                  user.email,
                                  style: textTheme(context)
                                      .bodySmall
                                      ?.copyWith(color: Colors.black54),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              CountryFlag.fromCountryCode(
                                selectedCountry?.countryCode ?? "",
                                height: 16,
                                width: 25,
                              ),
                              6.width,
                              Text(
                                user.phone,
                                style: textTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Divider(color: Colors.black.withValues(alpha: 0.08)),
                const SizedBox(height: 8),
                CommonAddressView(
                  showAddressIcon: true,
                  line1: user.line1,
                  line2: user.line2,
                  city: user.city,
                  country: user.countryName,
                ),
              ],
            ),
          );
        }
        return Loader();
      },
    );
  }
}
