import 'dart:async';

import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

enum PayWith { banksAndWallets, card }

class TransactionFeeDetailBottomSheet extends StatefulWidget {
  final double amount;
  final BankAccount toAccount;
  final ApisBloc transferPaymentBloc;
  final String? txnNote;
  final bool isRequestToPay;
  final bool isSelfTransfer;
  final bool isScanToPay;
  final bool isContactPay;
  final bool isInvoicePay;
  final bool isSubscriptionPay;
  final bool isPaymentLinkPay;
  final PaymentRequest? request;
  final String? receiverType;
  final Invoice? invoiceData;
  final Subscriber? subscriptionData;
  final PaymentLinkData? paymentLinkData;

  const TransactionFeeDetailBottomSheet({
    super.key,
    required this.amount,
    required this.toAccount,
    required this.transferPaymentBloc,
    this.txnNote,
    required this.isRequestToPay,
    this.request,
    required this.isSelfTransfer,
    required this.isScanToPay,
    required this.isContactPay,
    required this.isInvoicePay,
    required this.isSubscriptionPay,
    required this.receiverType,
    required this.invoiceData,
    required this.subscriptionData,
    required this.isPaymentLinkPay,
    required this.paymentLinkData,
  });

  @override
  State<TransactionFeeDetailBottomSheet> createState() =>
      _TransactionFeeDetailBottomSheetState();
}

