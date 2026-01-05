import 'dart:io';

import 'package:bctpay/globals/index.dart';

class TransactionHistoryDetail extends StatefulWidget {
  final TransactionData? transaction;
  final bool isFromVerify;

  const TransactionHistoryDetail(
      {super.key, this.transaction, this.isFromVerify = false});

  @override
  State<TransactionHistoryDetail> createState() =>
      _TransactionHistoryDetailState();
}

class _TransactionHistoryDetailState extends State<TransactionHistoryDetail> {
  ScreenshotController screenshotController = ScreenshotController();
  var color = Colors.white70;
  double titleFontSize = 11;

  final accVisiblityBloc = SelectionBloc(SelectBoolState(true));
  final accVisiblityBloc1 = SelectionBloc(SelectBoolState(true));
  final txnDetailBloc = ApisBloc(ApisBlocInitialState());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as TransactionHistoryDetail;
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    width = MediaQuery.of(context).size.width;
    var txn = args.transaction;
    var txnDetails = txn?.details;
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).transactionDetails),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: FutureBuilder(
            future: SharedPreferenceHelper.getUserId(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userId = snapshot.data;
                bool isReceivedTxn =
                    args.transaction?.details.receiverId == userId;
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Screenshot(
                      controller: screenshotController,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        color: isDarkMode ? themeLogoColorBlue : Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isReceivedTxn
                                  ? appLocalizations(context).sentFrom
                                  : appLocalizations(context).paidTo,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TransactionListItem(
                              transaction: args.transaction!,
                              showImage: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appLocalizations(context).transactionId,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: isDarkMode
                                            ? themeGreyColor
                                            : themeGreyColor,
                                        fontSize: titleFontSize,
                                      ),
                                    ),
                                    Text(
                                      args.transaction!.details
                                          .transactionBctpayRefrenceNumber,
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                              text: args.transaction!.details
                                                  .transactionBctpayRefrenceNumber))
                                          .whenComplete(() {
                                        if (!context.mounted) return;
                                        showToast(
                                            appLocalizations(context).copied);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.file_copy_outlined,
                                      size: 20,
                                    ))
                              ],
                            ),
                            //Event ticket count showing here
                            if (txnDetails?.ticketdata?.isNotEmpty ?? false)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${appLocalizations(context).ticketCount} :",
                                  ),
                                  Text(
                                    "${txnDetails?.ticketdata?.first.totalTicket} (${txnDetails?.ticketdata?.first.totalTicketVerified ?? 0} ${appLocalizations(context).verified})",
                                  )
                                ],
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (!isReceivedTxn)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${appLocalizations(context).sendingAmount} :",
                                  ),
                                  Text(
                                    formatCurrency(
                                        args.transaction!.details.senderAmount),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 2,
                            ),
                            if (!isReceivedTxn)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${appLocalizations(context).fees} :",
                                  ),
                                  Text(
                                    formatCurrency(
                                        "${double.parse(args.transaction!.details.paybleCommissionFeeAmount) + double.parse(args.transaction!.details.paybleTransactionFeeAmount)}"),
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
                                ),
                                Text(
                                  formatCurrency(!isReceivedTxn
                                      ? args.transaction!.details
                                          .paybleTotalAmount
                                      : args.transaction?.details
                                              .receiverAmount ??
                                          "0.00"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appLocalizations(context).paymentDate,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: titleFontSize,
                                      ),
                                    ),
                                    Text(args.transaction!.details.createdAt
                                        .formattedDateTime()),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      appLocalizations(context).paymentMethod,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: titleFontSize,
                                      ),
                                    ),
                                    Text(
                                      args.transaction!.details
                                          .transactionFeeServiceType,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${appLocalizations(context).transactionType} : ",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : themeGreyColor,
                                    ),
                                  ),
                                  Text(
                                    args.transaction!.details.transactionType,
                                  ),
                                ]),
                            10.height,

                            if (args.transaction!.details.transactionNote
                                    ?.isNotEmpty ??
                                false) ...[
                              Text(
                                "${appLocalizations(context).paymentNote} : ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: titleFontSize,
                                ),
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        args.transaction!.details
                                                .transactionNote ??
                                            "",
                                        softWrap: true,
                                      ),
                                    ),
                                  ]),
                              10.height,
                            ],

                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${appLocalizations(context).debitedFrom} : ",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : themeGreyColor,
                                    ),
                                  ),
                                  BlocBuilder(
                                      bloc: accVisiblityBloc,
                                      builder: (context, pwdVisiblityState) {
                                        if (pwdVisiblityState
                                            is SelectBoolState) {
                                          return Row(
                                            children: [
                                              Text(args.transaction!.details
                                                  .senderAccountType),
                                              10.width,
                                              Text(
                                                pwdVisiblityState.value
                                                    ? args.transaction!.details
                                                        .senderAccountNumber
                                                        .showLast4HideAll()
                                                        .replaceAll("+", "")
                                                    : args.transaction!.details
                                                        .senderAccountNumber,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  accVisiblityBloc.add(
                                                      SelectBoolEvent(
                                                          !pwdVisiblityState
                                                              .value));
                                                },
                                                child: Icon(
                                                  pwdVisiblityState.value
                                                      ? Icons.remove_red_eye
                                                      : Icons
                                                          .remove_red_eye_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return const Loader();
                                      }),
                                ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${appLocalizations(context).receivedInto} : ",
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : themeGreyColor,
                                    ),
                                  ),
                                  BlocBuilder(
                                      bloc: accVisiblityBloc1,
                                      builder: (context, pwdVisiblityState) {
                                        if (pwdVisiblityState
                                            is SelectBoolState) {
                                          return Row(
                                            children: [
                                              Text(args.transaction!.details
                                                  .receiverAccountType),
                                              10.width,
                                              Text(
                                                pwdVisiblityState.value
                                                    ? args.transaction!.details
                                                        .receiverAccountNumber
                                                        .showLast4HideAll()
                                                        .replaceAll("+", "")
                                                    : args.transaction!.details
                                                        .receiverAccountNumber,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  accVisiblityBloc1.add(
                                                      SelectBoolEvent(
                                                          !pwdVisiblityState
                                                              .value));
                                                },
                                                child: Icon(
                                                  pwdVisiblityState.value
                                                      ? Icons.remove_red_eye
                                                      : Icons
                                                          .remove_red_eye_outlined,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return const Loader();
                                      }),
                                ]),

                            if (args.transaction?.subscriptionDetails != null)
                              _buildSubscriptionDetail(
                                  args.transaction?.details,
                                  args.transaction?.subscriptionDetails),

                            if (args.transaction?.invoiceDetails != null)
                              _buildInvoiceDetail(args.transaction),

                            if (args.transaction?.details.eventdata != null)
                              _buildPaymentLinkDetail(args.transaction),

                            const SizedBox(
                              height: 20,
                            ),
                            if (txn?.details.qrCodeLink != null)
                              QRCodeViewWidget(
                                qrCodeString: txn?.details.qrCodeLink ?? "",
                                logo:
                                    "$baseUrlProfileImage${getQRLogo(txn, isReceivedTxn)}",
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            screenshotController
                                .captureFromWidget(
                                    buildTxnQRScreenshot(
                                      transaction: args.transaction,
                                      userId: userId,
                                      context: context,
                                    ),
                                    context: context)
                                .then((image) {
                              DocumentFileSavePlus()
                                  .saveFile(
                                      image,
                                      "BCTPay_TXN_${args.transaction?.details.transactionBctpayRefrenceNumber}_${DateTime.now()}.png",
                                      "appliation/png")
                                  .whenComplete(() {
                                if (!context.mounted) return;
                                showToast(
                                    appLocalizations(context).fileDownloaded);
                              });
                            });
                          },
                          label: Text(appLocalizations(context).download),
                          icon: const Icon(Icons.save_alt),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final directory =
                                await getApplicationDocumentsDirectory();
                            final pathOfImage = await File(
                                    '${directory.path}/BCTPay_TXN_${args.transaction?.details.transactionBctpayRefrenceNumber}_${DateTime.now()}.png')
                                .create();
                            if (!context.mounted) return;
                            screenshotController
                                .captureFromWidget(
                                    buildTxnQRScreenshot(
                                      transaction: args.transaction,
                                      userId: userId,
                                      context: context,
                                    ),
                                    context: context)
                                .then((image) async {
                              await pathOfImage
                                  .writeAsBytes(image.toList())
                                  .then((value) => SharePlus.instance.share(
                                      ShareParams(files: [XFile(value.path)])));
                            });
                          },
                          label: Text(appLocalizations(context).share),
                          icon: const Icon(Icons.share),
                        ),
                      ],
                    ),
                    20.height,
                    if (args.isFromVerify)
                      txnDetails?.cVerifyStatus == "1"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                Text(
                                  appLocalizations(context).verified,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                          color: Colors.green,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18),
                                )
                              ],
                            )
                          : Align(
                              alignment: Alignment.center,
                              child: CustomBtn(
                                text: appLocalizations(context).verify,
                                onTap: () async {
                                  txnDetailBloc.add(VerifyTxnQREvent(
                                      qrCode: txnDetails?.qrCode ?? "",
                                      type: txnDetails?.transactionType ?? ""));
                                },
                              ),
                            ),
                  ],
                );
              }
              return const Loader();
            }),
      ),
    );
  }

  ExpansionTile _buildSubscriptionDetail(
          Transaction? txn, Subscriber? subscriber) =>
      ExpansionTile(
        initiallyExpanded: true,
        tilePadding: EdgeInsets.zero,
        title: Text(
          appLocalizations(context).subscriptionDetails,
          style: textTheme(context).bodyMedium,
        ),
        subtitle: Text(
          "${appLocalizations(context).referenceID} (#${subscriber?.subscriberId})",
          style: textTheme(context).headlineLarge,
        ),
        children: txn?.planInfo
                ?.where((e) =>
                    e.planStatus == "true" &&
                    (e.paymentStatus?.toLowerCase() == "paid" ||
                        e.paymentStatus?.toLowerCase() == "partially paid"))
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              e.plansDurations ?? "",
                              style: textTheme(context)
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(formatCurrency(e.paidAmount ?? "0")),
                        ],
                      ),
                    ))
                .toList() ??
            [],
      );

  ExpansionTile _buildInvoiceDetail(TransactionData? txnData) => ExpansionTile(
        initiallyExpanded: true,
        tilePadding: EdgeInsets.zero,
        title: Text(
          appLocalizations(context).invoiceDetail,
          style: textTheme(context).bodyMedium,
        ),
        subtitle: Text(
          "${appLocalizations(context).referenceID} (#${txnData?.invoiceDetails?.invoiceNumber})",
          style: textTheme(context).headlineLarge,
        ),
        children: txnData?.invoiceDetails?.productInfo
                .map((e) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.invoiceDetail,
                            arguments: InvoiceDetail(
                              invoiceData: InvoiceData(
                                  invoiceDetails: txnData.invoiceDetails,
                                  transactionDetails: txnData),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                selectedLanguage == "en"
                                    ? e.productNameEn ?? ""
                                    : e.productNameGn ?? "",
                                style: textTheme(context)
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(formatCurrency(
                                e.totalProductPrice?.toStringAsFixed(2) ??
                                    "0")),
                          ],
                        ),
                      ),
                    ))
                .toList() ??
            [],
      );

  ExpansionTile _buildPaymentLinkDetail(TransactionData? txnData) {
    var eventdata = txnData?.details.eventdata;
    return ExpansionTile(
      initiallyExpanded: true,
      tilePadding: EdgeInsets.zero,
      title: Text(
        appLocalizations(context).eventDetails,
        style: textTheme(context).bodyMedium,
      ),
      subtitle: Text(
        "${appLocalizations(context).referenceID} (${eventdata?.eventRefNumber})",
        style: textTheme(context).headlineLarge,
      ),
      children: eventdata?.slotInfo
              ?.map((e) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.paymentLinkScreen,
                          arguments: PaymentLinkScreen(
                            paymentLinkData: eventdata,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedLanguage == "en"
                                  ? e.slotTypeEn ?? ""
                                  : e.slotTypeGn ?? "",
                              style: textTheme(context)
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(formatCurrency(e.perSlotPrice ?? "0")),
                        ],
                      ),
                    ),
                  ))
              .toList() ??
          [],
    );
  }
}

String? getQRLogo(TransactionData? txn, bool isReceivedTxn) {
  var logo = !isReceivedTxn
      ? txn?.receiverDetails?.receiverLogo
      : txn?.senderDetails?.senderLogo;
  return ((logo?.isNotEmpty ?? false) &&
          txn?.details.transferType?.toLowerCase() != "c2c")
      ? logo
      : txn?.wlLogo;
}
