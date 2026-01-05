import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class InvoicePaymentStatus {
  static String paid = "PAID";
  static String unpaid = "UNPAID";
}

class InvoiceListItem extends StatelessWidget {
  final InvoiceData? invoiceData;

  const InvoiceListItem({super.key, required this.invoiceData});

  @override
  Widget build(BuildContext context) {
    var invoice = invoiceData?.invoiceDetails;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.invoiceDetail,
            arguments: InvoiceDetail(
              invoiceData: invoiceData,
            ));
      },
      child: Stack(
        children: [
          Card(
            color: tileColor,
            elevation: 5,
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "#${invoice?.invoiceNumber}",
                          maxLines: 2,
                          softWrap: true,
                          style: textTheme(context)
                              .headlineMedium
                              ?.copyWith(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          invoice?.merchantData?.businessCategoryName ??
                              invoice?.merchantName ??
                              appLocalizations(context).unknown,
                          maxLines: 2,
                          style: textTheme(context)
                              .titleSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: invoice?.paymentStatus ==
                                  InvoicePaymentStatus.paid
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        child: Text(
                          invoice?.paymentStatus ?? "",
                          style: textTheme(context).bodySmall!.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ActiveInactiveStatusView(
                          isActive: invoice?.status.toLowerCase() == "true"),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(formatCurrency(invoice?.totalAmount ?? "0"),
                            softWrap: true,
                            style: textTheme(context).bodyLarge?.copyWith(
                                  color: themeLogoColorOrange,
                                  fontWeight: FontWeight.bold,
                                )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations(context).invoiceDate,
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 11),
                          ),
                          Text(
                            invoice?.invoiceDate.formattedDate() ?? "",
                            softWrap: true,
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 11),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              appLocalizations(context).dueDate,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 11),
                            ),
                            Text(
                              invoice?.dueDate.formattedDate() ?? "",
                              softWrap: true,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () {
                Clipboard.setData(
                        ClipboardData(text: invoice?.paymentLink ?? ""))
                    .whenComplete(() {
                  if (!context.mounted) return;
                  showToast(appLocalizations(context).copied);
                });
              },
              icon: Icon(
                Icons.copy,
                color: Colors.black,
                size: 20,
              ),
              visualDensity: VisualDensity.compact,
            ),
          )
        ],
      ),
    );
  }
}
