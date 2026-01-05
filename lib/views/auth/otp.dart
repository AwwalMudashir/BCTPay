import 'package:bctpay/globals/index.dart';

class OTPScreen extends StatefulWidget {
  final LoginBody? loginBody;
  final bool? isRemember;

  const OTPScreen({super.key, this.loginBody, this.isRemember});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen>
    with SingleTickerProviderStateMixin {
  bool _otpTimedOut = false;
  bool resend = false;
  AnimationController? _controller;
  Flushbar? flush;

  String? emailOTP;

  final pinController = TextEditingController();
  final ApisBloc loginBloc = ApisBloc(ApisBlocInitialState());

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addStatusListener((AnimationStatus state) {
        if (state == AnimationStatus.completed) {
          _otpTimedOut = true;
        }
      });
    _controller!.forward(from: 0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as OTPScreen;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(
        title: "",
        titleWidget: AppBarTitleWidget(),
        centerTitle: true,
      ),
      body: BlocConsumer(
          bloc: loginBloc,
          listener: (context, state) {
            if (state is LoginState) {
              if (state.value.code == 200) {
                SharedPreferenceHelper.saveLoginData(state.value);
                SharedPreferenceHelper.saveLoginCredentials(
                        mobile: arg.loginBody?.email ?? "",
                        password: arg.loginBody?.password ?? "",
                        isRemember: arg.isRemember ?? false)
                    .whenComplete(() {
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.bottombar, (route) => false);
                });
              } else if (state.value.code == 410) {
                showEmailVerificationDialog(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }
            if (state is SendOTPState) {
              if (state.value.code == 200) {
                _otpTimedOut = false;
                resend = true;
                _controller!.forward(from: 0.0);
                showToast(state.value.message ?? state.value.error ?? "");
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
                showSuccessDialog(
                    state.value.message ?? state.value.error ?? "", context);
              } else if (state.value.code == 401) {
                sessionExpired(
                    state.value.message ?? state.value.error ?? "", context);
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
              child: SingleChildScrollView(
                child: Container(
                  height: height - 100,
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              appLocalizations(context).verificationCode,
                              style: textTheme.displayMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              appLocalizations(context)
                                  .weHaveSentTheCodeVerificationToYourEmailAddress,
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
                      Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        controller: pinController,
                        onCompleted: (pin) {
                          emailOTP = pin;
                        },
                      ),
                      TextButton(
                          onPressed: () async {
                            if (resend) {
                              showToast(appLocalizations(context)
                                  .cantResendOTPAgainMsg);
                              return;
                            } else if (_otpTimedOut) {
                              loginBloc
                                  .add(SendOTPEvent(loginBody: arg.loginBody));
                            } else {
                              showErrorMessage(context,
                                  appLocalizations(context).youCantRetryYet);
                            }
                          },
                          child: Wrap(
                            children: [
                              Text(
                                "${appLocalizations(context).didntReceiveCode} ",
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                appLocalizations(context).requestAgain,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: themeYellowColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                      _buildResendSmsWidget(),
                      CustomBtn(
                          onTap: () {
                            if (_otpTimedOut) {
                              showToast(appLocalizations(context)
                                  .ohNoTheOTPTimedOutPleaseRequestANewCodeAndTryAgain);
                            } else {
                              if (emailOTP != null) {
                                loginBloc.add(LoginEvent(
                                    loginBody: arg.loginBody
                                        ?.copyWith(otp: emailOTP)));
                              } else {
                                showToast(
                                    appLocalizations(context).pleaseEnterOTP);
                              }
                            }
                          },
                          text: appLocalizations(context).submit),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildResendSmsWidget() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Countdown(
          animation: StepTween(
            begin: 60,
            end: 00,
          ).animate(_controller!),
        ),
      ),
    );
  }

  void showErrorMessage(BuildContext context, String message) {
    if (flush != null) {
      flush!.dismiss(true);
    }

    if (message == "") return;

    flush = Flushbar(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 0.0,
        left: 16.0,
        right: 16.0,
      ),
      duration: const Duration(seconds: 10),
      title: appLocalizations(context).error,
      message: message,
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Icon(
          Icons.warning,
          size: 28.0,
          color: Colors.red[300],
        ),
      ),
      leftBarIndicatorColor: Colors.red[300],
      isDismissible: true,
      mainButton: TextButton.icon(
        onPressed: () {
          flush!.dismiss(true);
        },
        icon: Icon(
          Icons.cancel,
          size: 28.0,
          color: Colors.red[300],
        ),
        label: Text(
          appLocalizations(context).close,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    )..show(context);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void showEmailVerificationDialog(String message, BuildContext context) {
    var arg = args(context) as OTPScreen;
    showFailedDialog(message, context,
        hyperlink: TextButton(
            onPressed: () {
              if (arg.loginBody?.phoneCode != null) {
                loginBloc.add(ResendVerificationLinkEvent(
                    phoneCode: "+${arg.loginBody?.phoneCode}",
                    phoneNumber: arg.loginBody?.email?.trim() ?? ""));
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
