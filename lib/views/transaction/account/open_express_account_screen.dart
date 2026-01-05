import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class OpenExpressAccountScreen extends StatefulWidget {
  const OpenExpressAccountScreen({super.key});

  @override
  State<OpenExpressAccountScreen> createState() =>
      _OpenExpressAccountScreenState();
}

class _OpenExpressAccountScreenState extends State<OpenExpressAccountScreen> {
  var phoneController = TextEditingController();
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();
  var stateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? countryPhoneCode;
  var openExpressAccountBloc = ApisBloc(ApisBlocInitialState());
  var selectPhoneCodeBloc = SelectionBloc(SelectionBlocInitialState());
  var selectCountryBloc = SelectionBloc(SelectionBlocInitialState());
  var canAddAccountBloc = SelectionBloc(SelectBoolState(false));
  var selectStateBloc = SelectionBloc(SelectBoolState(false));
  var selectCityBloc = SelectionBloc(SelectBoolState(false));
  String gender = "Male";
  var accountLimitBloc = ApisBloc(ApisBlocInitialState());
  int totalBankAccountAllowed = 0;
  int totalSameBankAccountAllowed = 0;
  int totalWalletAccountAllowed = 0;
  int totalSameWalletAccountAllowed = 0;
  bool canAddAccount = false;
  StreamSubscription<ApisBlocState>? bankAccountListStreamSubscription;
  StreamSubscription<ApisBlocState>? accountLimitStreamSubscription;
  StreamSubscription<ApisBlocState>? profileStreamSubscription;
  StreamSubscription<SelectionBlocState>? selectPhoneCodeStream;
  StateData? selectedState;

