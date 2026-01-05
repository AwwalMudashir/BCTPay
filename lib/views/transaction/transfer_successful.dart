import 'dart:io';

import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:lottie/lottie.dart';

void showSuccessTxnDialog(InitiateTransactionResponse txnResponse, context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: themeColorHeader.withValues(alpha: 0.9),
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TransferSuccessfullScreen(
        txnResponse: txnResponse,
      ),
    ),
  );
}

class TransferSuccessfullScreen extends StatelessWidget {
  final InitiateTransactionResponse? txnResponse;

  TransferSuccessfullScreen({
    super.key,
    this.txnResponse,
  });

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return _downloadAndShareReciptView(
      context,
    );
  }

  Material _downloadAndShareReciptView(
    BuildContext context, {
    bool showDownloadAndShareBtn = true,
  }) {
    var textTheme = Theme.of(context).textTheme;
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var txnData = txnResponse?.data;
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 530,
                margin: EdgeInsets.only(top: 100),
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? themeLogoColorBlue : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.height,
                    Screenshot(
                      controller: screenshotController,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: isDarkMode ? themeLogoColorBlue : Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${appLocalizations(context).dialogTitleSuccess}!",
                                style: textTheme.headlineLarge,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    "${appLocalizations(context).yourPaymentOf} ",
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: formatCurrency(
                                          txnData?.senderAmount ?? "0"),
                                      style: textTheme.headlineLarge?.copyWith(
                                        color: themeLogoColorOrange,
                                        fontSize: 14,
                                      )),
                                  TextSpan(
                                      text:
                                          " ${appLocalizations(context).hasBeenSentSuccessfully}"),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${appLocalizations(context).transactionId} : ',
                                    style: textTheme.bodySmall),
                                Expanded(
                                  child: Text(
                                      txnData?.transactionBctpayRefrenceNumber ??
                                          "",
                                      textAlign: TextAlign.right,
                                      style: textTheme.bodySmall!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${appLocalizations(context).paymentDate} : ',
                                    style: textTheme.bodySmall),
                                Expanded(
                                  child: Text(
                                      txnData?.createdAt?.formattedDateTime() ??
                                          "",
                                      textAlign: TextAlign.right,
                                      style: textTheme.bodySmall!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${appLocalizations(context).paymentMethod} : ',
                                    style: textTheme.bodySmall),
                                Expanded(
                                  child: Text(
                                      txnData?.transactionFeeServiceType ?? "",
                                      textAlign: TextAlign.right,
                                      style: textTheme.bodySmall!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${appLocalizations(context).receivedBy} : ',
                                    style: textTheme.bodySmall),
                                Expanded(
                                  child: Text(txnData?.receiverName ?? "",
                                      textAlign: TextAlign.right,
                                      style: textTheme.bodySmall!.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${appLocalizations(context).fees} : ',
                                    style: textTheme.bodySmall),
                                Text(
                                    formatCurrency(
                                        "${double.parse(txnData?.paybleCommissionFeeAmount ?? "0.00") + double.parse(txnData?.paybleTransactionFeeAmount ?? "0.00")}"),
                                    style: textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                appLocalizations(context).totalPayment,
                                style: textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                formatCurrency(
                                    txnData?.paybleTotalAmount ?? "0.00"),
                                style: textTheme.headlineLarge,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (showDownloadAndShareBtn)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                style: IconButton.styleFrom(
                                    side: BorderSide(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                )),
                                onPressed: () {
                                  screenshotController
                                      .capture()
                                      .then((image) async {
                                    if (image != null) {
                                      DocumentFileSavePlus()
                                          .saveFile(
                                              image,
                                              "bctpay_txn_slip_${DateTime.now()}.png",
                                              "appliation/png")
                                          .whenComplete(() {
                                        if (!context.mounted) return;
                                        showToast(appLocalizations(context)
                                            .fileDownloaded);
                                      });
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.file_download_outlined,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                style: IconButton.styleFrom(
                                    side: BorderSide(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                )),
                                onPressed: () {
                                  screenshotController
                                      .capture()
                                      .then((image) async {
                                    if (image != null) {
                                      final directory =
                                          await getApplicationDocumentsDirectory();
                                      final pathOfImage = await File(
                                              '${directory.path}/bctpay_txn_slip_${DateTime.now()}.png')
                                          .create();
                                      await pathOfImage
                                          .writeAsBytes(image.toList())
                                          .then((value) => SharePlus.instance
                                              .share(ShareParams(
                                                  files: [XFile(value.path)])));
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.share,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          10.height,
                          ElevatedButton(
                              onPressed: () {
                                transactionHistoryBloc.add(
                                    TransactionHistoryEvent(
                                        limit: 10,
                                        page: 1,
                                        fromAnotherScreen: true));
                                Navigator.popUntil(
                                    context,
                                    (route) =>
                                        route.settings.name ==
                                        AppRoutes.bottombar);
                              },
                              child: Text(appLocalizations(context).close)),
                          10.height,
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Lottie.asset(
                'assets/lottie/success_animation.json',
                width: 150,
                height: 150,
              ),
            ),
            Positioned(
              top: 100,
              right: 0,
              child: IconButton(
                  onPressed: () {
                    transactionHistoryBloc.add(TransactionHistoryEvent(
                        limit: 10, page: 1, fromAnotherScreen: true));
                    Navigator.popUntil(context,
                        (route) => route.settings.name == AppRoutes.bottombar);
                  },
                  icon: Icon(Icons.clear)),
            )
          ],
        ),
      ),
    );
  }
}
