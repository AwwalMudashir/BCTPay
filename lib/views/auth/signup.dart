import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final nationalityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ApisBloc signupBloc = ApisBloc(ApisBlocInitialState());
  final passwordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final confirmPasswordVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final selectGenderBloc = SelectionBloc(SelectStringState(null));
  final tncBloc = SelectionBloc(SelectBoolState(false));

  CountryData? selectedCountryPhoneCode = selectedCountry;
  String? selectedGender;
  bool isTncAccepted = false;

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    nationalityController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    signupBloc.close();
    super.dispose();
  }

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
      labelStyle: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(color: Colors.grey.shade700),
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: Colors.grey.shade600) : null,
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
        borderSide: const BorderSide(
          color: themeLogoColorBlue,
          width: 1.2,
        ),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    ),
  );
}

  void onSignupPressed() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedGender == null) {
      showFailedDialog("Please select gender", context);
      return;
    }

    if (!isTncAccepted) {
      showFailedDialog("Please accept terms and conditions", context);
      return;
    }

    signupBloc.add(
      SignUpEvent(
        email: emailController.text,
        phoneCode: selectedCountryPhoneCode?.phoneCode ?? "",
        phoneNumber: phoneController.text,
        password: passwordController.text,
        firstName: fnameController.text,
        gender: selectedGender,
      ),
    );
  }

  Widget _genderOption(String label, String value, String? groupValue) {
    final isSelected = value == groupValue;
    return Expanded(
      child: InkWell(
        onTap: () {
          selectedGender = value;
          selectGenderBloc.add(SelectStringEvent(value));
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? themeLogoColorBlue.withValues(alpha: 0.1)
                : Colors.grey.shade100,
            border: Border.all(
              color: isSelected ? themeLogoColorBlue : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? themeLogoColorBlue : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

@override
Widget build(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return Scaffold(
    backgroundColor: const Color(0xFFF6F7F9),
    body: BlocConsumer<ApisBloc, ApisBlocState>(
      bloc: signupBloc,
      listener: (context, state) {
        if (state is SignUpState && state.value.code == 200) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.signupOtp,
            arguments: {"email": emailController.text.trim()},
          );
        } else if (state is ApisBlocErrorState) {
          showFailedDialog(state.message, context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ApisBlocLoadingState,
          progressIndicator: const Loader(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  /// HEADER
                  Center(
  child: Column(
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeLogoColorBlue.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.person_add_rounded, // 👈 signup icon
          size: 32,
          color: themeLogoColorBlue,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        appLocalizations(context).signUp,
        style: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Text(
        "Create your account to get started",
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

                  /// FORM CARD
                 Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        appLocalizations(context).signUp,
        style: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 20),

      _buildTextField(
        controller: fnameController,
        label: "${appLocalizations(context).firstName} *",
        prefixIcon: Icons.person_outline,
      ),

      const SizedBox(height: 16),

      _buildTextField(
        controller: emailController,
        label: "${appLocalizations(context).emailAddress} *",
        keyboardType: TextInputType.emailAddress,
        prefixIcon: Icons.email_outlined,
      ),

      const SizedBox(height: 16),

      _buildTextField(
        controller: phoneController,
        label: "${appLocalizations(context).mobileNumber} *",
        keyboardType: TextInputType.phone,
        prefixIcon: Icons.phone_outlined,
      ),

      const SizedBox(height: 16),

      BlocBuilder<SelectionBloc, SelectionBlocState>(
        bloc: passwordVisiblityBloc,
        builder: (context, state) {
          if (state is SelectBoolState) {
            return _buildTextField(
              controller: passwordController,
              label: "${appLocalizations(context).password} *",
              obscureText: state.value,
              prefixIcon: Icons.lock_outline_rounded,
              suffixIcon: state.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              onSuffixTap: () {
                passwordVisiblityBloc
                    .add(SelectBoolEvent(!state.value));
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),

      const SizedBox(height: 16),

      // Gender Selection
      BlocBuilder<SelectionBloc, SelectionBlocState>(
        bloc: selectGenderBloc,
        builder: (context, state) {
          if (state is SelectStringState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations(context).gender,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _genderOption(
                      appLocalizations(context).male,
                      "MALE",
                      state.value,
                    ),
                    const SizedBox(width: 12),
                    _genderOption(
                      appLocalizations(context).female,
                      "FEMALE",
                      state.value,
                    ),
                  ],
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),

      const SizedBox(height: 16),

      // Terms and Conditions
      BlocBuilder<SelectionBloc, SelectionBlocState>(
        bloc: tncBloc,
        builder: (context, state) {
          if (state is SelectBoolState) {
            return Row(
              children: [
                Checkbox(
                  value: state.value,
                  onChanged: (value) {
                    isTncAccepted = value ?? false;
                    tncBloc.add(SelectBoolEvent(value ?? false));
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
                    color: state.value ? themeLogoColorBlue : Colors.grey.shade400,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        TextSpan(
                          text: appLocalizations(context).tnc,
                          style: TextStyle(
                            color: themeLogoColorBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: " and ",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: themeLogoColorBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),

      const SizedBox(height: 24),

      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onSignupPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: themeLogoColorBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            appLocalizations(context).signUp,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ],
  ),
),


                  const SizedBox(height: 20),

                  /// SIGN IN LINK
                  Center(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        appLocalizations(context).alreadyHaveAnAccount,
        style: textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade600,
        ),
      ),
      TextButton(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.login),
        child: Text(
          appLocalizations(context).signIn,
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
      },
    ),
  );
}
}
