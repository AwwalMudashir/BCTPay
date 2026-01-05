import 'package:bctpay/globals/index.dart';

class ForgetOTPVerificationScreen extends StatefulWidget {
  final String? email;

  const ForgetOTPVerificationScreen({super.key, this.email});

  @override
  State<ForgetOTPVerificationScreen> createState() =>
      _ForgetOTPVerificationScreenState();
}

class _ForgetOTPVerificationScreenState
    extends State<ForgetOTPVerificationScreen>
    with SingleTickerProviderStateMixin {
  var forgetPasswordBloc = ApisBloc(ApisBlocInitialState());
  bool _otpTimedOut = false;
  AnimationController? _controller;
  Flushbar? flush;

  String? emailOTP;

  final pinController = TextEditingController();

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
    var args = ModalRoute.of(context)!.settings.arguments
        as ForgetOTPVerificationScreen;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: appLocalizations(context).otp,
        centerTitle: true,
      ),
      body: BlocConsumer(
          bloc: forgetPasswordBloc,
          listener: (context, state) {
            if (state is ForgetVerifyOTPState) {
              if (state.value.code == 200) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.reset,
                  arguments: ResetPasswordScreen(
                    emailOTP: state.value.data!.otp,
                  ),
                );
              } else {
                showFailedDialog(state.value.message, context);
              }
            }
            if (state is ForgetPasswordState) {
              if (state.value.code == 200) {
                Navigator.pushReplacementNamed(
                    context, "/forgotOTPVerification",
                    arguments: ForgetOTPVerificationScreen(
                      email: args.email,
                    ));
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
                  height: height - 100,
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appLocalizations(context).verificationCode,
                              style: textTheme.displayMedium,
                            ),
                            Text(
                              appLocalizations(context)
                                  .weHaveSentTheCodeVerificationToYourMobileNumber,
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
                          forgetPasswordBloc
                              .add(ForgetVerifyOTPEvent(emailOTP: emailOTP!));
                        },
                      ),
                      TextButton(
                          onPressed: () async {
                            if (_otpTimedOut) {
                              forgetPasswordBloc
                                  .add(ForgetPasswordEvent(email: args.email!));
                              _otpTimedOut = false;
                              _controller!.forward(from: 0.0);
                            } else {
                              showErrorMessage(context,
                                  appLocalizations(context).youCantRetryYet);
                            }
                          },
                          child: Wrap(
                            children: [
                              Text(
                                "${appLocalizations(context).didntReceiveCode} ",
                              ),
                              Text(
                                appLocalizations(context).requestAgain,
                                style:
                                    const TextStyle(color: Color(0xffEEAB00)),
                              ),
                            ],
                          )),
                      _buildResendSmsWidget(),
                      CustomBtn(
                          onTap: () {
                            if (emailOTP != null) {
                              forgetPasswordBloc.add(
                                  ForgetVerifyOTPEvent(emailOTP: emailOTP!));
                            } else {
                              showToast(
                                  appLocalizations(context).pleaseEnterOTP);
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
}
