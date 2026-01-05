import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class PaymentRequestListItem extends StatelessWidget {
  final PaymentRequest request;
  final bool isSentRequest;
  final void Function()? onTap;
  final bool showPoupMenuBtn;
  final ApisBloc paymentRequestBloc;

  const PaymentRequestListItem({
    super.key,
    required this.request,
    this.onTap,
    this.showPoupMenuBtn = true,
    this.isSentRequest = false,
    required this.paymentRequestBloc,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onLongPressStart: (p0) {
        position = p0.globalPosition;
      },
      child: Stack(
        children: [
          Card(
            color: tileColor,
            elevation: 5,
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: request.id,
                    child: SizedBox.square(
                      dimension: 80,
                      child: Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "$baseUrlProfileImage${isSentRequest ? request.senderProfilePic : request.receiverProfilePic}",
                                  progressIndicatorBuilder:
                                      progressIndicatorBuilder,
                                  errorWidget:
                                      (BuildContext c, String s, Object o) =>
                                          const Icon(
                                            Icons.image,
                                            color: Colors.grey,
                                          )),
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                isSentRequest
                                    ? request.senderName
                                    : request.receiverName,
                                style: textTheme.titleSmall?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isSentRequest
                                  ? "${request.requestToPayUserPhoneCode} ${request.requestToPayUserPhoneNumber}"
                                  : "${request.requestSenderPhoneCode ?? "+${selectedCountry?.phoneCode}"} ${request.requestSenderPhoneNumber ?? request.requestToPayUserPhoneNumber}",
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                            Text(
                              formatCurrency(request.requestedAmount),
                              style: textTheme.bodyLarge?.copyWith(
                                  color: themeLogoColorOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        if (request.payNote.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  request.payNote,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headlineSmall?.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (!isSentRequest && request.status == "0")
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(5),
                                            backgroundColor: Colors.green,
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                          onPressed: onTap,
                                          icon: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            appLocalizations(context).pay,
                                            style: textTheme.bodyMedium
                                                ?.copyWith(color: Colors.white),
                                          )),
                                      5.width,
                                      ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(5),
                                            backgroundColor: Colors.red,
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                          onPressed: () {
                                            paymentRequestBloc.add(
                                                RejectPaymentRequestEvent(
                                                    requestId: request.id));
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            appLocalizations(context).reject,
                                            style: textTheme.bodyMedium
                                                ?.copyWith(color: Colors.white),
                                          )),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: getPaymentRequestStatusColor(
                                                request, context)),
                                        child: Text(
                                          getPaymentRequestStatus(
                                              request, context,
                                              isSentRequest: isSentRequest),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      if (request.status == "0") ...[
                                        5.width,
                                        ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(5),
                                              backgroundColor: Colors.red,
                                              visualDensity:
                                                  VisualDensity.compact,
                                            ),
                                            onPressed: () {
                                              paymentRequestBloc.add(
                                                  RejectPaymentRequestEvent(
                                                      requestId: request.id));
                                            },
                                            icon: const Icon(
                                              Icons.clear,
                                              color: Colors.white,
                                            ),
                                            label: Text(
                                              appLocalizations(context).cancel,
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            )),
                                      ]
                                    ],
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (showPoupMenuBtn)
                    PopupMenuButton(
                        color: isDarkMode(context)
                            ? themeLogoColorBlue
                            : Colors.white,
                        icon: const Icon(Icons.more_vert),
                        iconColor: Colors.black,
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(appLocalizations(context).delete),
                                onTap: () {
                                  showCustomDialog(
                                    appLocalizations(context)
                                        .doYouReallyWantToDeleteThisAccount,
                                    context,
                                    title: appLocalizations(context).warning,
                                    dialogType: DialogType.warning,
                                    onYesTap: () {
                                      beneficiaryListBloc.add(
                                          DeleteBeneficiaryEvent(
                                              beneficiaryId: request.id));
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                            ])
                ],
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: DateView(
              date: request.createdAt.formatRelativeDateTime(context),
            ),
          ),
        ],
      ),
    );
  }

  String getPaymentRequestStatus(PaymentRequest request, BuildContext context,
      {bool isSentRequest = false}) {
    switch (request.status) {
      case "0":
        return appLocalizations(context).unpaid;
      case "1":
        return appLocalizations(context).paid;
      case "2":
        return isSentRequest
            ? appLocalizations(context).cancelled
            : appLocalizations(context).rejected;
    }
    return appLocalizations(context).unpaid;
  }

  Color getPaymentRequestStatusColor(
      PaymentRequest request, BuildContext context) {
    switch (request.status) {
      case "0":
        return Colors.red;
      case "1":
        return Colors.green;
      case "2":
        return Colors.grey;
    }
    return Colors.red;
  }
}