  @override
  void dispose() {
    selectPhoneCodeStream?.cancel();
    profileStreamSubscription?.cancel();
    accountLimitStreamSubscription?.cancel();
    bankAccountListStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectPhoneCodeStream = selectPhoneCodeBloc.stream.listen((state) {
      if (state is SelectCountryState) {
        countryPhoneCode = state.countryData.phoneCode;
      }
    });
    profileStreamSubscription = profileBloc.stream.listen((state) {
      if (state is GetProfileState) {
        if (state.value.code == 200) {
          if (state.value.data != null) {
            SharedPreferenceHelper.saveProfileData(state.value);
            emailController.text = state.value.data!.email ?? "";
            phoneController.text = state.value.data!.phonenumber ?? "";
            fnameController.text = state.value.data!.firstname ?? "";
            lnameController.text = state.value.data!.lastname ?? "";
            addressController.text = state.value.data!.line1 ?? "";
            cityController.text = state.value.data!.city ?? "";
            stateController.text = state.value.data!.state ?? "";
            countryController.text = state.value.data!.country ?? "";
            seperatePhoneAndDialCode(state.value.data!.phoneCode ?? '',
                    selectPhoneCountryBloc: selectPhoneCodeBloc)
                .then((country) {
              if (country != null) {
                selectPhoneCodeBloc.add(SelectCountryEvent(
                    Country.parse(country.countryCode), country));
              }
            });
            if (state.value.data?.country != null) {
              getCountryWithCountryName(state.value.data!.country);
            }
            if (state.value.data?.state != null) {
              getStateByStateName(state.value.data?.state ?? '').then((state) {
                if (state != null) {
                  selectedState = state;
                }
              });
            }
          }
        } else if (state.value.code ==
            HTTPResponseStatusCodes.sessionExpireCode) {
          if (!mounted) return;
          sessionExpired(state.value.message, context);
        }
      }
    });
    profileBloc.add(GetProfileEvent());
    accountLimitStreamSubscription = accountLimitBloc.stream.listen((state) {
      if (state is AccountLimitState) {
        if (state.value.code == 200) {
          var bankAccountLimitData = state.value.data!.accountPermissions
              .where((e) => e.accountType == "BANK");
          if (bankAccountLimitData.isNotEmpty) {
            totalBankAccountAllowed =
                bankAccountLimitData.first.totalAccountAllowed;
            totalSameBankAccountAllowed =
                bankAccountLimitData.first.totalSameAccountAllowed;
          }
          var walletAccountLimitData = state.value.data!.accountPermissions
              .where((e) => e.accountType == "WALLET");
          if (walletAccountLimitData.isNotEmpty) {
            totalWalletAccountAllowed =
                walletAccountLimitData.first.totalAccountAllowed;
            totalSameWalletAccountAllowed =
                walletAccountLimitData.first.totalSameAccountAllowed;
          }
          bankAccountListBloc.add(GetBankAccountListEvent());
        } else if (state.value.code ==
            HTTPResponseStatusCodes.sessionExpireCode) {
          if (!mounted) return;
          sessionExpired(state.value.message, context);
        }
      }
    });
    bankAccountListStreamSubscription =
        bankAccountListBloc.stream.listen((state) {
      if (state is GetBankAccountListState) {
        if (state.value.code == 200) {
          if (!mounted) return;
          canAddAccount = checkLimit(
              accountList: state.value.data
                      ?.where((account) => account.accountRole == "BANK")
                      .toList() ??
                  [],
              accountLimit: totalBankAccountAllowed,
              sameAccountLimit: totalSameBankAccountAllowed,
              bankName: "Ecobank",
              context: context);
          canAddAccountBloc.add(SelectBoolEvent(canAddAccount));
        } else if (state.value.code ==
            HTTPResponseStatusCodes.sessionExpireCode) {
          if (!mounted) return;
          sessionExpired(state.value.message, context);
        }
      }
    });
    accountLimitBloc.add(GetAccountLimitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: appLocalizations(context).openXpressAccount),
      body: BlocConsumer(
          bloc: openExpressAccountBloc,
          listener: (context, state) {
            if (state is OpenExpressAccountState) {
              if (state.value.code == 200) {
                showSuccessDialog(
                    state.value.message ?? state.value.error ?? "", context,
                    dismissOnBackKeyPress: false,
                    dismissOnTouchOutside: false, onOkBtnPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.accountsList,
                          arguments: const AccountsListScreen(
                            showAppbar: true,
                          ));
                });
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }
            if (state is ApisBlocErrorState) {
              showFailedDialog(state.message, context);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: state is ApisBlocLoadingState,
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    Column(
                      children: [
                        CustomTextField(
                          controller: fnameController,
                          labelText: "${appLocalizations(context).firstName} *",
                          hintText:
                              appLocalizations(context).enterYourFirstName,
                          prefix: Image.asset(
                            Assets.assetsImagesPerson1,
                            scale: textFieldSuffixScale,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return appLocalizations(context)
                                  .pleaseEnterYourFirstName;
                            } else if (!specialCharRegex.hasMatch(value)) {
                              return appLocalizations(context)
                                  .pleaseEnterValidValue;
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          controller: lnameController,
                          labelText: appLocalizations(context).lastName,
                          hintText: appLocalizations(context).enterYourLastName,
                          prefix: Image.asset(
                            Assets.assetsImagesPerson1,
                            scale: textFieldSuffixScale,
                          ),
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return null;
                            } else if (!specialCharRegex.hasMatch(p0)) {
                              return appLocalizations(context)
                                  .pleaseEnterValidValue;
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText:
                              "${appLocalizations(context).emailAddress} *",
                          hintText: appLocalizations(context).enterEmailAddress,
                          prefix: Image.asset(
                            Assets.assetsImagesEmail,
                            scale: textFieldSuffixScale,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return appLocalizations(context)
                                  .pleaseEnterYourEmailAddress;
                            } else if (!validateEmail(value)) {
                              return appLocalizations(context)
                                  .pleaseEnterYourValidEmailAddress;
                            }
                            return null;
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                labelText:
                                    "${appLocalizations(context).mobileNumber} *",
                                hintText: AppLocalizations.of(context)!
                                    .enterMobileNumber,
                                onChanged: (phone) async {
                                  var country = await seperatePhoneAndDialCode(
                                      phone,
                                      selectPhoneCountryBloc:
                                          selectPhoneCodeBloc);
                                  if (country != null) {
                                    selectPhoneCodeBloc.add(SelectCountryEvent(
                                        Country.parse(country.countryCode),
                                        country));
                                  }
                                },
                                prefixWidget:
                                    const CountryPickerTxtFieldPrefix(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return appLocalizations(context)
                                        .pleaseEnterYourMobileNumber;
                                  }
                                  if (countryPhoneCode == "224" &&
                                      !gnPhoneRegx.hasMatch(value)) {
                                    return appLocalizations(context)
                                        .pleaseEnterValidWalletPhoneNumber;
                                  } else if (!validatePhone(value)) {
                                    return appLocalizations(context)
                                        .pleaseEnterValidWalletPhoneNumber;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        BlocConsumer(
                            bloc: selectCountryBloc,
                            listener: (context, state) {
                              if (state is SelectCountryState) {
                                countryController.text =
                                    state.countryData.countryName;
                              }
                            },
                            builder: (context, selectCountryBlocState) {
                              return CustomTextField(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      backgroundColor: isDarkMode(context)
                                          ? themeLogoColorBlue
                                          : Colors.white,
                                      builder: (context) => CountryPickerView(
                                            bloc: selectCountryBloc,
                                          ));
                                },
                                readOnly: true,
                                controller: countryController,
                                labelText:
                                    "${appLocalizations(context).country} *",
                                hintText:
                                    appLocalizations(context).enterCountry,
                                prefix: Image.asset(
                                  Assets.assetsImagesCountry1,
                                  scale: textFieldSuffixScale,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return appLocalizations(context)
                                        .pleaseEnterYourCountry;
                                  } else if (!specialCharRegex
                                      .hasMatch(value)) {
                                    return appLocalizations(context)
                                        .pleaseEnterValidValue;
                                  }
                                  return null;
                                },
                              );
                            }),
                        BlocConsumer(
                            bloc: selectStateBloc,
                            listener: (context, state) {
                              if (state is SelectStateState) {
                                selectedState = state.state;
                                stateController.text =
                                    selectedState?.state ?? "";

                                ///setting initial city while selecting state
                                if (selectedState?.cities?.isNotEmpty ??
                                    false) {
                                  selectCityBloc.add(SelectStringEvent(
                                      selectedState?.cities?.first));
                                }
                              }
                            },
                            builder: (context, state) {
                              return CustomTextField(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: isDarkMode(context)
                                        ? themeLogoColorBlue
                                        : Colors.white,
                                    builder: (context) => StatePickerView(
                                      bloc: selectStateBloc,
                                    ),
                                  );
                                },
                                readOnly: true,
                                controller: stateController,
                                labelText:
                                    "${appLocalizations(context).state} *",
                                hintText: appLocalizations(context).selectState,
                                prefix: Image.asset(
                                  Assets.assetsImagesCountry1,
                                  scale: textFieldSuffixScale,
                                ),
                                onChanged: (p0) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return appLocalizations(context)
                                        .pleaseSelectYourState;
                                  } else if (!specialCharRegex
                                      .hasMatch(value)) {
                                    return appLocalizations(context)
                                        .pleaseEnterValidValue;
                                  }
                                  return null;
                                },
                              );
                            }),
                        Row(
                          children: [
                            Expanded(
                              child: BlocConsumer(
                                  bloc: selectCityBloc,
                                  listener: (context, state) {
                                    if (state is SelectStringState) {
                                      cityController.text = state.value ?? "";
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomTextField(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor: isDarkMode(context)
                                              ? themeLogoColorBlue
                                              : Colors.white,
                                          context: context,
                                          builder: (context) => CityPickerView(
                                            bloc: selectCityBloc,
                                            selectedState: selectedState,
                                          ),
                                        );
                                      },
                                      readOnly: true,
                                      controller: cityController,
                                      labelText:
                                          "${appLocalizations(context).city} *",
                                      hintText:
                                          appLocalizations(context).enterCity,
                                      prefix: Image.asset(
                                        Assets.assetsImagesCity1,
                                        scale: textFieldSuffixScale,
                                      ),
                                      validator: (p0) {
                                        if (p0!.isEmpty) {
                                          return appLocalizations(context)
                                              .pleaseEnterYourCity;
                                        } else if (!specialCharRegex
                                            .hasMatch(p0)) {
                                          return appLocalizations(context)
                                              .pleaseEnterValidValue;
                                        }
                                        return null;
                                      },
                                    );
                                  }),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        CustomTextField(
                          controller: addressController,
                          labelText: appLocalizations(context).address,
                          hintText: appLocalizations(context).enterAddress,
                          prefix: Image.asset(
                            Assets.assetsImagesLocation1,
                            scale: textFieldSuffixScale,
                          ),
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return null;
                            } else if (!specialCharRegex.hasMatch(p0)) {
                              return appLocalizations(context)
                                  .pleaseEnterValidValue;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: BlocBuilder(
                                bloc: canAddAccountBloc,
                                builder: (context, canAddAccountState) {
                                  return CustomBtn(
                                    text: appLocalizations(context).submit,
                                    onTap: (canAddAccountState
                                                as SelectBoolState)
                                            .value
                                        ? () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (countryPhoneCode != null) {
                                                openExpressAccountBloc.add(
                                                    OpenExpressAccountEvent(
                                                  body: OpenExpressAccountBody(
                                                      firstName:
                                                          fnameController.text,
                                                      lastname:
                                                          lnameController.text,
                                                      mobileNo:
                                                          "+$countryPhoneCode${phoneController.text}",
                                                      gender: gender,
                                                      country: countryController
                                                          .text,
                                                      countryOfResidence:
                                                          countryController
                                                              .text,
                                                      email:
                                                          emailController.text,
                                                      city: cityController.text,
                                                      state:
                                                          stateController.text,
                                                      street: addressController
                                                          .text),
                                                ));
                                              } else {
                                                showToast(appLocalizations(
                                                        context)
                                                    .pleaseSelectCountryPhoneCode);
                                              }
                                            }
                                          }
                                        : null,
                                  );
                                })),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomBtn(
                            color: Colors.red,
                            text: appLocalizations(context).cancel,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
