import 'dart:async';

import 'package:bctpay/globals/index.dart';

class ForgotPinScreen extends StatefulWidget {
  const ForgotPinScreen({super.key});

  @override
  State<ForgotPinScreen> createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends State<ForgotPinScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final pinBloc = ApisBloc(ApisBlocInitialState());

  bool codeRequested = false;
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _canResend = false;

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    _otpController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
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
      appBar: CustomAppBar(title: "Forgot PIN"),
      body: SafeArea(
        child: BlocConsumer(
            bloc: pinBloc,
            listener: (context, state) {
              if (state is InitiateForgotPinState) {
                if (state.value.isOk) {
                  showSuccessDialog(
                      state.value.message ?? "OTP sent", context);
                  setState(() {
                    codeRequested = true;
                  });
                  _startTimer();
                } else {
                  showFailedDialog(
                      state.value.message ?? state.value.error ?? "", context);
                }
              }
              if (state is ValidatePinResetOtpState) {
                if (state.value.isOk) {
                  // proceed to set pin
                  pinBloc.add(SetPinEvent(
                      username: _emailController.text.trim(),
                      newPin: _newPinController.text.trim()));
                } else {
                  showFailedDialog(
                      state.value.message ?? state.value.error ?? "", context);
                }
              }
              if (state is SetPinState) {
                if (state.value.isOk) {
                  showSuccessDialog(
                      state.value.message ?? "PIN updated", context,
                      onOkBtnPressed: () => Navigator.pop(context));
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: "Email / Username *",
                          hintText: "Enter your email",
                          prefix: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
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
                          _pinField(
                              controller: _newPinController,
                              label: "New PIN",
                              hint: "Enter new 4-digit PIN"),
                          const SizedBox(height: 16),
                          _pinField(
                              controller: _confirmPinController,
                              label: "Confirm New PIN",
                              hint: "Re-enter new 4-digit PIN",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Confirm your new PIN";
                                }
                                if (value.length != 4) {
                                  return "PIN must be 4 digits";
                                }
                                if (value != _newPinController.text) {
                                  return "PINs do not match";
                                }
                                return null;
                              }),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _canResend
                                  ? "You can resend the OTP."
                                  : "Resend available in $_secondsRemaining s",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        Row(
                          children: [
                            Expanded(
                              child: CustomBtn(
                                text: codeRequested
                                    ? appLocalizations(context).submit
                                    : "Send OTP",
                                onTap: () {
                                  if (!_formKey.currentState!.validate()) return;
                                  if (!codeRequested) {
                                    pinBloc.add(InitiateForgotPinEvent(
                                        username: _emailController.text.trim()));
                                  } else {
                                    if (_newPinController.text.length != 4 ||
                                        _confirmPinController.text.length != 4) {
                                      showToast("PIN must be 4 digits");
                                      return;
                                    }
                                    pinBloc.add(ValidatePinResetOtpEvent(
                                        username: _emailController.text.trim(),
                                        otp: _otpController.text.trim()));
                                  }
                                },
                              ),
                            ),
                            if (codeRequested) ...[
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomBtn(
                                  color: Colors.grey.shade400,
                                  text: "Resend OTP",
                                  onTap: _canResend
                                      ? () {
                                          pinBloc.add(InitiateForgotPinEvent(
                                              username:
                                                  _emailController.text.trim()));
                                        }
                                      : null,
                                ),
                              ),
                            ]
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _pinField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
  }) {
    return CustomTextField(
      controller: controller,
      keyboardType: TextInputType.number,
      labelText: label,
      hintText: hint,
      maxLength: 4,
      obscureText: true,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Required";
            }
            if (value.length != 4) {
              return "PIN must be 4 digits";
            }
            return null;
          },
    );
  }
}
