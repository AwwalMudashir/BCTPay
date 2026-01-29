import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    newPasswordVisiblityBloc.close();
    confirmNewPasswordVisiblityBloc.close();
    changePwdBloc.close();
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 30;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations(context).changePassword,
      ),
      body: SafeArea(
        child: BlocConsumer(
          bloc: changePwdBloc,
          listener: (context, state) {
            if (state is InitiatePasswordResetState) {
              if (state.value.isOk) {
                var msg = state.value.message ?? "";
                if (msg.trim().isEmpty || msg.toLowerCase() == 'false') {
                  msg = "Code sent";
                }
                showSuccessDialog(msg, context);
                setState(() => codeRequested = true);
                _startTimer();
              } else {
                showFailedDialog(
                  state.value.message ?? state.value.error ?? "",
                  context,
                );
              }
            }

            if (state is CompletePasswordResetState) {
              if (state.value.isOk) {
                var msg = state.value.message ?? "";
                if (msg.trim().isEmpty || msg.toLowerCase() == 'false') {
                  msg = appLocalizations(context)
                      .yourPasswordHasBeenResetSuccessfully;
                }
                showSuccessDialog(
                  msg,
                  context,
                  onOkBtnPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashboard,
                    (route) => false,
                  ),
                );
              } else {
                showFailedDialog(
                  state.value.message ?? state.value.error ?? "",
                  context,
                );
              }
            }

            if (state is ApisBlocErrorState) {
              showFailedDialog(state.message, context);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is ApisBlocLoadingState,
              progressIndicator: Loader(key: UniqueKey()),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// EMAIL
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
                        /// OTP
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

                        /// NEW PASSWORD
                        BlocBuilder(
                          bloc: newPasswordVisiblityBloc,
                          builder: (context, state) {
                            if (state is SelectBoolState) {
                              return CustomTextField(
                                controller: _newPasswordController,
                                obscureText: state.value,
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
                                      SelectBoolEvent(!state.value),
                                    );
                                  },
                                  child: Icon(
                                    state.value
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
                          },
                        ),

                        const SizedBox(height: 16),

                        /// CONFIRM PASSWORD
                        BlocBuilder(
                          bloc: confirmNewPasswordVisiblityBloc,
                          builder: (context, state) {
                            if (state is SelectBoolState) {
                              return CustomTextField(
                                controller: _confirmNewPasswordController,
                                obscureText: state.value,
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
                                      SelectBoolEvent(!state.value),
                                    );
                                  },
                                  child: Icon(
                                    state.value
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
                                  if (value !=
                                      _newPasswordController.text) {
                                    return appLocalizations(context)
                                        .passwordIsNotMatching;
                                  }
                                  return null;
                                },
                              );
                            }
                            return const Loader();
                          },
                        ),

                        const SizedBox(height: 10),

                        /// RESEND
                        !_canResend
                            ? Text(
                                "Resend code in $_secondsRemaining s",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              )
                            : TextButton(
                                onPressed: () {
                                  changePwdBloc.add(
                                    InitiatePasswordResetEvent(
                                      email:
                                          _emailController.text.trim(),
                                    ),
                                  );
                                  _startTimer();
                                },
                                child: const Text("Resend code"),
                              ),
                      ],

                      const SizedBox(height: 20),

                      /// BUTTONS
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
                                      email:
                                          _emailController.text.trim(),
                                    ),
                                  );
                                } else {
                                  changePwdBloc.add(
                                    CompletePasswordResetEvent(
                                      email:
                                          _emailController.text.trim(),
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
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
