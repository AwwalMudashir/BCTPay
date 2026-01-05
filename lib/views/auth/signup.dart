import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ApisBloc signupBloc = ApisBloc(ApisBlocInitialState());

  final passwordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final confirmPasswordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  CountryData? selectedCountryPhoneCode = selectedCountry;
  var selectGenderBloc = SelectionBloc(SelectStringState(null));
  String? selectedGender;
  final tncBloc = SelectionBloc(SelectBoolState(false));
  bool isTncAccepted = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const CustomAppBar(
        centerTitle: true,
        title: "",
        titleWidget: AppBarTitleWidget(),
        actions: [LanguageWidget()],
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: BlocConsumer(
            bloc: signupBloc,
            listener: (context, state) {
              if (state is SignUpState) {
                if (state.value.code == 200) {
                  showSuccessDialog(
                    appLocalizations(context)
                        .congratulationsYourAccountHasBeenSuccessfullyCreated,
                    context,
                    redirectToLogin: true,
                    dismissOnBackKeyPress: false,
                    dismissOnTouchOutside: false,
                  );
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
                                  appLocalizations(context).signUp,
                                  style: textTheme.displayMedium,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .pleaseSignUpToContinue,
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
                                                  groupValue: state.value,
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
                                                  groupValue: state.value,
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
                            controller: fnameController,
                            labelText:
                                "${appLocalizations(context).firstName} *",
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
                            hintText:
                                appLocalizations(context).enterYourLastName,
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
                            hintText:
                                appLocalizations(context).enterEmailAddress,
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
                                      "${AppLocalizations.of(context)!.mobileNumber} *",
                                  hintText: AppLocalizations.of(context)!
                                      .enterMobileNumber,
                                  onChanged: seperatePhoneAndDialCode,
                                  prefixWidget:
                                      const CountryPickerTxtFieldPrefix(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return appLocalizations(context)
                                          .pleaseEnterYourMobileNumber;
                                    }
                                    if (selectedCountryPhoneCode?.phoneCode ==
                                            "224" &&
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
                          BlocBuilder(
                              bloc: passwordVisiblityBloc,
                              builder: (context, pwdVisiblityState) {
                                if (pwdVisiblityState is SelectBoolState) {
                                  return CustomTextField(
                                    controller: passwordController,
                                    obscureText: pwdVisiblityState.value,
                                    labelText:
                                        "${appLocalizations(context).password} *",
                                    hintText:
                                        appLocalizations(context).enterPassword,
                                    prefix: Image.asset(
                                      Assets.assetsImagesKey,
                                      scale: textFieldSuffixScale,
                                    ),
                                    suffix: InkWell(
                                      onTap: () {
                                        passwordVisiblityBloc.add(
                                            SelectBoolEvent(
                                                !pwdVisiblityState.value));
                                      },
                                      child: Icon(
                                        pwdVisiblityState.value
                                            ? Icons.remove_red_eye
                                            : Icons.remove_red_eye_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return appLocalizations(context)
                                            .pleaseEnterYourPassword;
                                      }
                                      if (!validatePassword(value)) {
                                        return appLocalizations(context)
                                            .includesALetterDigitAndSpecialCharacter;
                                      }
                                      return null;
                                    },
                                  );
                                }
                                return const Loader();
                              }),
                          BlocBuilder(
                              bloc: confirmPasswordVisiblityBloc,
                              builder: (context, confirmPwdVisiblityState) {
                                if (confirmPwdVisiblityState
                                    is SelectBoolState) {
                                  return CustomTextField(
                                    controller: confirmPasswordController,
                                    obscureText: confirmPwdVisiblityState.value,
                                    labelText:
                                        "${appLocalizations(context).confirmPassword} *",
                                    hintText: AppLocalizations.of(context)!
                                        .enterConfirmPassword,
                                    prefix: Image.asset(
                                      Assets.assetsImagesKey,
                                      scale: textFieldSuffixScale,
                                    ),
                                    suffix: InkWell(
                                      onTap: () {
                                        confirmPasswordVisiblityBloc.add(
                                            SelectBoolEvent(
                                                !confirmPwdVisiblityState
                                                    .value));
                                      },
                                      child: Icon(
                                        confirmPwdVisiblityState.value
                                            ? Icons.remove_red_eye
                                            : Icons.remove_red_eye_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return appLocalizations(context)
                                            .pleaseEnterYourConfirmPassword;
                                      }
                                      if (value != passwordController.text) {
                                        return appLocalizations(context)
                                            .passwordIsNotMatching;
                                      }
                                      if (!validatePassword(value)) {
                                        return appLocalizations(context)
                                            .includesALetterDigitAndSpecialCharacter;
                                      }
                                      return null;
                                    },
                                  );
                                }
                                return const Loader();
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  tncBloc.add(SelectBoolEvent(!isTncAccepted));
                                },
                                child: Row(
                                  children: [
                                    BlocConsumer(
                                        bloc: tncBloc,
                                        listener: (context, isRememberState) {
                                          if (isRememberState
                                              is SelectBoolState) {
                                            isTncAccepted =
                                                isRememberState.value;
                                          }
                                        },
                                        builder: (context, isRememberState) {
                                          if (isRememberState
                                              is SelectBoolState) {
                                            return Checkbox(
                                              value: isRememberState.value,
                                              onChanged: (value) {
                                                tncBloc.add(
                                                    SelectBoolEvent(value!));
                                              },
                                            );
                                          }
                                          return const Loader();
                                        }),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            AppRoutes.webview,
                                            arguments: CustomWebView(
                                              isAvailable: true,
                                              title: appLocalizations(context)
                                                  .signupTnc,
                                              url: termsAndConditionsUrl,
                                            ));
                                      },
                                      child: Text(
                                        appLocalizations(context)
                                            .pleaseAcceptTermsAndConditions,
                                        style: textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocConsumer(
                              bloc: selectCountryBloc,
                              listener: (context, state) {
                                if (state is SelectCountryState) {
                                  selectedCountryPhoneCode = state.countryData;
                                  if (phoneController.text.contains(
                                      selectedCountryPhoneCode?.phoneCode ??
                                          "")) {
                                    phoneController.text = phoneController.text
                                        .replaceAll(
                                            "+${selectedCountryPhoneCode?.phoneCode}",
                                            "");
                                  }
                                }
                              },
                              builder: (context, state) {
                                return CustomBtn(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (selectedCountryPhoneCode != null) {
                                          if (isTncAccepted) {
                                            signupBloc.add(SignUpEvent(
                                                email: emailController.text,
                                                phoneCode:
                                                    "+${selectedCountryPhoneCode?.phoneCode}",
                                                phoneNumber:
                                                    phoneController.text,
                                                password:
                                                    passwordController.text,
                                                firstName: fnameController.text,
                                                lastName: lnameController.text,
                                                country:
                                                    selectedCountryPhoneCode
                                                        ?.id,
                                                gender: selectedGender));
                                          } else {
                                            showToast(appLocalizations(context)
                                                .pleaseAcceptTermsAndConditions);
                                          }
                                        } else {
                                          showToast(appLocalizations(context)
                                              .pleaseSelectCountryPhoneCode);
                                        }
                                      }
                                    },
                                    text: appLocalizations(context).signUp);
                              }),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, AppRoutes.login, (route) => false);
                              },
                              child: Wrap(
                                children: [
                                  Text(
                                    "${appLocalizations(context).joinedUsBefore} ",
                                    style: textTheme.bodyMedium,
                                  ),
                                  Text(
                                    appLocalizations(context).loginNow,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: themeYellowColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ))
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
}
