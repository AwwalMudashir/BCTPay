import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:lottie/lottie.dart';

class TransactionDetailScreen extends StatefulWidget {
  final BankAccount? toAccount;
  final PaymentRequest? request;
  final bool isRequestToPay;
  final bool isSelfTransfer;
  final bool isScanToPay;
  final bool isContactPay;
  final bool isInvoicePay;
  final bool isSubscriptionPay;
  final bool isPaymentLinkPay;
  final String? receiverType;
  final Invoice? invoiceData;
  final Subscriber? subscriptionData;
  final PaymentLinkData? paymentLinkData;
  final String? amount;

  const TransactionDetailScreen(
      {super.key,
      this.toAccount,
      this.request,
      this.isRequestToPay = false,
      this.isSelfTransfer = false,
      this.isScanToPay = false,
      this.isContactPay = false,
      this.isInvoicePay = false,
      this.isSubscriptionPay = false,
      this.isPaymentLinkPay = false,
      this.receiverType,
      this.invoiceData,
      this.subscriptionData,
      this.paymentLinkData,
      this.amount});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  var transferPaymentBloc = ApisBloc(ApisBlocInitialState());
  var accountLimitBloc = ApisBloc(ApisBlocInitialState());
  var amountController = TextEditingController();
  var paymentNoteController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  double amount = 0.0;
  BankAccount? toAccount;
  double minTxnAmountLimit = 0.0;
  double maxTxnAmountLimit = 0.0;

  String? omToken;

  String? msisdnNumber = "7701101246";

  var otpController = TextEditingController();

  String? orderId;

