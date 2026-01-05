import 'dart:io';

import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class InvoiceDetail extends StatefulWidget {
  final InvoiceData? invoiceData;
  final bool isScanToPay;

  const InvoiceDetail({super.key, this.invoiceData, this.isScanToPay = false});

  @override
  State<InvoiceDetail> createState() => _InvoiceDetailState();
}

class _InvoiceDetailState extends State<InvoiceDetail> {
  final invoiceBloc = ApisBloc(ApisBlocInitialState());

  var screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      var args = ModalRoute.of(context)?.settings.arguments as InvoiceDetail;
      invoiceBloc.add(InvoiceDetailEvent(
          invoiceNumber:
              args.invoiceData?.invoiceDetails?.invoiceNumber ?? ""));
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as InvoiceDetail;
    var invoice = args.invoiceData?.invoiceDetails;
    var transactionDetails = args.invoiceData?.transactionDetails;
    return Scaffold(
      appBar: CustomAppBar(
        title:
            "${appLocalizations(context).invoice} #${invoice?.invoiceNumber ?? ""}",
        actions: [
          if (transactionDetails != null)
            IconButton(
              onPressed: () {
                var txnData =
                    transactionDetails.copyWith(invoiceDetails: invoice);
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (context) => ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return TransactionListItem(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.transactionHistoryDetail,
                                arguments: TransactionHistoryDetail(
                                  transaction: txnData,
                                ),
                              );
                            },
                            transaction: txnData);
                      }),
                );
              },
              icon: Image.asset(
                Assets.assetsImagesHistory,
                scale: 4,
                color: Colors.white,
              ),
            )
        ],
      ),
      bottomNavigationBar: BlocBuilder(
          bloc: invoiceBloc,
          builder: (context, state) {
            if (state is InvoiceDetailState) {
              var invoiceDetailData = state.value.data;
              var invoiceData = invoiceDetailData?.invoiceData;
              return Container(
                height: 80,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatCurrency(invoiceData?.totalAmount ?? "0.00"),
                      style: textTheme(context).headlineMedium!.copyWith(
                          color: themeLogoColorOrange,
                          fontWeight: FontWeight.bold),
                    ),
                    if (invoiceData?.paymentStatus != "PAID") ...[
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    invoiceData?.paymentStatus == "PAID"
                                        ? Colors.green
                                        : themeLogoColorOrange),
                            onPressed: () {
                              if (invoiceData?.paymentStatus == "PAID") {
                                showToast(appLocalizations(context)
                                    .alreadyPaidInvoice);
                              } else if (invoiceDetailData?.receiverAccount !=
                                  null) {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.transactiondetail,
                                  arguments: TransactionDetailScreen(
                                    toAccount:
                                        invoiceDetailData?.receiverAccount,
                                    receiverType: "Merchant",
                                    isInvoicePay: true,
                                    isScanToPay: args.isScanToPay,
                                    invoiceData: invoiceData,
                                  ),
                                );
                              } else {
                                showToast(appLocalizations(context).noAccount);
                              }
                            },
                            child: Text(
                              invoiceData?.paymentStatus == "PAID"
                                  ? appLocalizations(context).paid
                                  : appLocalizations(context).pay,
                              style: textTheme(context).labelLarge!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ],
                ),
              );
            }
            return const Loader();
          }),
      body: BlocConsumer(
        bloc: invoiceBloc,
        listener: (context, state) {
          if (state is InvoiceDetailState) {
            var statusCode = state.value.code;
            if (statusCode == 200) {
            } else if (statusCode ==
                HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(state.value.message, context);
            } else {
              showFailedDialog(state.value.message, context);
            }
          }
        },
        builder: (context, state) {
          if (state is InvoiceDetailState) {
            var invoiceDetailData = state.value.data;
            var invoiceData = invoiceDetailData?.invoiceData;
            return ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const SizedBox(
                  height: 10,
                ),
                UserInfoView(
                  user: invoiceData?.merchantData,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${appLocalizations(context).issuedOn}:",
                            style: textTheme(context)
                                .bodySmall!
                                .copyWith(color: Colors.grey),
                          ),
                          Text(invoiceData?.createdAt.formattedDate() ?? ""),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${appLocalizations(context).dueOn}:",
                            style: textTheme(context)
                                .bodySmall!
                                .copyWith(color: Colors.grey),
                          ),
                          Text(invoiceData?.dueDate.formattedDate() ?? ""),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  initiallyExpanded: true,
                  title: Text(
                    appLocalizations(context).invoiceItems,
                    style: textTheme(context).titleMedium,
                  ),
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: invoiceData?.productInfo.length,
                      itemBuilder: (context, index) => ProductView(
                          productInfo: invoiceData?.productInfo[index]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  initiallyExpanded: true,
                  title: Text(
                    appLocalizations(context).total,
                    style: textTheme(context).titleMedium,
                  ),
                  children: [
                    Card(
                      color:
                          isDarkMode(context) ? themeColorHeader : Colors.white,
                      margin: const EdgeInsets.all(5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ///discount
                            if (invoiceData?.discountValue != null &&
                                (double.tryParse(invoiceData?.discountValue ??
                                            "0") ??
                                        0) >
                                    0)
                              ProductRow(
                                  subtitle:
                                      "${appLocalizations(context).discountInvoice} (${invoiceData?.discountValue}%): ",
                                  value:
                                      "- ${formatCurrency(getDiscountPrice(invoiceData))}"),

                            ///gross total
                            ProductRow(
                                subtitle:
                                    "${appLocalizations(context).grossTotal} : ",
                                value: formatCurrency(
                                    invoiceData?.totalGross ?? "0.00")),

                            ///total tax %
                            if (isTaxVisible(invoiceData))
                              ProductRow(
                                  subtitle:
                                      "${appLocalizations(context).tax} (%) : ",
                                  value: invoiceData?.totalTax ?? "0"),

                            ///total tax
                            ProductRow(
                                subtitle:
                                    "${appLocalizations(context).totalTaxAmount} : ",
                                value:
                                    "+ ${formatCurrency(getTotalTaxAmount(invoiceData))}"),

                            ///Total amount
                            ProductRow(
                                subtitle:
                                    "${appLocalizations(context).totalAmount} : ",
                                value: formatCurrency(
                                    invoiceData?.totalAmount ?? "0.00")),
                            if (invoiceData?.paymentStatus.toLowerCase() ==
                                "paid")
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${appLocalizations(context).paymentStatus} : ",
                                    style: textTheme(context)
                                        .bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                  PaymentStatusView(
                                    paymentStatus: invoiceData?.paymentStatus,
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          color: isDarkMode(context)
                              ? themeLogoColorBlue
                              : Colors.white,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              QRCodeViewWidget(
                                qrCodeString: invoice?.paymentLink ?? "",
                                logo: invoice?.merchantData?.companyLogo
                                            ?.isNotEmpty ??
                                        false
                                    ? "$baseUrlProfileImage${invoice?.merchantData?.companyLogo}"
                                    : null,
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton.icon(
                              onPressed: () async {
                                screenshotController
                                    .captureFromWidget(
                                        buildInvoiceQRScreenshot(
                                            context: context,
                                            invoice: invoiceData),
                                        context: context)
                                    .then((image) async {
                                  DocumentFileSavePlus()
                                      .saveFile(
                                          image,
                                          "INVOICE_${invoiceData?.invoiceNumber}_${DateTime.now()}.png",
                                          "appliation/png")
                                      .whenComplete(() {
                                    if (!context.mounted) return;
                                    showToast(appLocalizations(context)
                                        .fileDownloaded);
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.file_download_outlined,
                              ),
                              label: Text(
                                AppLocalizations.of(context)!.download,
                              )),
                          OutlinedButton.icon(
                              onPressed: () {
                                screenshotController
                                    .captureFromWidget(
                                        buildInvoiceQRScreenshot(
                                            context: context,
                                            invoice: invoiceData),
                                        context: context)
                                    .then((image) async {
                                  final directory =
                                      await getApplicationDocumentsDirectory();
                                  final pathOfImage = await File(
                                          '${directory.path}/INVOICE_${invoiceData?.invoiceNumber}_${DateTime.now()}.png')
                                      .create();
                                  await pathOfImage
                                      .writeAsBytes(image.toList())
                                      .then((value) => SharePlus.instance.share(
                                          ShareParams(
                                              files: [XFile(value.path)])));
                                });
                              },
                              icon: const Icon(
                                Icons.share,
                              ),
                              label: Text(
                                AppLocalizations.of(context)!.share,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                if (invoiceData?.invoiveNote?.isNotEmpty ?? false)
                  Text(
                    "${appLocalizations(context).invoiceNote} : ${invoiceData?.invoiveNote ?? ""}",
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (invoiceData?.invoiceTnc?.isNotEmpty ?? false)
                  Text(
                    "${appLocalizations(context).invoiceTNC} : ${invoiceData?.invoiceTnc ?? ""}",
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
              ],
            );
          }
          return const Loader();
        },
      ),
    );
  }

  String getTotalTaxAmount(Invoice? invoiceData) {
    double totalTaxAmount = 0;
    if (invoiceData?.productInfo != null) {
      var discountPer = double.tryParse(invoiceData?.discountValue ?? "0") ?? 0;
      for (var product in invoiceData!.productInfo) {
        var totalProductsPrice =
            (double.tryParse(product.productPrice?.toStringAsFixed(2) ?? "0") ??
                    0) *
                (product.productQuantity);
        var discountVal = (totalProductsPrice * discountPer) / 100;
        totalTaxAmount = totalTaxAmount +
            ((totalProductsPrice - discountVal) *
                    (double.tryParse(product.productTax) ?? 0)) /
                100;
      }
    }
    var tGross = double.tryParse(invoiceData?.totalGross ?? "0.0") ?? 0.0;
    var tTax = double.tryParse(invoiceData?.totalTax ?? "0.0") ?? 0.0;
    if (tTax != 0.0) {
      totalTaxAmount = (tGross * tTax) / 100;
    }
    return totalTaxAmount.toStringAsFixed(2);
  }

  String getDiscountPrice(Invoice? invoiceData) {
    double totalDiscountInPercent =
        double.tryParse(invoiceData?.discountValue ?? "0.00") ?? 0.00;
    double discountPrice = 0.0;
    if (invoiceData?.productInfo.isNotEmpty ?? false) {
      for (var e in invoiceData!.productInfo) {
        double unitPrice = e.productPrice?.toDouble() ?? 0.0;
        double qty = e.productQuantity.toDouble();
        discountPrice += ((unitPrice * totalDiscountInPercent) / 100) * qty;
      }
    }
    return discountPrice.toStringAsFixed(2);
  }

  bool isTaxVisible(Invoice? invoiceData) {
    int taxCount = 0;
    if (invoiceData?.productInfo != null) {
      for (var product in invoiceData!.productInfo) {
        var tax = double.tryParse(product.productTax) ?? 0;
        if (tax != 0) {
          taxCount += 1;
        }
      }
    }
    return taxCount != 0 ? false : true;
  }
}
