import 'package:bctpay/globals/index.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var emailPhoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isForgetByEmail = true;

  var forgetPasswordBloc = ApisBloc(ApisBlocInitialState());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(
        title: "",
      ),
      body: BlocConsumer(
          bloc: forgetPasswordBloc,
          listener: (context, state) {
            if (state is ForgetPasswordState) {
              if (state.value.code == 200) {
                showSuccessDialog(state.value.message, context,
                    redirectToLogin: true);
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
                          child: Image.asset(Assets.assetsImagesForgot),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                appLocalizations(context).forgotPassword,
                                style: textTheme.displayMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                appLocalizations(context)
                                    .dontWorryItHappensPleaseEnterTheAdressAssociatedWithYourAccount,
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        isForgetByEmail
                            ? CustomTextField(
                                controller: emailPhoneController,
                                keyboardType: TextInputType.emailAddress,
                                labelText:
                                    "${AppLocalizations.of(context)!.emailAddress} *",
                                hintText: AppLocalizations.of(context)!
                                    .enterEmailAddress,
                                prefix: Image.asset(
                                  Assets.assetsImagesEmail,
                                  scale: textFieldSuffixScale,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return appLocalizations(context)
                                        .pleaseEnterYourEmailAddress;
                                  }
                                  if (!validateEmail(value)) {
                                    return appLocalizations(context)
                                        .pleaseEnterYourValidEmailAddress;
                                  }
                                  return null;
                                },
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CountryPickerTxtFieldPrefix(
                                      showPhoneCodeAlso: true),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: emailPhoneController,
                                      keyboardType: TextInputType.number,
                                      labelText:
                                          "${AppLocalizations.of(context)!.mobileNumber} *",
                                      hintText: AppLocalizations.of(context)!
                                          .enterMobileNumber,
                                      prefix: Image.asset(
                                        Assets.assetsImagesPhone2,
                                        scale: textFieldSuffixScale,
                                      ),
                                      onChanged: seperatePhoneAndDialCode,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return appLocalizations(context)
                                              .pleaseEnterYourMobileNumber;
                                        }
                                        if (!validatePhone(value)) {
                                          return appLocalizations(context)
                                              .pleaseEnterValidMobileNumber;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 50,
                        ),
                        BlocConsumer(
                            bloc: selectCountryBloc,
                            listener: (context, state) {
                              if (state is SelectCountryState) {
                                if (emailPhoneController.text
                                    .contains(state.countryData.phoneCode)) {
                                  emailPhoneController.text =
                                      emailPhoneController.text.replaceAll(
                                          "+${state.countryData.phoneCode}",
                                          "");
                                }
                              }
                            },
                            builder: (context, state) {
                              return CustomBtn(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      forgetPasswordBloc.add(
                                          ForgetPasswordEvent(
                                              email:
                                                  emailPhoneController.text));
                                    }
                                  },
                                  text: appLocalizations(context).continue1);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
