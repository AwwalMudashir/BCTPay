import 'package:bctpay/globals/index.dart';

class SignupOtpScreen extends StatefulWidget {
  final String email;
  const SignupOtpScreen({super.key, this.email = ""});

  @override
  State<SignupOtpScreen> createState() => _SignupOtpScreenState();
}

class _SignupOtpScreenState extends State<SignupOtpScreen>
    with SingleTickerProviderStateMixin {
  final pinController = TextEditingController();
  final ApisBloc otpBloc = ApisBloc(ApisBlocInitialState());

  AnimationController? _controller;
  bool _otpTimedOut = false;
  String _email = "";

  @override
  void initState() {
    super.initState();
    _email = widget.email;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addStatusListener((AnimationStatus state) {
        if (state == AnimationStatus.completed) {
          _otpTimedOut = true;
        }
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendOtp();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = args(context);
    if (arg is Map && arg["email"] is String && (arg["email"] as String).isNotEmpty) {
      _email = arg["email"];
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(
        title: "",
        titleWidget: AppBarTitleWidget(),
        centerTitle: true,
      ),
      body: BlocConsumer(
          bloc: otpBloc,
          listener: (context, state) {
            if (state is VerifyRegistrationOtpState) {
              final codeStr =
                  state.value.codeString ?? state.value.code?.toString();
              if (state.value.isOk ||
                  codeStr == "00" ||
                  codeStr == "000" ||
                  codeStr == "0" ||
                  codeStr == "200") {
                final msg = state.value.message ??
                    appLocalizations(context).verificationCode;
                showSuccessDialog(
                  msg,
                  context,
                  onOkBtnPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (route) => false);
                  },
                  dismissOnBackKeyPress: false,
                  dismissOnTouchOutside: false,
                );
              } else {
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }
            if (state is ResendRegistrationOtpState) {
              final codeStr =
                  state.value.codeString ?? state.value.code?.toString();
              if (state.value.isOk ||
                  codeStr == "00" ||
                  codeStr == "000" ||
                  codeStr == "0" ||
                  codeStr == "200") {
                _otpTimedOut = false;
                _controller?.forward(from: 0.0);
                showToast(state.value.message ?? state.value.error ?? "");
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
                            if (_email.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                _email,
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Pinput(
                        length: 4,
                        defaultPinTheme: defaultPinTheme,
                        controller: pinController,
                        keyboardType: TextInputType.number,
                        onCompleted: (_) {},
                      ),
                      TextButton(
                          onPressed: () {
                            if (_otpTimedOut) {
                              _sendOtp();
                            } else {
                              showErrorMessage(
                                  context,
                                  appLocalizations(context)
                                      .youCantRetryYet);
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
                      _buildResendTimer(),
                      CustomBtn(
                          onTap: () {
                            if (_otpTimedOut) {
                              showToast(appLocalizations(context)
                                  .ohNoTheOTPTimedOutPleaseRequestANewCodeAndTryAgain);
                            } else {
                              final otp = pinController.text;
                              if (otp.length == 4) {
                                otpBloc.add(VerifyRegistrationOtpEvent(
                                    email: _email, otp: otp));
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

  Widget _buildResendTimer() {
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

  void _sendOtp() {
    if (_email.isEmpty) {
      showToast(appLocalizations(context).pleaseEnterYourEmailAddress);
      return;
    }
    _otpTimedOut = false;
    _controller?.forward(from: 0.0);
    otpBloc.add(ResendRegistrationOtpEvent(email: _email));
  }

  void showErrorMessage(BuildContext context, String message) {
    if (message.isEmpty) return;

    Flushbar(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 0.0,
        left: 16.0,
        right: 16.0,
      ),
      duration: const Duration(seconds: 4),
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
    ).show(context);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

