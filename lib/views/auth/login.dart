import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ApisBloc loginBloc = ApisBloc(ApisBlocInitialState());
  bool isRemember = false;
  final passwordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final isRememberBloc = SelectionBloc(SelectBoolState(false));
  String? selectedCountryPhoneCode = selectedCountry?.phoneCode;

  Future<void> getLoginCredencials() async {
    await SharedPreferenceHelper.getisRemember().then((isTrue) async {
      if (isTrue) {
        phoneController.text = await SharedPreferenceHelper.getPhoneNumber();
        passwordController.text = await SharedPreferenceHelper.getPassword();
        bool isRemember = await SharedPreferenceHelper.getisRemember();
        isRememberBloc.add(SelectBoolEvent(isRemember));
      }
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1))
        .whenComplete(() => getLoginCredencials());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(
        centerTitle: true,
        title: "",
        titleWidget: AppBarTitleWidget(),
        actions: [LanguageWidget()],
      ),
      body: BlocConsumer(
          bloc: loginBloc,
          listener: (context, state) async {
            if (state is SendOTPState) {
              if (state.value.code == 200) {
                // Do async work first
                final loginBody = await LoginBody.from(
                  password: passwordController.text,
                  email: phoneController.text,
                  phoneCode: "+$selectedCountryPhoneCode",
                );
                if (!context.mounted) return;
                Navigator.pushNamed(context, AppRoutes.otp,
                    arguments: OTPScreen(
                        isRemember: isRemember, loginBody: loginBody));
              } else if (state.value.code == 410) {
                showEmailVerificationDialog(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }
            if (state is ResendVerificationLinkState) {
              if (state.value.code == 200) {
                if (!context.mounted) return;
                showSuccessDialog(
                    state.value.message ?? state.value.error ?? "", context);
              } else if (state.value.code == 401) {
                if (!context.mounted) return;
                sessionExpired(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                if (!context.mounted) return;
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }
            if (state is ApisBlocErrorState) {
              if (!context.mounted) return;
              showFailedDialog(state.message, context);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: state is ApisBlocLoadingState,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                appLocalizations(context).welcomeBack,
                                style: textTheme.displayMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                appLocalizations(context)
                                    .helloThereSignInToContinue,
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    labelText:
                                        "${appLocalizations(context).mobileNumber} *",
                                    hintText: appLocalizations(context)
                                        .enterMobileNumber,
                                    onChanged: seperatePhoneAndDialCode,
                                    prefixWidget:
                                        const CountryPickerTxtFieldPrefix(),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return appLocalizations(context)
                                            .pleaseEnterYourMobileNumber;
                                      }
                                      if (selectedCountryPhoneCode == "224" &&
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
                                      hintText: appLocalizations(context)
                                          .enterPassword,
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
                                        return null;
                                      },
                                    );
                                  }
                                  return const Loader();
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                isRememberBloc
                                    .add(SelectBoolEvent(!isRemember));
                              },
                              child: Row(
                                children: [
                                  BlocConsumer(
                                      bloc: isRememberBloc,
                                      listener: (context, isRememberState) {
                                        if (isRememberState
                                            is SelectBoolState) {
                                          isRemember = isRememberState.value;
                                        }
                                      },
                                      builder: (context, isRememberState) {
                                        if (isRememberState
                                            is SelectBoolState) {
                                          return Checkbox(
                                            value: isRememberState.value,
                                            onChanged: (value) {
                                              isRememberBloc
                                                  .add(SelectBoolEvent(value!));
                                            },
                                          );
                                        }
                                        return const Loader();
                                      }),
                                  Text(
                                    appLocalizations(context).rememberMe,
                                    style: textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.forgot);
                                },
                                child: Text(
                                  appLocalizations(context).recoverPassword,
                                  style: textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        BlocConsumer(
                            bloc: selectCountryBloc,
                            listener: (context, state) {
                              if (state is SelectCountryState) {
                                selectedCountryPhoneCode =
                                    state.countryData.phoneCode;
                                if (phoneController.text
                                    .contains(selectedCountryPhoneCode ?? "")) {
                                  phoneController.text = phoneController.text
                                      .replaceAll(
                                          "+$selectedCountryPhoneCode", "");
                                }
                              }
                            },
                            builder: (context, state) {
                              return CustomBtn(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (selectedCountryPhoneCode != null) {
                                        loginBloc.add(SendOTPEvent(
                                          loginBody: await LoginBody.from(
                                              password: passwordController.text,
                                              email: phoneController.text,
                                              phoneCode:
                                                  "+$selectedCountryPhoneCode"),
                                        ));
                                      } else {
                                        showToast(appLocalizations(context)
                                            .pleaseSelectCountryPhoneCode);
                                      }
                                    }
                                  },
                                  text: appLocalizations(context).requestOTP);
                            }),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.signup);
                            },
                            child: Wrap(
                              children: [
                                Text(
                                  "${appLocalizations(context).notAMember} ",
                                  style: textTheme.bodyMedium,
                                ),
                                Text(
                                  appLocalizations(context).registerNow,
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
    );
  }

  void showEmailVerificationDialog(String message, BuildContext context) {
    showFailedDialog(message, context,
        hyperlink: TextButton(
            onPressed: () {
              if (selectedCountryPhoneCode != null) {
                loginBloc.add(ResendVerificationLinkEvent(
                    phoneCode: "+$selectedCountryPhoneCode",
                    phoneNumber: phoneController.text.trim()));
                Navigator.pop(context);
              } else {
                showToast(
                    appLocalizations(context).pleaseSelectCountryPhoneCode);
              }
            },
            child: Text(
              appLocalizations(context).resendVerificationLink,
              style: const TextStyle(color: Colors.blue),
            )));
  }
}
