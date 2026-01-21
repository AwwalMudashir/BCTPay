import 'package:bctpay/globals/index.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  final pinBloc = ApisBloc(ApisBlocInitialState());

  @override
  void dispose() {
    _currentPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change PIN"),
      body: SafeArea(
        child: BlocConsumer(
            bloc: pinBloc,
            listener: (context, state) {
              if (state is ChangeTransactionPinState) {
                if (state.value.isOk) {
                  showSuccessDialog(state.value.message ?? "PIN updated", context,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: themeLogoColorOrange.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: themeLogoColorOrange.withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.lock_outline,
                                      color: themeLogoColorOrange),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Secure your account",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: themeLogoColorOrange),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Keep your transaction PIN confidential. Avoid easy patterns like 1234 or repeating digits.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _pinField(
                          controller: _currentPinController,
                          label: "Current PIN",
                          hint: "Enter current 4-digit PIN",
                        ),
                        const SizedBox(height: 16),
                        _pinField(
                          controller: _newPinController,
                          label: "New PIN",
                          hint: "Enter new 4-digit PIN",
                        ),
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
                          },
                        ),
                        const Spacer(),
                        CustomBtn(
                          text: appLocalizations(context).submit,
                          onTap: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final email =
                                  await SharedPreferenceHelper.getEmail();
                              if (email.isEmpty) {
                                showToast("Missing username/email");
                                return;
                              }
                              pinBloc.add(ChangeTransactionPinEvent(
                                  username: email,
                                  currentPin: _currentPinController.text.trim(),
                                  newPin: _newPinController.text.trim()));
                            }
                          },
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