  @override
  void initState() {
    super.initState();
    accountLimitBloc.stream.listen((state) {
      if (state is AccountLimitState) {
        if (state.value.code == 200) {
          var transactionLimitData = state.value.data!.transactionLimits
              .where((e) => e.serviceType == "Transfer");
          if (transactionLimitData.isNotEmpty) {
            minTxnAmountLimit =
                double.tryParse(transactionLimitData.first.miniValue) ?? 0.00;
            maxTxnAmountLimit =
                transactionLimitData.first.perTrasactionAmount?.toDouble() ??
                    0.00;
          }
        } else if (state.value.code ==
            HTTPResponseStatusCodes.sessionExpireCode) {
          if (!mounted) return;
          sessionExpired(state.value.message, context);
        }
      }
    });
    accountLimitBloc.add(GetAccountLimitEvent());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateRequestedAmount();
      checkPrimaryOrActiveAccountAvailability(context);
    });
  }

  void updateRequestedAmount() {
    var args =
        ModalRoute.of(context)!.settings.arguments as TransactionDetailScreen;
    amountController
        .text = currencyTextInputFormatter.formatDouble(double.parse(args
            .isRequestToPay
        ? args.request?.requestedAmount ?? "0"
        : args.isInvoicePay
            ? args.invoiceData?.totalAmount ?? "0"
            : args.isSubscriptionPay
                ? getTotalSubscriptionAmount(args.subscriptionData?.planInfo)
                : args.isPaymentLinkPay
                    ? args.amount ?? ""
                    : ""));
    _updateAmount(amountController.text);
  }

  bool isTxnSuccessful(String? txnStep) => txnStep == "SUCCESSFUL";

  bool isTxnPending(String? txnStep) => txnStep == "PENDING";

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Duration remaining = const Duration(minutes: 1); // ⏱️ 5 minutes countdown
  Timer? countdownTimer;
  BuildContext? _activeDialogContext;

  Future _showProcessingDialog(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.black54,
      builder: (dialogContext) {
        _activeDialogContext = context;
        return Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.2,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              // Start timer only once
              countdownTimer ??=
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                if (remaining.inSeconds <= 1) {
                  timer.cancel();
                  Navigator.of(dialogContext, rootNavigator: true)
                      .pop(); // auto-close after timeout
                } else {
                  setState(() {
                    remaining -= const Duration(seconds: 1);
                  });
                }
              });

              // Format time as MM:SS
              String formattedTime =
                  "${remaining.inMinutes.toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}";

              return PopScope(
                canPop: remaining.inSeconds > 1 ? false : true,
                onPopInvokedWithResult: (isPop, _) async => false,
                // prevent back press
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: themeLogoColorBlue,
                  insetPadding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // TextAnimator("Processing transaction...",
                        //   incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(),
                        //   atRestEffect: WidgetRestingEffects.pulse(),
                        //   style: const TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 22,
                        //     color: themeYellowColor,
                        //   ),
                        // ),
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: themeYellowColor,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText('Processing transaction...'),
                            ],
                            onTap: () {},
                            repeatForever:
                                true, // 👈 This makes it loop endlessly
                            //pause: Duration(milliseconds: 1000), // Optional pause between loops
                          ),
                        ),
                        // Text(
                        //   "Processing transaction...",
                        //   style: const TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 22,
                        //     color: themeYellowColor,
                        //   ),
                        // ),
                        const SizedBox(height: 22),
                        // Show Lottie animation here
                        Lottie.asset(
                          'assets/lottie/Clock_loop.json',
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          formattedTime,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          //"We're waiting for confirmation from the network.\nPlease wait...",
                          //"Processing your payment of ${amount.isNotEmpty ? amount : ""}. Awaiting confirmation...",
                          "Your payment is being processed. Awaiting confirmation…",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void dismissDialogAndStopCounter() {
    countdownTimer?.cancel(); //
    remaining = const Duration(minutes: 1);
    if (_activeDialogContext != null) {
      Navigator.of(_activeDialogContext!, rootNavigator: true).pop();
      _activeDialogContext = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    //_showProcessingDialog(context);
    var args =
        ModalRoute.of(context)!.settings.arguments as TransactionDetailScreen;
    var textTheme = Theme.of(context).textTheme;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    width = MediaQuery.of(context).size.width;
    toAccount = args.toAccount;
    return Scaffold(
        backgroundColor: backgroundColor,
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   showSuccessTxnDialog(
        //       InitiateTransactionResponse(
        //           code: 200,
        //           message: "Txn success",
        //           data: InitialteTxnData(
        //               transactionBctpayRefrenceNumber: "324343",
        //               createdAt: DateTime.now(),
        //               transactionFeeServiceType: "MOMO TO MOMO",
        //               receiverName: "Raj kumar patel",
        //               senderAmount: "50000",
        //               // commissionFee: "500",
        //               paybleCommissionFeeAmount: "50",
        //               paybleTotalAmount: "50050")),
        //       context);
        // }),
        appBar: CustomAppBar(
          title: appLocalizations(context).sendingTo,
          // centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.popUntil(context,
                      (route) => route.settings.name == AppRoutes.bottombar);
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: BlocConsumer(
            bloc: transferPaymentBloc,
            listener: (context, state) {
              if (state is CheckoutTxnState) {
                debugPrint(
                    "checkoutTxn called --> $state\n code -> ${state.value.code}\n txnStep -> ${state.value.data?.transactionStep}\n txnStepSender -> ${state.value.data?.transactionStepWithSender}");
                // debugPrint(state.value.message);
                if (state.value.code ==
                        HTTPResponseStatusCodes.momoTxnSuccessCode &&
                    state.value.data?.transactionStep == "SUCCESSFUL") {
                  if (state.isMOMOTxn) {
                    // Call another checkout api
                    transferPaymentBloc.add(CheckoutC2MomoTxnEvent(
                      orderId:
                          state.value.data?.transactionBctpayRefrenceNumber ??
                              "",
                      showLoader: true,
                      isInvoicePay: state.isInvoicePay,
                      isSubscriptionPay: state.isSubscriptionPay,
                      isTicketPay: state.isTicketPay,
                      isTransfer: state.isTransfer,
                    ));
                  } else {
                    showSuccessTxnDialog(state.value, context);
                  }
                  // Navigator.of(context)
                  //     .pushReplacementNamed("/transfersuccess");
                } else if (state.value.code == 200 &&
                    (state.value.data?.transactionStepWithSender ==
                            "SUCCESSFUL" ||
                        state.value.data?.transactionStepWithSender ==
                            "PENDING")) {
                  if (state.isMOMOTxn) {
                    // Call another checkout api
                    transferPaymentBloc.add(CheckoutC2MomoTxnEvent(
                      orderId:
                          state.value.data?.transactionBctpayRefrenceNumber ??
                              "",
                      showLoader: true,
                      isInvoicePay: state.isInvoicePay,
                      isSubscriptionPay: state.isSubscriptionPay,
                      isTicketPay: state.isTicketPay,
                    ));
                  } else {
                    showSuccessTxnDialog(state.value, context);
                  }
                } else if (state.value.code ==
                        HTTPResponseStatusCodes.momoTxnSuccessCode &&
                    state.value.data?.transactionStepWithSender ==
                        "INITIATED") {
                  ///open webview for Orange money txn
                  if (state.value.data?.senderEFTCompletionUrl?.isNotEmpty ??
                      false) {
                    ///Card transaction flow
                    Navigator.of(context).pushNamed(AppRoutes.webview,
                        arguments: CustomWebView(
                          url: state.value.data?.senderEFTCompletionUrl,
                          isInvoicePay: args.isInvoicePay,
                          isSubscriptionPay: args.isSubscriptionPay,
                          isPaymentLinkPay: args.isPaymentLinkPay,
                        ));
                  } else {
                    ///Orange money transaction flow
                    orderId = state.value.data
                        ?.thirdPartyTransctionRefrenceNumberWithSender;
                    omToken =
                        state.value.data?.omSenderPaymentUrl!.split("/").last ??
                            "";
                     msisdnNumber = state.value.data?.senderAccountNumber?.replaceFirst('+', '');
                    transferPaymentBloc.add(GetOMChargesEvent(
                        token: omToken ?? "",
                        msisdnNumber: msisdnNumber ?? "",
                        orderId: orderId ?? ""));
                  }
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                } else {
                  showFailedDialog(state.value.message, context);
                }
              }

              // If sender is MOMO in transaction
              if (state is CheckoutC2MomoTxnState) {
                debugPrint(
                    "CheckoutC2MomoInvoiceTxnState --> txnReceiver -> ${state.value.data?.transactionStepWithReceiver}\n -> txnSender -> ${state.value.data?.transactionStepWithSender},\n txn step -> ${state.value.data?.transactionStep}");
                if (state.showLoader) {
                  _showProcessingDialog(context);
                }
                if (state.value.code ==
                    HTTPResponseStatusCodes.momoTxnSuccessCode) {
                  // if (state.value.data?.transactionStepWithSender ==
                  //     "SUCCESSFUL") {
                  if (isTxnSuccessful(
                          state.value.data?.transactionStepWithSender) &&
                      isTxnSuccessful(
                          state.value.data?.transactionStepWithReceiver) &&
                      isTxnSuccessful(state.value.data?.transactionStep)) {
                    dismissDialogAndStopCounter();
                    showSuccessTxnDialog(state.value, context);
                    // } else if (state.value.data?.transactionStepWithSender ==
                    //     "PENDING") {
                  } else if (isTxnPending(
                          state.value.data?.transactionStepWithSender) ||
                      isTxnPending(
                          state.value.data?.transactionStepWithReceiver) ||
                      isTxnPending(state.value.data?.transactionStep)) {
                    if (remaining.inSeconds <= 1) {
                      dismissDialogAndStopCounter();
                      debugPrint("*** Time related issue");
                      showFailedDialog(state.value.message, context);
                    } else if (remaining.inSeconds > 1) {
                      transferPaymentBloc.add(CheckoutC2MomoTxnEvent(
                        orderId: state.orderId,
                        isInvoicePay: state.isInvoicePay,
                        isSubscriptionPay: state.isSubscriptionPay,
                        isTicketPay: state.isTicketPay,
                        isTransfer: state.isTransfer,
                      ));
                    }
                  } else {
                    dismissDialogAndStopCounter();
                    showFailedDialog(state.value.message, context);
                  }
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.momoTxnFailedCode) {
                  // dismissDialogAndStopCounter();
                  showFailedDialog(
                      appLocalizations(context).failedTransactions, context,
                      onTap: () {
                    dismissDialogAndStopCounter();
                    Navigator.of(context).pop();
                  });
                } else {
                  //dismissDialogAndStopCounter();
                  showFailedDialog(
                      appLocalizations(context).failedTransactions, context,
                      onTap: () {
                    dismissDialogAndStopCounter();
                    Navigator.pop(context);
                  });
                }
                //showSuccessTxnDialog(state.value, context);
              }

              if (state is GetOMChargesState) {
                if (state.value.code == 200) {
                  showCustomDialog("", context,
                      body: Column(
                        children: [
                          Text(
                            appLocalizations(context).verificationCode,
                            style: textTheme.displayMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Pinput(
                            length: 6,
                            // androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                            defaultPinTheme: defaultPinTheme,
                            controller: otpController,
                            onCompleted: (pin) {
                              // emailOTP = pin;
                            },
                          ),
                        ],
                      ), onYesTap: () {
                    transferPaymentBloc.add(
                      FinalizeOMPaymentEvent(
                          token: omToken ?? "",
                          msisdnNumber: msisdnNumber ?? "",
                          otp: otpController.text,
                          orderId: orderId ?? ""),
                    );
                    otpController.clear();
                    Navigator.pop(context);
                  },
                      //  onNoTap: () {
                      //   transferPaymentBloc.add(CancelOMTxnEvent(
                      //     token: omToken ?? "",
                      //   ));
                      //   // Navigator.pop(context);
                      // },
                      btnOkText: appLocalizations(context).submit,
                      btnNoText: appLocalizations(context).cancel);
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(
                      state.value.message ?? state.value.error ?? "", context);
                } else {
                  showFailedDialog(
                      state.value.message ?? state.value.error ?? "", context);
                }
              }

              if (state is FinalizeOMPaymentState) {
                if (state.value.code == 200 && state.value.data != null) {
                  if (args.isPaymentLinkPay) {
                    transferPaymentBloc.add(
                        CheckoutOMTicketPaymentEvent(orderId: orderId ?? ""));
                  } else {
                    transferPaymentBloc
                        .add(GetOrangeTxnStatusEvent(orderId: orderId));
                  }
                  // showSuccessDialog(state.value.message, context);
                  // transferPaymentBloc.add(CancelOMTxnEvent(
                  //   token: omToken ?? "",
                  // ));
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(
                      state.value.message ?? state.value.error ?? "", context);
                } else {
                  showFailedDialog(
                      state.value.message ?? state.value.error ?? "", context);
                }
              }

              if (state is CancelOMTxnState) {
                if (state.value.code == 200) {
                  showSuccessDialog(appLocalizations(context).cancel, context);
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(
                      state.value.message ?? state.value.error ?? "", context);
                } else {
                  showFailedDialog(
                      state.value.message ?? state.value.error ?? "", context);
                }
              }

              if (state is GetOrangeTxnStatusState) {
                debugPrint(
                    "GetOrangeTxnStatusState -> txnReceiver -> ${state.value.data?.transactionStepWithReceiver}\n -> txnSender -> ${state.value.data?.transactionStepWithSender},\n txn step -> ${state.value.data?.transactionStep}");
                if (state.value.code ==
                        HTTPResponseStatusCodes.momoTxnSuccessCode &&
                    isTxnSuccessful(
                        state.value.data?.transactionStepWithSender) &&
                    isTxnSuccessful(
                        state.value.data?.transactionStepWithReceiver) &&
                    isTxnSuccessful(state.value.data?.transactionStep)) {
                  // state.value.data?.transactionStep == "SUCCESSFUL") {
                  showSuccessTxnDialog(state.value, context);
                  // Navigator.of(context)
                  //     .pushReplacementNamed("/transfersuccess");
                } else if (state.value.code ==
                        HTTPResponseStatusCodes.momoTxnSuccessCode ||
                    isTxnPending(state.value.data?.transactionStepWithSender) ||
                    isTxnPending(
                        state.value.data?.transactionStepWithReceiver) ||
                    isTxnPending(state.value.data?.transactionStep)) {
                  //state.value.data?.transactionStep == "PENDING") {
                  showFailedDialog(
                    state.value.message,
                    context,
                    dialogType: DialogType.infoReverse,
                    title: AppLocalizations.of(context)?.pending,
                    btnOkText: AppLocalizations.of(context)?.close,
                  );
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                } else {
                  showFailedDialog(state.value.message, context);
                }
              }

              if (state is ApisBlocErrorState) {
                // showCustomDialog(
                //   "",
                //   context,
                //   btnOkText: appLocalizations(context).done,
                //   showCancel: false,
                //   dismissOnBackKeyPress: false,
                //   dismissOnTouchOutside: false,
                //   dialogType: DialogType.success,
                //   onYesTap: () {
                //     Navigator.popUntil(context,
                //         (route) => route.settings.name == "/bottombar");
                //   },
                //   body: TransferSuccessfullScreen(),
                // );
                dismissDialogAndStopCounter();
                showFailedDialog(state.message, context);
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                progressIndicator: const Loader(),
                inAsyncCall: state is ApisBlocLoadingState,
                child: Container(
                  // height: height - 100,
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Hero(
                              tag: toAccount?.id ?? "",
                              child: SizedBox.square(
                                dimension: 120,
                                child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    // height: 80,
                                    // width: 80,
                                    // decoration: shadowDecoration.copyWith(color: Colors.white),
                                    // padding: const EdgeInsets.all(5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                            imageUrl: getImage(),
                                            progressIndicatorBuilder:
                                                progressIndicatorBuilder,
                                            errorWidget: (BuildContext c,
                                                    String s, Object o) =>
                                                const Icon(
                                                  Icons.image,
                                                  color: Colors.grey,
                                                  size: 70,
                                                )),
                                      ),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              toAccount!.beneficiaryname ??
                                  appLocalizations(context).unknown,
                              style: textTheme.titleSmall?.copyWith(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selectedCountry!.countryCode,
                                  style: textTheme.bodySmall?.copyWith(
                                      // color: Colors.white,
                                      ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CountryFlag.fromCountryCode(
                                  selectedCountry!.countryCode,
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  // beneficiary.accountnumber ?? "",
                                  // "XXX${toAccount!.accountnumber!.substring(toAccount!.accountnumber!.length - 4, toAccount!.accountnumber!.length)}",
                                  toAccount!.accountnumber
                                          ?.showLast4HideAll() ??
                                      "",
                                  style: textTheme.bodySmall?.copyWith(
                                      // color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Hero(
                        //   tag: toAccount!.id,
                        //   child: AccountListItem(
                        //     account: toAccount!,
                        //     showCheckBox: false,
                        //     showPoupMenuBtn: false,
                        //     showSetPrimaryBtnAndAccountStatus: false,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        // BlocConsumer(
                        //     bloc: bankAccountListBloc,
                        //     listener: (context, bankAccountListState) {
                        //       if (bankAccountListState
                        //           is GetBankAccountListState) {
                        //         List<BankAccount> accounts =
                        //             bankAccountListState.value.data ?? [];
                        //         accounts = accounts
                        //             .where((account) =>
                        //                 account.id != toAccount!.id &&
                        //                 account.accountstatus != "0")
                        //             .toList();
                        //         if (accounts.isNotEmpty) {
                        //           var primaryAccounts = accounts.where(
                        //               (bank) =>
                        //                   bank.primaryaccount == "YES");
                        //           if (primaryAccounts.isNotEmpty) {
                        //             selectAccountBloc.add(
                        //                 SelectAccountEvent(
                        //                     primaryAccounts.first));
                        //           } else {
                        //             selectAccountBloc.add(
                        //                 SelectAccountEvent(
                        //                     accounts.first));
                        //           }
                        //         } else {}
                        //       }
                        //     },
                        //     builder: (context, bankAccountListState) {
                        //       if (bankAccountListState
                        //           is GetBankAccountListState) {
                        //         List<BankAccount> accounts =
                        //             bankAccountListState.value.data ?? [];
                        //         // print(accounts);
                        //         accounts = accounts
                        //             .where((account) =>
                        //                 account.id != toAccount!.id &&
                        //                 account.accountstatus != "0")
                        //             .toList();
                        //         if (accounts.isEmpty) {
                        //           return Text(appLocalizations(context)
                        //               .noAccount);
                        //         }
                        //         return BlocConsumer(
                        //             bloc: selectAccountBloc,
                        //             listener:
                        //                 (context, selectAccountstate) {
                        //               if (selectAccountstate
                        //                   is SelectAccountState) {
                        //                 fromAccount =
                        //                     selectAccountstate.account;
                        //                 transactionFeeConfig(
                        //                     bctPaySettingDetailsBlocState);
                        //                 // selectBankBloc.add(
                        //                 //     SelectAccountEvent(
                        //                 //         fromAccount));
                        //               }
                        //             },
                        //             builder:
                        //                 (context, selectAccountstate) {
                        //               if (selectAccountstate
                        //                   is SelectAccountState) {
                        //                 return DropdownButton(
                        //                   value:
                        //                       selectAccountstate.account,
                        //                   onChanged: (value) {
                        //                     fromAccount = value;
                        //                     selectAccountBloc.add(
                        //                         SelectAccountEvent(
                        //                             value));
                        //                   },
                        //                   underline: const SizedBox(),
                        //                   itemHeight: 120,
                        //                   items: accounts
                        //                       .map((e) =>
                        //                           DropdownMenuItem(
                        //                             value: e,
                        //                             child: SizedBox(
                        //                               width: width * 0.85,
                        //                               height: 120,
                        //                               child:
                        //                                   AccountListItem(
                        //                                 account: e,
                        //                                 showCheckBox:
                        //                                     false,
                        //                                 showPoupMenuBtn:
                        //                                     false,
                        //                                 showSetPrimaryBtnAndAccountStatus:
                        //                                     false,
                        //                                 onTap: null,
                        //                               ),
                        //                             ),
                        //                           ))
                        //                       .toList(),
                        //                 );
                        //               }
                        //               return const Loader();
                        //             });
                        //       }
                        //       return const Loader();
                        //     }),
                        // Text(
                        //   selectedCountry.currencySymbol,
                        //   // getCurrency(),
                        //   style: const TextStyle(
                        //       fontSize: 20,
                        //       color: Colors.grey,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // Text(
                        //   "12500.05",
                        //   style: TextStyle(
                        //       fontSize: 25,
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        CustomTextField(
                          readOnly: (args.isInvoicePay ||
                                  args.isSubscriptionPay ||
                                  args.isPaymentLinkPay)
                              ? true
                              : false,
                          //TODO: invoice pay amount is not editable
                          autofocus: true,
                          inputFormatters: [
                            currencyTextInputFormatter,

                            // FilteringTextInputFormatter.allow(
                            //     RegExp(amountRegex)),
                            // CurrencyTextInputFormatter(
                            //   locale:
                            //       selectedCountry.countryCode ==
                            //               "GN"
                            //           ? "fr"
                            //           : "en",
                            //   name: selectedCountry.currencyName,
                            //   // symbol:
                            //   //     "${selectedCountry.currencySymbol} ",
                            //   // locale:
                            //   //     "${selectedLanguage}_${selectedCountry.currencyCode}",
                            //   decimalDigits: 0,
                            //   // name: selectedCountry.currencyName,
                            //   // customPattern: amountRegex,
                            //   symbol: "",
                            // ),
                          ],
                          // initialValue: args.request?.requestedAmount,
                          controller: amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: _updateAmount,
                          labelText:
                              "${appLocalizations(context).howMuchYouWantToSend} *",
                          hintText: "0",
                          suffixText: selectedCountry?.currencySymbol,
                          // suffix: Text(
                          //   selectedCountry!.currencySymbol,
                          //   // style: textTheme.bodyMedium,
                          // ),
                          textAlign: TextAlign.center,
                          // height: 65,
                          style: textTheme.titleLarge!.copyWith(
                              fontSize: 25,
                              color: Colors.black,
                              height: 1,
                              fontWeight: FontWeight.bold),
                          // style: const TextStyle(
                          //     fontSize: 25,
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return appLocalizations(context)
                                  .pleaseEnterValidAmount;
                            } else if (amount <= 0) {
                              return appLocalizations(context)
                                  .amountShouldBeGreaterThanZero;
                            } else if (amount < minTxnAmountLimit &&
                                !args.isSubscriptionPay &&
                                !args.isInvoicePay &&
                                !args.isPaymentLinkPay) {
                              return appLocalizations(context)
                                  .minimumTransferLimitIs(formatCurrency(
                                      minTxnAmountLimit.toStringAsFixed(2)));
                            } else if (amount > maxTxnAmountLimit &&
                                !args.isSubscriptionPay &&
                                !args.isInvoicePay &&
                                !args.isPaymentLinkPay) {
                              return appLocalizations(context)
                                  .maximumTransferLimitIs(formatCurrency(
                                      maxTxnAmountLimit.toStringAsFixed(2)));
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                          maxLength: 100,
                          autovalidateMode: AutovalidateMode.always,
                          controller: paymentNoteController,
                          maxLines: 3,
                          height: 90,
                          labelText: appLocalizations(context).paymentNote,
                          hintText: appLocalizations(context).enterPaymentNote,
                          // validator: (p0) {
                          //   if ((p0?.length ?? 0) > 100) {
                          //     return "Max input limit is 100 characters";
                          //   }
                          //   return null;
                          // },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          appLocalizations(context)
                              .notePlatformFeeWillBeImposedOnSenderForThisTransaction,
                          style: textTheme.bodyMedium,
                        ),
                        // Text(
                        //   appLocalizations(context).feeDetails,
                        //   style: textTheme.displayLarge?.copyWith(
                        //       color: Colors.grey,
                        //       fontWeight: FontWeight.normal),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment:
                        //           MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           "${appLocalizations(context).bctPayFee} :",
                        //           // style: textTheme.bodyMedium,
                        //         ),
                        //         Text(
                        //           formatCurrency(transactionFee
                        //                   ?.toStringAsFixed(2) ??
                        //               "0.00"),
                        //           // style: textTheme.bodyMedium,
                        //         ),
                        //       ],
                        //     ),
                        //     Row(
                        //       mainAxisAlignment:
                        //           MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           "${appLocalizations(context).totalPay} :",
                        //           // style: textTheme.bodyMedium,
                        //         ),
                        //         Text(
                        //           formatCurrency(
                        //               (amount + transactionFee!)
                        //                   .toStringAsFixed(2)),
                        //           // style: textTheme.bodyMedium,
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     appLocalizations(context).transferTo,
                        //     style: textTheme.displayLarge?.copyWith(
                        //         color: Colors.grey,
                        //         fontWeight: FontWeight.normal),
                        //   ),
                        // ),
                        // Hero(
                        //   tag: toAccount!.id,
                        //   child: AccountListItem(
                        //     account: toAccount!,
                        //     showCheckBox: false,
                        //     showPoupMenuBtn: false,
                        //     showSetPrimaryBtnAndAccountStatus: false,
                        //   ),
                        // ),
                        CustomBtn(
                          text: appLocalizations(context).pay,
                          onTap: () async {
                            // Navigator.pushReplacementNamed(context, "/transfersuccess");
                            if (formKey.currentState!.validate()) {
                              // bankAccountListBloc
                              //     .add(GetBankAccountListEvent());
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  // showDragHandle: true,
                                  backgroundColor: isDarkMode
                                      ? themeLogoColorBlue
                                      : Colors.white,
                                  builder: (context) =>
                                      TransactionFeeDetailBottomSheet(
                                        amount: amount,
                                        toAccount: toAccount!,
                                        transferPaymentBloc:
                                            transferPaymentBloc,
                                        txnNote: paymentNoteController.text,
                                        isRequestToPay: args.isRequestToPay,
                                        request: args.request,
                                        isSelfTransfer: args.isSelfTransfer,
                                        receiverType: args.receiverType,
                                        isScanToPay: args.isScanToPay,
                                        isContactPay: args.isContactPay,
                                        isInvoicePay: args.isInvoicePay,
                                        isSubscriptionPay:
                                            args.isSubscriptionPay,
                                        invoiceData: args.invoiceData,
                                        subscriptionData: args.subscriptionData,
                                        isPaymentLinkPay: args.isPaymentLinkPay,
                                        paymentLinkData: args.paymentLinkData,
                                      ));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  void _updateAmount(String p1) {
    {
      try {
        amount = currencyTextInputFormatter.getUnformattedValue().toDouble();
        // amount = double.parse(p1.isNotEmpty
        //     ? p1
        //         .replaceAll(getNumberFormat().symbols.DECIMAL_SEP, ".")
        //         .replaceAll(getNumberFormat().symbols.GROUP_SEP, "")
        //         .replaceAll(RegExp(r"\s+"), "")
        //     : "0.00");
      } catch (e) {
        // showToast(e is FormatException
        //     ? e.message
        //     : e.toString());
        showFailedDialog(
            e is FormatException ? e.message : e.toString(), context);
        amountController.clear();
        amount = 0;
      }
      // if (customerCharge?.transactionFeeType ==
      //     CommisionType.PERCENTAGE) {
      //   transactionFee = amount *
      //       ((customerCharge?.transactionFee ?? 0) /
      //           100);
      // }
      // setState(() {});
    }
  }

  String getImage() {
    var args =
        ModalRoute.of(context)!.settings.arguments as TransactionDetailScreen;
    if (args.isPaymentLinkPay) {
      return "$baseUrlBannerImage${args.paymentLinkData?.bannerImage}";
    } else if (args.isSubscriptionPay) {
      return "$baseUrlProfileImage${args.subscriptionData?.merchantId?.companyLogo}";
    } else if (args.isInvoicePay) {
      return "$baseUrlProfileImage${args.invoiceData?.merchantData?.companyLogo}";
    }
    return "$baseUrlBankLogo${toAccount!.logo}";
  }
}
