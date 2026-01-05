import 'package:bctpay/globals/globals.dart';

Widget buildTxnQRScreenshot(
    {required BuildContext context,
    required TransactionData? transaction,
    required String? userId}) {
  return LocalizationsPortal(
    context: context,
    child: TxnSlipShareView(
      transaction: transaction,
      userId: userId,
      context: context,
    ),
  );
}

class LocalizationsPortal extends StatelessWidget {
  const LocalizationsPortal({
    super.key,
    required this.child,
    required this.context,
  });

  final BuildContext context;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: Localizations.localeOf(this.context),
      delegates: AppLocalizations.localizationsDelegates,
      child: child,
    );
  }
}

class TxnSlipShareView extends StatelessWidget {
  final TransactionData? transaction;
  final String? userId;
  final BuildContext? context;

  const TxnSlipShareView(
      {super.key, required this.transaction, this.context, this.userId});

  @override
  Widget build(BuildContext context) {
    bool isReceivedTxn = transaction?.details.receiverId == userId;
    return Container(
      padding: EdgeInsets.all(10),
      color: isDarkMode(context) ? themeLogoColorBlue : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TransactionListItem(transaction: transaction!),
          10.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                appLocalizations(context).transactionId,
                style: textTheme(context).bodySmall,
              ),
              Text(
                transaction!.details.transactionBctpayRefrenceNumber,
              ),
            ],
          ),
          10.height,
          if (transaction?.details.planInfo?.isNotEmpty ?? false) ...[
            Text(
              appLocalizations(context).subscriptionDetails,
              style: textTheme(context).bodySmall,
            ),
            Text(
              "${appLocalizations(context).referenceID} (#${transaction?.subscriptionDetails?.subscriberId})",
              style: textTheme(context).headlineLarge,
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: transaction?.details.planInfo?.length,
                itemBuilder: (context, index) {
                  var e = transaction?.details.planInfo?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e?.plansDurations ?? "",
                          style: textTheme(context)
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(formatCurrency(e?.paidAmount ?? "0")),
                      ],
                    ),
                  );
                })
          ],
          if (transaction?.invoiceDetails != null) ...[
            Text(appLocalizations(context).invoiceDetail,
                style: textTheme(context).bodySmall),
            Text(
              "${appLocalizations(context).referenceID} (#${transaction?.invoiceDetails?.invoiceNumber})",
              style: textTheme(context).headlineLarge,
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: transaction?.invoiceDetails?.productInfo.length,
                itemBuilder: (context, index) {
                  var e = transaction?.invoiceDetails?.productInfo[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e?.productNameEn ?? "",
                          style: textTheme(context)
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(formatCurrency(
                            e?.totalProductPrice?.toStringAsFixed(2) ?? "0")),
                      ],
                    ),
                  );
                })
          ],
          10.height,
          QRCodeViewWidget(
            qrCodeString: transaction?.details.qrCodeLink ?? "",
            logo:
                "$baseUrlProfileImage${getQRLogo(transaction, isReceivedTxn)}",
          ),
          20.height,
          Text(
            appLocalizations(context).scanToVerifyThisPayment,
            style: textTheme(context).headlineLarge,
          )
        ],
      ),
    );
  }
}
