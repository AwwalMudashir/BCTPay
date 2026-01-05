import 'package:bctpay/globals/index.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var emailController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var pincodeController = TextEditingController();
  var addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isPasswordNotVisible = true;
  var isPasswordNotVisible1 = true;

  var selectPhoneCodeBloc = SelectionBloc(SelectionBlocInitialState());

  String? selectedPhoneCode;
  var isProfileNotChangedBloc = SelectionBloc(SelectBoolState(true));
  Customer? profileResponseData;
  var selectGenderBloc = SelectionBloc(SelectionBlocInitialState());
  String? selectedGender;

  var selectStateBloc = SelectionBloc(SelectionBlocInitialState());
  var selectCityBloc = SelectionBloc(SelectionBlocInitialState());
  StateData? selectedState;

  KYCStatus? kycStatus;

  bool isReadOnly = false;

  @override
  void initState() {
    profileBloc.add(GetProfileEvent());
    kycBloc.add(GetKYCDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(title: ""),
      body: BlocListener(
        bloc: kycBloc,
        listener: (context, state) {
          if (state is GetKYCDetailState) {
            if (state.value.code == 200) {
              kycStatus = state.value.data?.kycStatus;
              isReadOnly = kycStatus == KYCStatus.approved;
            }
          }
        },
        child: BlocConsumer(
            bloc: profileBloc,
            listener: (context, state) {
              if (state is GetProfileState) {
                profileResponseData = state.value.data;
                if (state.value.code == 200) {
                  if (profileResponseData != null) {
                    SharedPreferenceHelper.saveProfileData(state.value);
                    emailController.text = profileResponseData!.email ?? "";
                    phoneController.text =
                        profileResponseData!.phonenumber ?? "";
                    fnameController.text = profileResponseData!.firstname ?? "";
                    lnameController.text = profileResponseData!.lastname ?? "";
                    addressController.text = profileResponseData!.line1 ?? "";
                    cityController.text = profileResponseData!.city ?? "";
                    countryController.text = profileResponseData!.country ?? "";
                    stateController.text = profileResponseData!.state ?? "";
                    pincodeController.text =
                        profileResponseData!.postalcode ?? "";
                    selectedGender = profileResponseData!.gender;
                    selectGenderBloc.add(SelectStringEvent(selectedGender));
                    selectedPhoneCode = profileResponseData!.phoneCode;
                    seperatePhoneAndDialCode(
                            profileResponseData!.phoneCode ?? "",
                            selectPhoneCountryBloc: selectPhoneCodeBloc)
                        .then((country) {
                      if (country != null) {
                        selectPhoneCodeBloc.add(SelectCountryEvent(
                            Country.parse(country.countryCode), country));
                      }
                    });
                    if (profileResponseData?.country != null) {
                      getCountryWithCountryName(profileResponseData!.country);
                    }
                    if (profileResponseData?.state != null) {
                      getStateByStateName(profileResponseData?.state ?? '')
                          .then((state) {
                        if (state != null) {
                          selectedState = state;
                        }
                      });
                    }
                  }
                  checkIsProfileNotChanged();
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                }
              }
              if (state is UpdateProfileState) {
                if (state.value.code == 200) {
                  showSuccessDialog(
                      state.value.message ?? state.value.error ?? "", context,
                      dismissOnBackKeyPress: false,
                      dismissOnTouchOutside: false, onOkBtnPressed: () {
                    profileBloc.add(GetProfileEvent());
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(
                      state.value.message ?? state.value.error ?? "", context);
                } else {
                  showFailedDialog(
                      state.value.message ?? state.value.error ?? "", context);
                }
                profileBloc.add(GetProfileEvent());
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is ApisBlocLoadingState,
                progressIndicator: const Loader(),
                child: SingleChildScrollView(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  appLocalizations(context).updateProfile,
                                  style: textTheme.displayMedium,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  appLocalizations(context)
                                      .yoCanUpdateYourProfileFromHere,
                                  style: textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(appLocalizations(context).gender),
                              Expanded(
                                child: BlocConsumer(
                                    bloc: selectGenderBloc,
                                    listener: (context, state) {
                                      if (state is SelectStringState) {}
                                      checkIsProfileNotChanged();
                                    },
                                    builder: (context, state) {
                                      if (state is SelectStringState) {
                                        return Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor:
                                                  Colors.white),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: RadioListTile(
                                                  groupValue: state.value,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  fillColor:
                                                      WidgetStatePropertyAll(
                                                    isDarkMode(context)
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  title: Text(
                                                    appLocalizations(context)
                                                        .male,
                                                    style: textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  value: "MALE",
                                                  onChanged: (value) {
                                                    selectedGender = value!;
                                                    selectGenderBloc.add(
                                                        SelectStringEvent(
                                                            selectedGender));
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: RadioListTile(
                                                  groupValue: state.value,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  fillColor:
                                                      WidgetStatePropertyAll(
                                                    isDarkMode(context)
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  title: Text(
                                                    appLocalizations(context)
                                                        .female,
                                                    style: textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  value: "FEMALE",
                                                  onChanged: (value) {
                                                    selectedGender = value!;
                                                    selectGenderBloc.add(
                                                        SelectStringEvent(
                                                            selectedGender));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return const Loader();
                                    }),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            readOnly: isReadOnly,
                            controller: fnameController,
                            labelText:
                                "${appLocalizations(context).firstName} *",
                            hintText:
                                appLocalizations(context).enterYourFirstName,
                            prefix: Image.asset(
                              Assets.assetsImagesPerson1,
                              scale: textFieldSuffixScale,
                            ),
                            onChanged: (p0) {
                              checkIsProfileNotChanged();
                            },
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
                            readOnly: isReadOnly,
                            controller: lnameController,
                            labelText: appLocalizations(context).lastName,
                            hintText:
                                appLocalizations(context).enterYourLastName,
                            prefix: Image.asset(
                              Assets.assetsImagesPerson1,
                              scale: textFieldSuffixScale,
                            ),
                            onChanged: (p0) {
                              checkIsProfileNotChanged();
                            },
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
                            readOnly: isReadOnly,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText:
                                "${appLocalizations(context).emailAddress} *",
                            hintText:
                                appLocalizations(context).enterEmailAddress,
                            prefix: Image.asset(
                              Assets.assetsImagesEmail,
                              scale: textFieldSuffixScale,
                            ),
                            onChanged: (p0) {
                              checkIsProfileNotChanged();
                            },
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
                                  readOnly: isReadOnly,
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                                  labelText:
                                      "${appLocalizations(context).mobileNumber} *",
                                  hintText: AppLocalizations.of(context)!
                                      .enterMobileNumber,
                                  onChanged: (phone) async {
                                    var country =
                                        await seperatePhoneAndDialCode(phone,
                                            selectPhoneCountryBloc:
                                                selectPhoneCodeBloc);
                                    if (country != null) {
                                      selectPhoneCodeBloc.add(
                                          SelectCountryEvent(
                                              Country.parse(
                                                  country.countryCode),
                                              country));
                                    }
                                    checkIsProfileNotChanged();
                                  },
                                  prefixWidget: CountryPickerTxtFieldPrefix(
                                    selectPhoneCountryBloc: selectPhoneCodeBloc,
                                    readOnly: true,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return appLocalizations(context)
                                          .pleaseEnterYourMobileNumber;
                                    }
                                    if (selectedPhoneCode == "+224" &&
                                        !gnPhoneRegx.hasMatch(value)) {
                                      return appLocalizations(context)
                                          .pleaseEnterValidMobileNumber;
                                    } else if (!validatePhone(value)) {
                                      return appLocalizations(context)
                                          .pleaseEnterValidMobileNumber;
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
                                return Column(
                                  children: [
                                    CustomTextField(
                                      onTap: () {},
                                      readOnly: isReadOnly,
                                      controller: countryController,
                                      labelText:
                                          "${appLocalizations(context).country} *",
                                      hintText: appLocalizations(context)
                                          .enterCountry,
                                      prefix: Image.asset(
                                        Assets.assetsImagesCountry1,
                                        scale: textFieldSuffixScale,
                                      ),
                                      onChanged: (p0) {
                                        checkIsProfileNotChanged();
                                      },
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
                                    ),
                                  ],
                                );
                              }),
                          Row(
                            children: [
                              Expanded(
                                child: BlocConsumer(
                                    bloc: selectPhoneCodeBloc,
                                    listener: (context, state) {
                                      if (state is SelectCountryState) {
                                        selectedPhoneCode =
                                            "+${state.countryData.phoneCode}";
                                        if (phoneController.text.contains(
                                            selectedPhoneCode ?? "")) {
                                          phoneController.text =
                                              phoneController.text.replaceAll(
                                                  selectedPhoneCode ?? "", "");
                                        }
                                        checkIsProfileNotChanged();
                                      }
                                    },
                                    builder: (context, state) {
                                      return BlocBuilder(
                                          bloc: isProfileNotChangedBloc,
                                          builder: (context,
                                              isProfileNotChangedState) {
                                            if (isProfileNotChangedState
                                                is SelectBoolState) {
                                              return CustomBtn(
                                                  onTap:
                                                      isProfileNotChangedState
                                                              .value
                                                          ? null
                                                          : () {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                if (selectedPhoneCode !=
                                                                    null) {
                                                                  profileBloc.add(UpdateProfileEvent(
                                                                      email: emailController
                                                                          .text,
                                                                      phoneCode:
                                                                          selectedPhoneCode!,
                                                                      phoneNumber:
                                                                          phoneController
                                                                              .text,
                                                                      password:
                                                                          passwordController
                                                                              .text,
                                                                      firstName:
                                                                          fnameController
                                                                              .text,
                                                                      lastName:
                                                                          lnameController
                                                                              .text,
                                                                      address: addressController
                                                                          .text,
                                                                      city: cityController
                                                                          .text,
                                                                      country: countryController
                                                                          .text,
                                                                      state: stateController
                                                                          .text,
                                                                      pinCode:
                                                                          pincodeController
                                                                              .text,
                                                                      gender:
                                                                          selectedGender));
                                                                } else {
                                                                  showToast(appLocalizations(
                                                                          context)
                                                                      .pleaseSelectCountryPhoneCode);
                                                                }
                                                              }
                                                            },
                                                  text:
                                                      appLocalizations(context)
                                                          .submit);
                                            }
                                            return const Loader();
                                          });
                                    }),
                              ),
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
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void checkIsProfileNotChanged() {
    bool isNotChanged =
        fnameController.text == profileResponseData?.firstname &&
            lnameController.text == (profileResponseData?.lastname ?? "") &&
            emailController.text == profileResponseData?.email &&
            selectedPhoneCode == profileResponseData?.phoneCode &&
            phoneController.text == profileResponseData?.phonenumber &&
            countryController.text == profileResponseData?.country &&
            stateController.text == profileResponseData?.state &&
            cityController.text == (profileResponseData?.city ?? "") &&
            pincodeController.text == (profileResponseData?.postalcode ?? "") &&
            addressController.text == (profileResponseData?.line1 ?? "") &&
            selectedGender == profileResponseData?.gender;
    isProfileNotChangedBloc.add(SelectBoolEvent(isNotChanged));
  }
}
