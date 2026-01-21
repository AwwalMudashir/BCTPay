import 'dart:async';
import 'package:bctpay/globals/index.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  final newPasswordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final confirmNewPasswordVisiblityBloc = SelectionBloc(SelectBoolState(true));

  final changePwdBloc = ApisBloc(ApisBlocInitialState());
  bool codeRequested = false;
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _canResend = false;

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 30;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 1) {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).changePassword),
      body: SafeArea(
        child: BlocConsumer(
            bloc: changePwdBloc,
            listener: (context, state) {
              if (state is InitiatePasswordResetState) {
                if (state.value.isOk) {
                  showSuccessDialog(
                    state.value.message ?? "Code sent",
                    context,
                  );
                  setState(() {
                    codeRequested = true;
                  });
                  _startTimer();
                } else {
                  showFailedDialog(
                      state.value.message ?? state.value.error ?? "", context);
                }
              }
              if (state is CompletePasswordResetState) {
                if (state.value.isOk) {
                  showSuccessDialog(
                    state.value.message ?? "",
                    context,
                    onOkBtnPressed: () {
                      Navigator.pop(context);
                    },
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
                progressIndicator: Loader(key: UniqueKey()),
                inAsyncCall: state is ApisBlocLoadingState,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: "Email *",
                          hintText: "Enter your email address",
                          prefix: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email address";
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                .hasMatch(value.trim())) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        if (codeRequested) ...[
                          CustomTextField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                          labelText: "OTP *",
                          hintText: "Enter OTP",
                            prefix: const Icon(Icons.lock_clock_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "OTP is required";
                              }
                              if (value.length < 4) {
                                return "OTP must be at least 4 digits";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder(
                              bloc: newPasswordVisiblityBloc,
                              builder: (context, pwdVisiblityState) {
                                if (pwdVisiblityState is SelectBoolState) {
                                  return CustomTextField(
                                    controller: _newPasswordController,
                                    obscureText: pwdVisiblityState.value,
                                    labelText:
                                        "${appLocalizations(context).newPassword} *",
                                    hintText: appLocalizations(context)
                                        .enterNewPassword,
                                    prefix: Image.asset(
                                      Assets.assetsImagesKey,
                                      scale: textFieldSuffixScale,
                                    ),
                                    suffix: InkWell(
                                      onTap: () {
                                        newPasswordVisiblityBloc.add(
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
                                      if (value == null || value.isEmpty) {
                                        return appLocalizations(context)
                                            .pleaseEnterYourNewPassword;
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
                              bloc: confirmNewPasswordVisiblityBloc,
                              builder: (context, pwdVisiblityState) {
                                if (pwdVisiblityState is SelectBoolState) {
                                  return CustomTextField(
                                    controller: _confirmNewPasswordController,
                                    obscureText: pwdVisiblityState.value,
                                    labelText:
                                        "${appLocalizations(context).confirmNewPassword} *",
                                    hintText: appLocalizations(context)
                                        .enterConfirmNewPassword,
                                    prefix: Image.asset(
                                      Assets.assetsImagesKey,
                                      scale: textFieldSuffixScale,
                                    ),
                                    suffix: InkWell(
                                      onTap: () {
                                        confirmNewPasswordVisiblityBloc.add(
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
                                      if (value == null || value.isEmpty) {
                                        return appLocalizations(context)
                                            .pleaseEnterYourConfirmNewPassword;
                                      }
                                      if (value != _newPasswordController.text) {
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
                          const SizedBox(height: 10),
                          if (!_canResend)
                            Text(
                              "Resend code in $_secondsRemaining s",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey),
                            )
                          else
                            TextButton(
                              onPressed: () {
                                changePwdBloc.add(InitiatePasswordResetEvent(
                                    email: _emailController.text.trim()));
                              },
                              child: const Text("Resend code"),
                            ),
                        ],
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomBtn(
                                text: codeRequested
                                    ? appLocalizations(context).submit
                                    : "Send OTP",
                                onTap: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  if (!codeRequested) {
                                    changePwdBloc.add(
                                      InitiatePasswordResetEvent(
                                          email: _emailController.text.trim()),
                                    );
                                  } else {
                                    changePwdBloc.add(
                                      CompletePasswordResetEvent(
                                        email: _emailController.text.trim(),
                                        otp: _otpController.text.trim(),
                                        newPassword:
                                            _newPasswordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomBtn(
                                color: Colors.red,
                                text: appLocalizations(context).cancel,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