class _TransactionFeeDetailBottomSheetState
    extends State<TransactionFeeDetailBottomSheet> {
  var selectAccountBloc = SelectionBloc(SelectionBlocInitialState());

  // To check status of momo account
  var checkAccountNumberStatusBloc = ApisBloc(ApisBlocInitialState());
  var getTxnFeeBloc = ApisBloc(ApisBlocInitialState());
  double? transactionFee = 0.0;
  var selectPayWithAccountTypeBloc =
      SelectionBloc(SelectPayWithState(PayWith.banksAndWallets));

  // late final BankAccount toAccount;
  BankAccount? fromAccount;

  // AdminList? customerCharge;

  String? selectedPayWithAccountType; //only for orange

  // String senderPaymentTypeForOrange = "MTN Orange";

  var couponCodeController = TextEditingController();

  List<BankAccount> accounts = [];

  PayWith? selectedPayWith;

  var cardListBloc = ApisBloc(ApisBlocInitialState());

  int page = 1;
  int limit = 10;

  CardData? selectedCard;

  var selectCardBloc = SelectionBloc(SelectionBlocInitialState());

  var thirdPartyListBloc = ApisBloc(ApisBlocInitialState());

  bool showEcobankAcc = false;
  bool showMOMOAcc = false;
  bool showOrangeAcc = false;
  bool showCard = false;
  bool showBanksAndWalletsRadioBtn = false;

  List<ThirdPartyListData>? thirdPartyList;

  @override
  void initState() {
    super.initState();
    thirdPartyListBloc.add(GetThirdPartyListEvent());
  }

  bool showThirdParty(
      List<ThirdPartyListData>? thirdPartyListData, String thirdPartyName) {
    List<bool> showEcobankAccList = [];
    List<bool> showMomoAccList = [];
    List<bool> showOrangeAccList = [];
    List<bool> showCardList = [];

    try {
      if (thirdPartyListData != null) {
        for (var item in thirdPartyListData) {
          if (item.thirdParty != null && item.thirdParty is List) {
            for (var thirdParty in item.thirdParty!) {
              showEcobankAccList.add(
                  // thirdParty.language == selectedLanguage &&
                  thirdParty.thirdPartyName == "Ecobank");
              showMomoAccList.add(
                  // thirdParty.language == selectedLanguage &&
                  thirdParty.thirdPartyName == "MTN MOMO");
              showOrangeAccList.add(
                  // thirdParty.language == selectedLanguage &&
                  thirdParty.thirdPartyName == "Orange Money");
              showCardList.add(
                  // thirdParty.language == selectedLanguage &&
                  thirdParty.thirdPartyName == "eFT");

              // if (thirdParty.language == selectedLanguage &&
              //     thirdParty.thirdPartyName == thirdPartyName) {
              //   showEcobankAccList.add(true);
              // }
            }
            showEcobankAcc = showEcobankAccList.contains(true);
            showMOMOAcc = showMomoAccList.contains(true);
            showOrangeAcc = showOrangeAccList.contains(true);
            showCard = showCardList.contains(true);
            showBanksAndWalletsRadioBtn =
                showEcobankAcc || showMOMOAcc || showOrangeAcc;
            selectPayWithAccountTypeBloc.add(SelectPayWithEvent(
                showBanksAndWalletsRadioBtn
                    ? PayWith.banksAndWallets
                    : PayWith.card));
          }
        }
      }
    } catch (e) {
      debugPrint('Error filtering third party: $e');
    }

    return showEcobankAccList.contains(true);
  }

  Future<void> initiateTxn() async {
    bool isOrangeMoneyTxn =
        fromAccount?.bankname?.toLowerCase().contains("orange") ?? false;
    selectedPayWithAccountType = isOrangeMoneyTxn
        ? "MTN Orange"
        : selectedPayWith == PayWith.card
            ? "Card Payment"
            : null;
    if (widget.isInvoicePay) {
      getTxnFeeBloc.add(InitiateC2MInvoiceTxnEvent(
        amount: widget.amount.toStringAsFixed(2),
        senderAccountId: fromAccount?.id,
        receiverAccountId: widget.toAccount.id,
        txnNote: widget.txnNote,
        requestedAmount: widget.isRequestToPay
            ? double.parse(widget.request!.requestedAmount)
            : 0,
        transferType: getTransferType(),
        receiverType: getReceiverType(),
        userType: widget.receiverType,
        merchantId: widget.toAccount.merchantId,
        requestedId: widget.request?.id,
        invoiceNumber: widget.invoiceData?.invoiceNumber,
        couponCode: couponCodeController.text,
        senderPaymentType: selectedPayWithAccountType,
      ));
    } else if (widget.isSubscriptionPay) {
      getTxnFeeBloc.add(InitiateSubscriptionTxnEvent(
        amount: widget.amount.toStringAsFixed(2),
        senderAccountId: fromAccount?.id,
        receiverAccountId: widget.toAccount.id,
        txnNote: widget.txnNote,
        requestedAmount: widget.isRequestToPay
            ? double.parse(widget.request!.requestedAmount)
            : 0,
        transferType: getTransferType(),
        receiverType: getReceiverType(),
        userType: widget.receiverType,
        merchantId: widget.toAccount.merchantId,
        requestedId: widget.request?.id,
        subscription: widget.subscriptionData,
        couponCode: couponCodeController.text,
        senderPaymentType: selectedPayWithAccountType,
      ));
    } else if (widget.isPaymentLinkPay) {
      var payerData = Payerdata(
        email: await SharedPreferenceHelper.getEmail(),
        phoneNumber: await SharedPreferenceHelper.getPhoneCode() +
            await SharedPreferenceHelper.getPhoneNumber(),
        userFullName: await SharedPreferenceHelper.getUserName(),
      );
      var ticketData = widget.paymentLinkData?.slotInfo
          ?.map((e) => TicketData(
                attendees: [
                  payerData,
                ],
                slotId: e.id,
                totalTicket: e.quantity.toString(),
                totalTicketPrice:
                    "${double.parse(e.perSlotPrice ?? "") * e.quantity}",
              ))
          .toList();
      getTxnFeeBloc.add(InitiateTicketTxnEvent(
          body: InitiateTxnBody(
        amount: widget.amount.toStringAsFixed(2),
        senderAccountId: fromAccount?.id,
        receiverAccountId: widget.toAccount.id,
        transactionNote: widget.txnNote,
        // transferType: getTransferType(),
        // receiverType: getReceiverType(),
        userType: widget.receiverType,
        merchantId: widget.toAccount.merchantId,
        couponCode: couponCodeController.text,
        senderPaymentType: selectedPayWithAccountType,
        eventId: widget.paymentLinkData?.id,
        eventRefNumber: widget.paymentLinkData?.eventRefNumber,
        ticketdata: ticketData,
        receiverId: widget.paymentLinkData?.merchantId,
      )));
    } else if (widget.receiverType == "Merchant") {
      getTxnFeeBloc.add(InitiateC2MTxnEvent(
        amount: widget.amount.toStringAsFixed(2),
        senderAccountId: fromAccount?.id,
        receiverAccountId: widget.toAccount.id,
        txnNote: widget.txnNote,
        requestedAmount: widget.isRequestToPay
            ? double.parse(widget.request!.requestedAmount)
            : 0,
        transferType: getTransferType(),
        receiverType: getReceiverType(),
        userType: widget.receiverType,
        merchantId: widget.toAccount.merchantId,
        requestedId: widget.request?.id,
        couponCode: couponCodeController.text,
        senderPaymentType: selectedPayWithAccountType,
      ));
    } else {
      getTxnFeeBloc.add(InitiateTxnEvent(
        amount: widget.amount.toStringAsFixed(2),
        senderAccountId: fromAccount?.id,
        receiverAccountId: widget.toAccount.id,
        txnNote: widget.txnNote,
        requestedAmount: widget.isRequestToPay
            ? double.parse(widget.request!.requestedAmount)
            : 0,
        transferType: getTransferType(),
        receiverType: getReceiverType(),
        userType: widget.receiverType,
        requestedId: widget.request?.id,
        couponCode: couponCodeController.text,
        senderPaymentType: selectedPayWithAccountType,
      ));
    }
  }

  void checkOutTxn(InitiateTxnState txnFeeState) {
    bool isOrangeMoneyTxn =
        fromAccount?.bankname?.toLowerCase().contains("orange") ?? false;
    bool isMOMOTxn =
        fromAccount?.bankname?.toLowerCase().contains("momo") ?? false;
    selectedPayWithAccountType = isOrangeMoneyTxn
        ? "MTN Orange"
        : selectedPayWith == PayWith.card
            ? "Card Payment"
            : null;
    if (widget.isInvoicePay) {
      widget.transferPaymentBloc.add(CheckoutC2MInvoiceTxnEvent(
          receiverAccountId: widget.toAccount.id,
          senderAccountId: fromAccount?.id,
          txnNote: widget.txnNote,
          amount: widget.amount.toStringAsFixed(2),
          transactionRefNumber:
              txnFeeState.value.data?.transactionBctpayRefrenceNumber,
          receiverType: getReceiverType(),
          merchantId: widget.toAccount.merchantId,
          invoiceNumber: widget.invoiceData?.invoiceNumber,
          senderPaymentType: selectedPayWithAccountType,
          returnUrl: isOrangeMoneyTxn ? orangeMoneyReturnUrl : null,
          cancelUrl: isOrangeMoneyTxn ? orangeMoneyCancelUrl : null,
          landingUrl: selectedPayWith == PayWith.card
              ? cardTxnReturnUrl("<paymentId>")
              : null,
          cardId: selectedCard?.cardOnFileId ?? "",
          isMOMOTxn: isMOMOTxn,
          isInvoicePay: true));
    } else if (widget.isSubscriptionPay) {
      widget.transferPaymentBloc.add(CheckoutSubscriptionTxnEvent(
        receiverAccountId: txnFeeState.value.data?.receiver_account_id ?? "",
        senderAccountId: fromAccount?.id,
        txnNote: widget.txnNote,
        amount: widget.amount.toStringAsFixed(2),
        transactionRefNumber:
            txnFeeState.value.data?.transactionBctpayRefrenceNumber,
        receiverType: getReceiverType(),
        merchantId: widget.toAccount.merchantId,
        subscription: widget.subscriptionData,
        senderPaymentType: selectedPayWithAccountType,
        returnUrl: isOrangeMoneyTxn ? orangeMoneyReturnUrl : null,
        cancelUrl: isOrangeMoneyTxn ? orangeMoneyCancelUrl : null,
        landingUrl: selectedPayWith == PayWith.card
            ? cardTxnReturnUrl("<paymentId>")
            : null,
        cardId: selectedCard?.cardOnFileId ?? "",
        isMOMOTxn: isMOMOTxn,
        isSubscriptionPay: true,
      ));
    } else if (widget.isPaymentLinkPay) {
      widget.transferPaymentBloc.add(CheckoutTicketTxnEvent(
        body: CheckoutTxnBody(
          receiverAccountId: txnFeeState.value.data?.receiver_account_id ?? "",
          senderAccountId: fromAccount?.id,
          transactionNote: widget.txnNote,
          senderAmount: widget.amount.toStringAsFixed(2),
          receiverAmount: widget.amount.toStringAsFixed(2),
          // amount: widget.amount.toStringAsFixed(2),
          transactionRefNumber:
              txnFeeState.value.data?.transactionBctpayRefrenceNumber,
          receiverType: getReceiverType(),
          merchantId: widget.toAccount.merchantId,
          // subscriptionId: widget.subscriptionData?.id,
          senderPaymentType: selectedPayWithAccountType,
          returnUrl: isOrangeMoneyTxn ? orangeMoneyReturnUrl : null,
          cancelUrl: isOrangeMoneyTxn ? orangeMoneyCancelUrl : null,
          landingUrl: selectedPayWith == PayWith.card
              ? cardTxnReturnUrl("<paymentId>")
              : null,
          cardId: selectedCard?.cardOnFileId ?? "",
          eventId: widget.paymentLinkData?.id,
          eventRefNumber: widget.paymentLinkData?.eventRefNumber,
          receiverId: widget.paymentLinkData?.merchantId,
        ),
        isMOMOTxn: isMOMOTxn,
        isTicketPay: true,
      ));
    } else if (widget.receiverType == "Merchant") {
      widget.transferPaymentBloc.add(CheckoutC2MTxnEvent(
        receiverAccountId: widget.toAccount.id,
        senderAccountId: fromAccount?.id,
        txnNote: widget.txnNote,
        amount: widget.amount.toStringAsFixed(2),
        transactionRefNumber:
            txnFeeState.value.data?.transactionBctpayRefrenceNumber,
        receiverType: getReceiverType(),
        merchantId: widget.toAccount.merchantId,
        senderPaymentType: selectedPayWithAccountType,
        returnUrl: isOrangeMoneyTxn ? orangeMoneyReturnUrl : null,
        cancelUrl: isOrangeMoneyTxn ? orangeMoneyCancelUrl : null,
        landingUrl: selectedPayWith == PayWith.card
            ? cardTxnReturnUrl("<paymentId>")
            : null,
        cardId: selectedCard?.cardOnFileId ?? "",
        isMOMOTxn: isMOMOTxn,
        isTransfer: true,
      ));
    } else {
      widget.transferPaymentBloc.add(CheckoutTxnEvent(
        receiverAccountId: widget.toAccount.id,
        senderAccountId: fromAccount?.id,
        txnNote: widget.txnNote,
        amount: widget.amount.toStringAsFixed(2),
        transactionRefNumber:
            txnFeeState.value.data?.transactionBctpayRefrenceNumber,
        receiverType: getReceiverType(),
        senderPaymentType: selectedPayWithAccountType,
        returnUrl: isOrangeMoneyTxn ? orangeMoneyReturnUrl : null,
        cancelUrl: isOrangeMoneyTxn ? orangeMoneyCancelUrl : null,
        landingUrl: selectedPayWith == PayWith.card
            ? cardTxnReturnUrl("<paymentId>")
            : null,
        cardId: selectedCard?.cardOnFileId ?? "",
        isMOMOTxn: isMOMOTxn,
        isTransfer: true,
      ));
    }
  }

  void selectFromAccount() {
    if (accounts.isNotEmpty) {
      var primaryAccounts =
          accounts.where((bank) => bank.primaryaccount == "YES");
      if (primaryAccounts.isNotEmpty) {
        fromAccount = primaryAccounts.first;
        selectAccountBloc.add(SelectAccountEvent(fromAccount));
      } else {
        fromAccount = accounts.first;
        selectAccountBloc.add(SelectAccountEvent(fromAccount));
      }
      // if (fromAccount?.bankname?.toLowerCase() ==
      //     'orange money') {
      bool isMOMOTxn =
          fromAccount?.bankname?.toLowerCase().contains("momo") ?? false;
      isMOMOTxn
          ? checkAccountNumberStatusBloc.add(CheckAccountNumberStatusEvent(
              phoneCode:
                  fromAccount?.phoneCode ?? (selectedCountry?.phoneCode ?? ""),
              accountNumber: fromAccount?.accountnumber ?? "",
              institutionName: fromAccount?.bankname ?? "",
              accountType: fromAccount?.accountRole ?? ""))
          : initiateTxn();
    } else {
      debugPrint(appLocalizations(context).noPrimaryAccount);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Wrap(children: [
      Container(
        // height: 430,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // padding: const EdgeInsets.all(10),
          children: [
            // const Spacer(),
            // const SizedBox(
            //   height: 20,
            // ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.clear)),
            ),
            Text(
              appLocalizations(context).paymentDetails,
              style: textTheme.displayLarge?.copyWith(
                // color: titleFontColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${appLocalizations(context).sendingAmount} :",
                      // style: textTheme.bodyMedium,
                    ),
                    Text(
                      formatCurrency(widget.amount.toStringAsFixed(2)),
                      // style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                BlocConsumer(
                    bloc: getTxnFeeBloc,
                    listener: (context, txnFeeState) {
                      // if (txnFeeState is InitiateOrangeTxnState) {
                      //   if (txnFeeState.value.code ==
                      //       HTTPResponseStatusCodes.momoTxnSuccessCode) {
                      //     // transactionFeeConfig(txnFeeState);
                      //     transactionFee = double.parse(
                      //             txnFeeState.value.data?.feeInfo.amount ??
                      //                 "0.00") +
                      //         double.parse(
                      //             txnFeeState.value.data?.feeInfo.amount ??
                      //                 "0.00");
                      //   } else if (txnFeeState.value.code ==
                      //       HTTPResponseStatusCodes.sessionExpireCode) {
                      //     sessionExpired(txnFeeState.value.message, context);
                      //   } else {
                      //     transactionFee = 0.00;
                      //     showFailedDialog(
                      //       txnFeeState.value.message,
                      //       context,
                      //       // dismissOnBackKeyPress: false,
                      //       // dismissOnTouchOutside: false,
                      //       // onTap: () {
                      //       //   Navigator.pop(context);
                      //       //   Navigator.pop(context);
                      //       // },
                      //     );
                      //   }
                      // }
                      if (txnFeeState is InitiateTxnState) {
                        if (txnFeeState.value.code ==
                            HTTPResponseStatusCodes.momoTxnSuccessCode) {
                          // transactionFeeConfig(txnFeeState);
                          transactionFee = double.parse(txnFeeState
                                      .value.data?.paybleCommissionFeeAmount ??
                                  "0.00") +
                              double.parse(txnFeeState
                                      .value.data?.paybleTransactionFeeAmount ??
                                  "0.00");
                        } else if (txnFeeState.value.code ==
                            HTTPResponseStatusCodes.sessionExpireCode) {
                          sessionExpired(txnFeeState.value.message, context);
                        } else {
                          transactionFee = 0.00;
                          showFailedDialog(
                            txnFeeState.value.message,
                            context,
                            // dismissOnBackKeyPress: false,
                            // dismissOnTouchOutside: false,
                            // onTap: () {
                            //   Navigator.pop(context);
                            //   Navigator.pop(context);
                            // },
                          );
                        }
                      }
                      if (txnFeeState is ApisBlocErrorState) {
                        showFailedDialog(
                          txnFeeState.message,
                          context,
                          // dismissOnBackKeyPress: false,
                          // dismissOnTouchOutside: false,
                          // onTap: () {
                          //   Navigator.pop(context);
                          //   Navigator.pop(context);
                          // },
                        );
                      }
                    },
                    builder: (context, bctPaySettingDetailsBlocState) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${appLocalizations(context).fees} :",
                                // style: textTheme.bodyMedium,
                              ),
                              Text(
                                formatCurrency(
                                    transactionFee?.toStringAsFixed(2) ??
                                        "0.00"),
                                // style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${appLocalizations(context).totalAmount} :",
                                // style: textTheme.bodyMedium,
                              ),
                              Text(
                                formatCurrency((widget.amount + transactionFee!)
                                    .toStringAsFixed(2)),
                                // style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ],
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // CustomTextField(
            //   controller: couponCodeController,
            //   labelText: appLocalizations(context).promoCode,
            //   hintText: appLocalizations(context).doYouHaveAPromoCode,
            //   suffix: TextButton(
            //     onPressed: () {
            //       initiateTxn();
            //     },
            //     child: Text(appLocalizations(context).applyCouponCode),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Text(
              appLocalizations(context).payWith,
              style: textTheme.displayLarge?.copyWith(
                // color: titleFontColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer(
                bloc: thirdPartyListBloc,
                listener: (context, state) {
                  if (state is GetThirdPartyListState) {
                    if (state.value.code == 200) {
                      thirdPartyList = state.value.data;
                      bankAccountListBloc.add(GetBankAccountListEvent());
                      cardListBloc
                          .add(GetCardsListEvent(page: page, limit: limit));
                      showThirdParty(thirdPartyList, "Ecobank");
                    } else if (state.value.code ==
                        HTTPResponseStatusCodes.sessionExpireCode) {
                      sessionExpired(state.value.message ?? "", context);
                    } else {
                      showFailedDialog(state.value.message ?? "", context);
                    }
                  }
                },
                builder: (context, state) {
                  if (state is GetThirdPartyListState) {
                    return BlocConsumer(
                        bloc: selectPayWithAccountTypeBloc,
                        listener: (context, state) {
                          if (state is SelectPayWithState) {
                            selectedPayWith = state.value;
                            if (state.value == PayWith.card) {
                              fromAccount = null;
                              initiateTxn();
                            } else {
                              // bankAccountListBloc
                              //     .add(GetBankAccountListEvent());
                              selectFromAccount();
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is SelectPayWithState) {
                            return Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white),
                              child: Row(
                                children: [
                                  if (showBanksAndWalletsRadioBtn)
                                    Expanded(
                                      child: RadioListTile(
                                        groupValue: state.value,
                                        fillColor: WidgetStatePropertyAll(
                                          isDarkMode(context)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          appLocalizations(context)
                                              .banksAndWallets,
                                          style: textTheme.bodyLarge!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.bold),
                                          // style: const TextStyle(color: Colors.white),
                                        ),
                                        value: PayWith.banksAndWallets,
                                        onChanged: (value) {
                                          selectPayWithAccountTypeBloc
                                              .add(SelectPayWithEvent(value!));
                                          banksListBloc.add(GetBanksListEvent(
                                              accountType: "BANK"));
                                        },
                                      ),
                                    ),
                                  if (showCard)
                                    Expanded(
                                      child: RadioListTile(
                                        groupValue: state.value,
                                        fillColor: WidgetStatePropertyAll(
                                          isDarkMode(context)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          appLocalizations(context).card,
                                          style: textTheme.bodyLarge!
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeight.bold),

                                          // style: const TextStyle(color: Colors.white),
                                        ),
                                        value: PayWith.card,
                                        onChanged: (value) {
                                          selectPayWithAccountTypeBloc
                                              .add(SelectPayWithEvent(value!));
                                          banksListBloc.add(GetBanksListEvent(
                                              accountType: "BANK"));
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }
                          return const Loader();
                        });
                  }
                  return Loader();
                }),
            BlocConsumer(
                bloc: thirdPartyListBloc,
                listener: (context, state) {
                  if (state is GetThirdPartyListState) {
                    if (state.value.code == 200) {
                      thirdPartyList = state.value.data;
                      // showThirdParty(thirdPartyList, "Ecobank");
                    } else if (state.value.code ==
                        HTTPResponseStatusCodes.sessionExpireCode) {
                      sessionExpired(state.value.message ?? "", context);
                    } else {
                      showFailedDialog(state.value.message ?? "", context);
                    }
                  }
                },
                builder: (context, state) {
                  if (state is GetThirdPartyListState) {
                    return BlocBuilder(
                        bloc: selectPayWithAccountTypeBloc,
                        // listener: (context, state) {
                        //   if (state is SelectPayWithState) {
                        //     if (state.value == PayWith.card) {
                        //       fromAccount = null;
                        //       initiateTxn();
                        //     } else {
                        //       selectFromAccount();
                        //     }
                        //   }
                        // },
                        builder: (context, selectPayWithAccountTypeState) {
                          if (selectPayWithAccountTypeState
                              is SelectPayWithState) {
                            if (selectPayWithAccountTypeState.value ==
                                PayWith.card) {
                              ///Card selected
                              // return const SizedBox.shrink();
                              return BlocConsumer(
                                  bloc: cardListBloc,
                                  listener: (context, state) {
                                    if (state is GetCardsListState) {
                                      if (state.value.code == 200) {
                                        var cards = state.value.data ?? [];
                                        if (cards.isNotEmpty) {
                                          selectCardBloc.add(
                                              SelectCardEvent(cards.first));
                                        }
                                      } else if (state.value.code ==
                                          HTTPResponseStatusCodes
                                              .sessionExpireCode) {
                                        sessionExpired(
                                            state.value.message ?? "", context);
                                      } else {
                                        showToast(state.value.message ?? "");
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is GetCardsListState) {
                                      var cards = state.value.data ?? [];
                                      if (showCard && cards.isEmpty) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(appLocalizations(context)
                                                .noData),
                                            Text(
                                              appLocalizations(context)
                                                  .ifNotChosenYoullNeedToManuallyEnterYourCardDetailsInTheNextStep,
                                              style: textTheme.bodySmall
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            ),
                                          ],
                                        );
                                      }
                                      return BlocConsumer(
                                          bloc: selectCardBloc,
                                          listener: (context, selectCardstate) {
                                            if (selectCardstate
                                                is SelectCardState) {
                                              selectedCard =
                                                  selectCardstate.value;
                                              initiateTxn();
                                            }
                                          },
                                          builder: (context, selectCardstate) {
                                            return Card(
                                              color: Colors.white,
                                              child: DropdownButton(
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          appLocalizations(
                                                                  context)
                                                              .selectCard,
                                                          style: textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Text(
                                                          appLocalizations(
                                                                  context)
                                                              .ifNotChosenYoullNeedToManuallyEnterYourCardDetailsInTheNextStep,
                                                          style: textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  value: selectedCard,
                                                  isExpanded: true,
                                                  itemHeight: 85,
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  underline: const SizedBox(),
                                                  icon: const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Icon(
                                                        Icons.arrow_drop_down),
                                                  ),
                                                  items: cards
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                              value: e,
                                                              child:
                                                                  CardListItem(
                                                                card: e,
                                                                elevation: 0,
                                                                leadingDimension:
                                                                    50,
                                                                showActiveInactiveStatus:
                                                                    false,
                                                              )))
                                                      .toList(),
                                                  onChanged: (v) {
                                                    selectCardBloc.add(
                                                        SelectCardEvent(v));
                                                  }),
                                            );
                                          });
                                    }
                                    return Loader();
                                  });
                            }

                            ///Banks and Wallet selected
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocConsumer(
                                    bloc: bankAccountListBloc,
                                    listener: (context, bankAccountListState) {
                                      if (bankAccountListState
                                          is GetBankAccountListState) {
                                        if (bankAccountListState.value.code ==
                                            200) {
                                          accounts =
                                              bankAccountListState.value.data ??
                                                  [];
                                          accounts = accounts
                                              .where((account) =>
                                                  account.id !=
                                                      widget.toAccount.id &&
                                                  account.accountstatus != "0")
                                              .toList();
                                          accounts = accounts
                                              .where((e) =>
                                                  (showMOMOAcc &&
                                                      e.bankname ==
                                                          "MTN MOMO") ||
                                                  (showEcobankAcc &&
                                                      e.bankname ==
                                                          "Ecobank") ||
                                                  (showOrangeAcc &&
                                                      e.bankname ==
                                                          "Orange Money"))
                                              .toList();
                                          selectFromAccount();
                                        } else if (bankAccountListState
                                                .value.code ==
                                            HTTPResponseStatusCodes
                                                .sessionExpireCode) {
                                          sessionExpired(
                                              bankAccountListState
                                                  .value.message,
                                              context);
                                        }
                                      }
                                    },
                                    builder: (context, bankAccountListState) {
                                      if (bankAccountListState
                                          is GetBankAccountListState) {
                                        accounts =
                                            bankAccountListState.value.data ??
                                                [];
                                        accounts = accounts
                                            .where((account) =>
                                                account.id !=
                                                    widget.toAccount.id &&
                                                account.accountstatus != "0")
                                            .toList();
                                        accounts = accounts
                                            .where((e) =>
                                                (showMOMOAcc &&
                                                    e.bankname == "MTN MOMO") ||
                                                (showEcobankAcc &&
                                                    e.bankname == "Ecobank") ||
                                                (showOrangeAcc &&
                                                    e.bankname ==
                                                        "Orange Money"))
                                            .toList();
                                        if (accounts.isEmpty) {
                                          return Text(appLocalizations(context)
                                              .noAccount);
                                        }
                                        return BlocConsumer(
                                          bloc: checkAccountNumberStatusBloc,
                                          listener:
                                              (context, accountStatusState) {
                                            if (accountStatusState
                                                is CheckAccountNumberStatusState) {
                                              if (accountStatusState
                                                      .value.code ==
                                                  200) {
                                                initiateTxn();
                                              } else if (accountStatusState
                                                      .value.code ==
                                                  HTTPResponseStatusCodes
                                                      .sessionExpireCode) {
                                                sessionExpired(
                                                    bankAccountListState
                                                        .value.message,
                                                    context);
                                              }
                                            }

                                            if (accountStatusState
                                                is ApisBlocErrorState) {
                                              showFailedDialog(
                                                  accountStatusState.message,
                                                  context);
                                              getTxnFeeBloc = ApisBloc(
                                                  ApisBlocInitialState());
                                            }
                                          },
                                          builder:
                                              (context, accountStatusState) {
                                            return BlocConsumer(
                                                bloc: selectAccountBloc,
                                                listener: (context,
                                                    selectAccountstate) {
                                                  if (selectAccountstate
                                                      is SelectAccountState) {
                                                    fromAccount =
                                                        selectAccountstate
                                                            .account;
                                                    // bctPaySettingDetailsBloc.add(
                                                    //     GetBCTPaySettingDetailsEvent(
                                                    //         countryId: selectedCountry.id));

                                                    getTxnFeeBloc.add(
                                                        ApisBlocInitialEvent());
                                                    bool isMOMOTxn = fromAccount
                                                            ?.bankname
                                                            ?.toLowerCase()
                                                            .contains("momo") ??
                                                        false;
                                                    isMOMOTxn
                                                        ? checkAccountNumberStatusBloc.add(CheckAccountNumberStatusEvent(
                                                            phoneCode: fromAccount
                                                                    ?.phoneCode ??
                                                                (selectedCountry
                                                                        ?.phoneCode ??
                                                                    ""),
                                                            accountNumber:
                                                                fromAccount
                                                                        ?.accountnumber ??
                                                                    "",
                                                            institutionName:
                                                                fromAccount
                                                                        ?.bankname ??
                                                                    "",
                                                            accountType: fromAccount
                                                                    ?.accountRole ??
                                                                ""))
                                                        : initiateTxn();
                                                  }
                                                },
                                                builder: (context,
                                                    selectAccountstate) {
                                                  if (selectAccountstate
                                                      is SelectAccountState) {
                                                    return Card(
                                                      color: Colors.white,
                                                      child: DropdownButton(
                                                        // dropdownColor:
                                                        //     Colors.white,s
                                                        isExpanded: true,
                                                        iconEnabledColor:
                                                            Colors.black,
                                                        icon: const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Icon(Icons
                                                              .arrow_drop_down),
                                                        ),
                                                        value:
                                                            selectAccountstate
                                                                .account,
                                                        onChanged: (value) {
                                                          fromAccount = value;
                                                          selectAccountBloc.add(
                                                              SelectAccountEvent(
                                                                  value));
                                                        },
                                                        underline:
                                                            const SizedBox(),
                                                        itemHeight: 80,
                                                        items: accounts
                                                            .map((e) =>
                                                                DropdownMenuItem(
                                                                  value: e,
                                                                  child:
                                                                      AccountListItem(
                                                                    account: e,
                                                                    showCheckBox:
                                                                        false,
                                                                    showPoupMenuBtn:
                                                                        false,
                                                                    showSetPrimaryBtnAndAccountStatus:
                                                                        false,
                                                                    elevation:
                                                                        0,
                                                                    leadingDimension:
                                                                        50,
                                                                    onTap: null,
                                                                  ),
                                                                ))
                                                            .toList(),
                                                      ),
                                                    );
                                                  }
                                                  return const Loader();
                                                });
                                          },
                                        );
                                      }
                                      return const Loader();
                                    }),
                              ],
                            );
                          }
                          return const Loader();
                        });
                  }
                  return Loader();
                }),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder(
                bloc: getTxnFeeBloc,
                builder: (context, txnFeeState) {
                  if (txnFeeState is InitiateTxnState) {
                    return CustomBtn(
                      text: appLocalizations(context).proceedToPay,
                      maxWidth: width,
                      onTap: txnFeeState.value.code !=
                              HTTPResponseStatusCodes
                                  .momoAccountStatusSuccessCode
                          ? null
                          : () {
                              // if (fromAccount == null) {
                              //   showToast(
                              //       appLocalizations(context).selectAccount);
                              // } else {
                              checkOutTxn(txnFeeState);
                              Navigator.pop(context);
                              // }
                            },
                    );
                  }
                  // if (txnFeeState is InitiateOrangeTxnState) {
                  //   return CustomBtn(
                  //     text: appLocalizations(context).proceedToPay,
                  //     maxWidth: width,
                  //     onTap: txnFeeState.value.code !=
                  //             HTTPResponseStatusCodes
                  //                 .momoAccountStatusSuccessCode
                  //         ? null
                  //         : () {
                  //             if (fromAccount == null) {
                  //               showToast(
                  //                   appLocalizations(context).selectAccount);
                  //             } else {
                  //               Navigator.of(context).pushNamed(
                  //                   AppRoutes.webview,
                  //                   arguments: CustomWebView(
                  //                     url: txnFeeState.value.data?.paymentUrl,
                  //                   ));
                  //             }
                  //           },
                  //   );
                  // }
                  return CustomBtn(
                    text: appLocalizations(context).proceedToPay,
                    maxWidth: width,
                  );
                }),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    ]);
  }

  String getReceiverType() => widget.isContactPay
      ? "CONTACT"
      : widget.isRequestToPay
          ? "REQUESTED"
          : widget.isInvoicePay && widget.isScanToPay
              ? "INVOICE_PAYMENT"
              : widget.isScanToPay
                  ? "QR_SCAN"
                  : widget.isSelfTransfer
                      ? "TO SELF TRANSFER"
                      : widget.isInvoicePay
                          ? "INVOICE_PAYMENT"
                          : widget.isSubscriptionPay
                              ? "SUBSCRIPTION_PAYMENT"
                              : "BENEFICIARY";

  String getTransferType() => widget.isContactPay
      ? "CONTACT"
      : widget.isRequestToPay
          ? "REQUEST TO PAY"
          : widget.isInvoicePay && widget.isScanToPay
              ? "INVOICE_QR_PAYMENT" //INVOICE_QR_PAYMENT
              : widget.isScanToPay
                  ? "QR_SCAN"
                  : widget.isSelfTransfer
                      ? "TO SELF TRANSFER"
                      : widget.isInvoicePay
                          ? "INVOICE_PAYMENT"
                          : widget.isSubscriptionPay
                              ? "SUBSCRIPTION_PAYMENT"
                              : "BENEFICIARY TRANSFER";
}
