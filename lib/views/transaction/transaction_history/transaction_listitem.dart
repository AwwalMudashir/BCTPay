import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionData transaction;
  final bool showImage;
  final void Function()? onTap;

  const TransactionListItem(
      {super.key,
      required this.transaction,
      this.showImage = true,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: SharedPreferenceHelper.getUserId(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userId = snapshot.data;
            bool isReceivedTxn = transaction.details.senderId == userId;
            return InkWell(
              onTap: onTap,
              child: Stack(
                children: [
                  Card(
                    color: tileColor,
                    elevation: 5,
                    margin: const EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (showImage)
                                  SizedBox.square(
                                    dimension: 50,
                                    child: Card(
                                        color: Colors.transparent,
                                        elevation: 0,
                                        child: Image.asset(isReceivedTxn
                                            ? Assets.assetsImagesTxnTransferIcon
                                            : Assets
                                                .assetsImagesTxnReceiveIcon)),
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            isReceivedTxn
                                                ? transaction
                                                    .details.receiverName
                                                : transaction
                                                    .details.senderName,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: textTheme.titleSmall
                                                ?.copyWith(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: baseUrlCountryFlag +
                                                    (isReceivedTxn
                                                        ? transaction
                                                                .receiverDetails
                                                                ?.countryFlag ??
                                                            transaction
                                                                .senderDetails
                                                                ?.countryFlag ??
                                                            ""
                                                        : transaction
                                                                .senderDetails
                                                                ?.countryFlag ??
                                                            transaction
                                                                .receiverDetails
                                                                ?.countryFlag ??
                                                            ""),
                                                height: 30,
                                                width: 30,
                                                progressIndicatorBuilder:
                                                    progressIndicatorBuilder,
                                                errorWidget: (c, o, s) =>
                                                    const Icon(
                                                  Icons.error,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                !isReceivedTxn
                                                    ? transaction.details
                                                        .senderAccountNumber
                                                        .showLast4HideAll()
                                                        .replaceAll("+", "")
                                                    : transaction.details
                                                        .receiverAccountNumber
                                                        .showLast4HideAll()
                                                        .replaceAll("+", ""),
                                                style: textTheme.headlineSmall
                                                    ?.copyWith(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            transaction.subscriptionDetails !=
                                                    null
                                                ? appLocalizations(context)
                                                    .subscription
                                                : transaction.invoiceDetails !=
                                                        null
                                                    ? appLocalizations(context)
                                                        .bill
                                                    : transaction.details
                                                                .eventdata !=
                                                            null
                                                        ? appLocalizations(
                                                                context)
                                                            .event
                                                        : "",
                                            style: textTheme.bodySmall
                                                ?.copyWith(
                                                    color: themeLogoColorBlue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      FutureBuilder(
                                          future: SharedPreferenceHelper
                                              .getUserId(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              var userId = snapshot.data;
                                              bool isReceivedTxn = transaction
                                                      .details.receiverId ==
                                                  userId;
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              getTxnStatusColor(
                                                            getSTransactionStatus(
                                                                    context,
                                                                    isReceiverId:
                                                                        isReceivedTxn,
                                                                    txnData:
                                                                        transaction
                                                                            .details)
                                                                .toUpperCase(),
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5))),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Text(
                                                        getTxnStatus(
                                                          getSTransactionStatus(
                                                              context,
                                                              isReceiverId:
                                                                  isReceivedTxn,
                                                              txnData:
                                                                  transaction
                                                                      .details),
                                                          context,
                                                        ),
                                                        style: textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${isReceivedTxn ? "+" : "-"}${formatCurrency(!isReceivedTxn ? transaction.details.paybleTotalAmount : transaction.details.receiverAmount)}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: textTheme.bodyLarge
                                                        ?.copyWith(
                                                      color:
                                                          themeLogoColorOrange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                            return const Loader();
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: DateView(
                      date: transaction.details.createdAt.formattedDateTime(),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Loader();
        });
  }

  Color getTxnStatusColor(String transactionStep) {
    switch (transactionStep) {
      case "PENDING":
        return Colors.orange;
      case "INITIATED":
        return Colors.yellow;
      case "INITIATE":
        return Colors.amber;
      case "FAILED":
        return Colors.red;
      case "SUCCESSFUL":
        return Colors.green;
      case "SUCCESS":
        return Colors.green;
    }
    return Colors.grey;
  }

  String getTxnStatus(String? status, BuildContext context) {
    switch (status) {
      case "PENDING":
        return appLocalizations(context).pending;
      case "INITIATED":
        return appLocalizations(context).initiated;
      case "INITIATE":
        return appLocalizations(context).initiated;
      case "FAILED":
        return appLocalizations(context).failed;
      case "SUCCESSFUL":
        return appLocalizations(context).txnStatusSuccess;
      case "SUCCESS":
        return appLocalizations(context).txnStatusSuccess;
    }
    return appLocalizations(context).pending;
  }

  String getSTransactionStatus(BuildContext context,
          {required bool isReceiverId, Transaction? txnData}) =>
      isReceiverId
          ? txnData?.transactionStepWithReceiver?.toLowerCase() == "successful"
              ? appLocalizations(context).success.toUpperCase()
              : txnData?.transactionStepWithReceiver ?? ""
          : txnData?.transactionStepWithSender?.toLowerCase() == "successful"
              ? appLocalizations(context).success.toUpperCase()
              : txnData?.transactionStepWithSender ?? "";
}
