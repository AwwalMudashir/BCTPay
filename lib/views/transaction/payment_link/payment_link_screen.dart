import 'package:bctpay/globals/index.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PaymentLinkScreen extends StatelessWidget {
  final bool isScanToPay;
  final PaymentLinkData? paymentLinkData;

  const PaymentLinkScreen(
      {super.key, this.paymentLinkData, this.isScanToPay = false});

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as PaymentLinkScreen;
    var paymentLink = arg.paymentLinkData;
    var banners = paymentLink?.eventBannerInfo ?? [];
    var slots = paymentLink?.slotInfo ?? [];
    var quantityBloc = SelectionBloc(SelectIntState(1));
    return Scaffold(
      appBar: CustomAppBar(
        title: paymentLink?.eventRefNumber ?? "",
        actions: [
          IconButton(
            icon: Icon(Icons.link),
            onPressed: () {
              launchUrlString(paymentLink?.webLink ?? "");
            },
          )
        ],
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: quantityBloc,
        builder: (context, state) {
          if (state is SelectIntState) {
            var totalAmount = calculateTotalAmount(slots);
            return Container(
              height: 80,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: isDarkMode(context) ? themeColorHeader : Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formatCurrency(
                          totalAmount.toStringAsFixed(2),
                        ),
                        style: textTheme(context).headlineMedium!.copyWith(
                            color: themeLogoColorOrange,
                            fontWeight: FontWeight.bold),
                      ),
                      10.width,
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    slots.first.paymentStatus == "PAID"
                                        ? Colors.green
                                        : themeLogoColorOrange),
                            onPressed: () {
                              if (slots.first.paymentStatus == "PAID") {
                                showToast(
                                    appLocalizations(context).alreadyPaid);
                              } else {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.transactiondetail,
                                  arguments: TransactionDetailScreen(
                                      toAccount: BankAccount(
                                          id: "",
                                          accountRole: "WALLET",
                                          accountnumber: paymentLink?.adminId,
                                          merchantId: paymentLink?.merchantId,
                                          beneficiaryname:
                                              selectedLanguage == 'en'
                                                  ? paymentLink?.titleForEn
                                                  : paymentLink?.titleForGn),
                                      receiverType: "Merchant",
                                      //invoiceData?.userType,
                                      isPaymentLinkPay: true,
                                      isScanToPay: arg.isScanToPay,
                                      paymentLinkData: paymentLink,
                                      amount: totalAmount.toStringAsFixed(2)),
                                );
                              }
                            },
                            child: Text(
                              slots.first.paymentStatus == "PAID"
                                  ? appLocalizations(context).paid
                                  : appLocalizations(context).pay,
                              style: textTheme(context).labelLarge!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Loader();
        },
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [
          if (paymentLink?.bannerImage?.isNotEmpty ?? false)
            CachedNetworkImage(
              imageUrl: "$baseUrlBannerImage${paymentLink?.bannerImage ?? ""}",
              errorWidget: (context, url, error) => Icon(Icons.error),
              progressIndicatorBuilder: progressIndicatorBuilder,
            ),
          10.height,
          Container(
            decoration: shadowDecoration.copyWith(
                color: isDarkMode(context) ? themeColorHeader : Colors.white),
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedLanguage == 'en'
                      ? paymentLink?.titleForEn ?? ""
                      : paymentLink?.titleForGn ?? "",
                  style: textTheme(context)
                      .titleMedium
                      ?.copyWith(color: themeLogoColorOrange),
                ),
                10.height,
                Wrap(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: themeLogoColorOrange,
                    ),
                    5.width,
                    Text(paymentLink?.venueAddress ?? ""),
                  ],
                ),
                10.height,
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: themeLogoColorOrange,
                    ),
                    5.width,
                    _dateView(appLocalizations(context).validFrom,
                        paymentLink?.validFrom, context),
                    Spacer(),
                    _dateView(appLocalizations(context).validTill,
                        paymentLink?.validTill, context)
                  ],
                ),
              ],
            ),
          ),
          10.height,
          Container(
            decoration: shadowDecoration.copyWith(
                color: isDarkMode(context) ? themeColorHeader : Colors.white),
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations(context).description,
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: themeLogoColorOrange),
                ),
                10.height,
                Text(
                  selectedLanguage == 'en'
                      ? paymentLink?.descriptionForEn ?? ""
                      : paymentLink?.descriptionForGn ?? "",
                  style: textTheme(context).bodyMedium?.copyWith(),
                ),
              ],
            ),
          ),
          10.height,
          Container(
            decoration: shadowDecoration.copyWith(
                color: isDarkMode(context) ? themeColorHeader : Colors.white),
            padding: EdgeInsets.all(5),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: slots.length,
              itemBuilder: (context, index) {
                var slot = slots[index];
                return SlotView(
                  slot: slot,
                  quantityBloc: quantityBloc,
                  ticketCounterViewStatus: paymentLink?.ticketCounterViewStatus,
                );
              },
            ),
          ),
          10.height,
          if (banners.isNotEmpty)
            Container(
              decoration: shadowDecoration.copyWith(
                  color: isDarkMode(context) ? themeColorHeader : Colors.white),
              padding: EdgeInsets.all(5),
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: banners.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) => MediaView(
                        media: banners[index],
                      )),
            )
        ],
      ),
    );
  }

  Column _dateView(String title, DateTime? date, BuildContext context) =>
      Column(
        children: [
          Text(
            title,
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),
          Text(date?.formattedDate() ?? ""),
        ],
      );

  double calculateTotalAmount(List<SlotInfo> slots) {
    double totalAmount = 0;
    for (var slot in slots) {
      totalAmount += double.parse(slot.perSlotPrice ?? '0') * slot.quantity;
    }
    return totalAmount;
  }
}
