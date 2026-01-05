import 'package:bctpay/globals/index.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? emailOTP;

  const ResetPasswordScreen({super.key, this.emailOTP});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var forgetPasswordBloc = ApisBloc(ApisBlocInitialState());

  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;
  bool isPasswordVisible1 = true;
  final passwordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final confirmPasswordVisiblityBloc = SelectionBloc(SelectBoolState(true));

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as ResetPasswordScreen;
    var textTheme = Theme.of(context).textTheme;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(title: ""),
      body: BlocConsumer(
          bloc: forgetPasswordBloc,
          listener: (context, state) {
            if (state is ForgetResetPasswordState) {
              if (state.value.code == 200) {
                showResetSuccessDialog(isDarkMode);
              } else {
                showFailedDialog(state.value.message, context);
              }
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: state is ApisBlocLoadingState,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(22.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 50),
                          child: Image.asset(Assets.assetsImagesResetPassword),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalizations(context).resetPassword,
                                style: textTheme.displayMedium,
                              ),
                              Text(
                                appLocalizations(context)
                                    .yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
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
                                      passwordVisiblityBloc.add(SelectBoolEvent(
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
                              if (confirmPwdVisiblityState is SelectBoolState) {
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
                                              !confirmPwdVisiblityState.value));
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
                        const SizedBox(
                          height: 50,
                        ),
                        CustomBtn(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                forgetPasswordBloc.add(ForgetResetPasswordEvent(
                                    emailOTP: args.emailOTP!,
                                    newPassword: passwordController.text));
                              }
                            },
                            text: appLocalizations(context).submit),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void showResetSuccessDialog(bool isDarkMode) {
    showModalBottomSheet(
        context: context,
        backgroundColor: isDarkMode ? themeLogoColorBlue : Colors.white,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.assetsImagesResetDialog,
                    width: 121,
                    height: 121,
                  ),
                  Text("${appLocalizations(context).dialogTitleSuccess}!",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: themeYellowColor,
                      )),
                  Text(
                      appLocalizations(context)
                          .yourPasswordHasBeenResetSuccessfully,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBtn(
                    text: appLocalizations(context).ok,
                    color: themeLogoColorBlue,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.login, (route) => false);
                    },
                  ),
                ],
              ),
            ));
  }
}
