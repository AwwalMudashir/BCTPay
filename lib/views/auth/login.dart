import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ApisBloc loginBloc = ApisBloc(ApisBlocInitialState());
  bool isRemember = false;
  final passwordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final isRememberBloc = SelectionBloc(SelectBoolState(false));
  String? selectedCountryPhoneCode = selectedCountry?.phoneCode;

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool obscureText = false,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey.shade700),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey.shade600) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: Colors.grey.shade600),
                onPressed: onSuffixTap,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: themeLogoColorBlue, width: 1.2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }

  Future<void> getLoginCredencials() async {
    await SharedPreferenceHelper.getisRemember().then((isTrue) async {
      if (isTrue) {
        emailController.text = await SharedPreferenceHelper.getEmail();
        // Password auto-fill removed for security
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
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: const CustomAppBar(
        centerTitle: true,
        title: "",
        titleWidget: AppBarTitleWidget(),
        actions: [LanguageWidget()],
      ),
      body: BlocConsumer(
          bloc: loginBloc,
          listener: (context, state) async {
            if (state is LoginState) {
              final codeStr =
                  state.value.codeString ?? state.value.code?.toString();
              if (state.value.isOk ||
                  codeStr == "200" ||
                  codeStr == "00" ||
                  codeStr == "000") {
                await SharedPreferenceHelper.saveLoginData(state.value);
                await SharedPreferenceHelper.saveLoginCredentials(
                    mobile: emailController.text.trim(),
                    password: "", // Don't save password for security
                    isRemember: isRemember);
                if (!context.mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.bottombar, (route) => false);
              } else {
                if (!context.mounted) return;
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }
            if (state is SendOTPState) {
              if (state.value.code == 200) {
                // Do async work first
                final loginBody = await LoginBody.from(
                  password: passwordController.text,
                  email: emailController.text,
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
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
                  vertical: 12,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Header Section
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Responsive padding
                              decoration: BoxDecoration(
                                color: themeLogoColorBlue.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.login_rounded,
                                size: MediaQuery.of(context).size.width * 0.08, // Responsive size
                                color: themeLogoColorBlue,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              appLocalizations(context).welcomeBack,
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              appLocalizations(context).helloThereSignInToContinue,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade600,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Form Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05), // 5% of screen width
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appLocalizations(context).signIn,
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              controller: emailController,
                              label: "${appLocalizations(context).emailAddress} *",
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email_outlined,
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
                            const SizedBox(height: 16),
                            BlocBuilder(
                                bloc: passwordVisiblityBloc,
                                builder: (context, pwdVisiblityState) {
                                  if (pwdVisiblityState is SelectBoolState) {
                                    return _buildTextField(
                                      controller: passwordController,
                                      label: "${appLocalizations(context).password} *",
                                      obscureText: pwdVisiblityState.value,
                                      prefixIcon: Icons.lock_outline_rounded,
                                      suffixIcon: pwdVisiblityState.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      onSuffixTap: () {
                                        passwordVisiblityBloc.add(
                                            SelectBoolEvent(!pwdVisiblityState.value));
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return appLocalizations(context)
                                              .pleaseEnterYourPassword;
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                            const SizedBox(height: 16),

                            // Remember Me & Login Button
                            Row(
                              children: [
                                BlocConsumer(
                                    bloc: isRememberBloc,
                                    listener: (context, isRememberState) {
                                      if (isRememberState is SelectBoolState) {
                                        isRemember = isRememberState.value;
                                      }
                                    },
                                    builder: (context, isRememberState) {
                                      if (isRememberState is SelectBoolState) {
                                        return Checkbox(
                                          value: isRememberState.value,
                                          onChanged: (value) {
                                            isRememberBloc.add(SelectBoolEvent(value ?? false));
                                          },
                                          activeColor: Colors.white,
                                          checkColor: themeLogoColorBlue,
                                          fillColor: WidgetStateProperty.resolveWith<Color>(
                                            (Set<WidgetState> states) {
                                              if (states.contains(WidgetState.selected)) {
                                                return Colors.white;
                                              }
                                              return Colors.grey.shade200;
                                            },
                                          ),
                                          side: BorderSide(
                                            color: isRememberState.value ? themeLogoColorBlue : Colors.grey.shade400,
                                            width: 1.5,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    }),
                                Expanded(
                                  child: Text(
                                    appLocalizations(context).rememberMe,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final loginBody = await LoginBody.from(
                                        password: passwordController.text,
                                        email: emailController.text.trim(),
                                      );
                                      loginBloc.add(LoginEvent(loginBody: loginBody));
                                    }
                                  },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: themeLogoColorBlue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  appLocalizations(context).signIn,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Sign Up Link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              appLocalizations(context).dontHaveAnAccount,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
                              child: Text(
                                appLocalizations(context).signUp,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: themeLogoColorBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                phoneNumber: emailController.text.trim()));
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
