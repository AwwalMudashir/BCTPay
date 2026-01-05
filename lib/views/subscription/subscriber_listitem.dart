import 'package:bctpay/lib.dart';

class SubscriberListItem extends StatelessWidget {
  final Subscriber subscriber;

  const SubscriberListItem({super.key, required this.subscriber});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSubscriberTap(context),
      child: Stack(
        children: [
          Container(
            decoration: shadowDecoration,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${appLocalizations(context).subscriberID} : #${subscriber.subscriberId}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textTheme(context).bodySmall?.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${subscriber.subscriberName} ${subscriber.subscriberLastName ?? ""}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textTheme(context).titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  subscriber.planName ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textTheme(context).titleMedium?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${appLocalizations(context).paymentStatus} : ",
                      style: textTheme(context)
                          .bodySmall!
                          .copyWith(color: Colors.grey),
                    ),
                    PaymentStatusView(
                      paymentStatus: subscriber.paymentStatus,
                    ),
                  ],
                ),
                if (getMostEarliestEndDate([subscriber]) != null)
                  Row(
                    children: [
                      Text(
                        "${appLocalizations(context).expiryDate} : ",
                        style: textTheme(context)
                            .bodySmall!
                            .copyWith(color: Colors.grey),
                      ),
                      Text(
                        getMostEarliestEndDate([subscriber])?.formattedDate() ??
                            "",
                        style: textTheme(context)
                            .bodySmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                if (getMostEarliestDueDate([subscriber]) != null)
                  Row(
                    children: [
                      Text(
                        "${appLocalizations(context).dueDate} : ",
                        style: textTheme(context)
                            .bodySmall!
                            .copyWith(color: Colors.grey),
                      ),
                      Text(
                        getMostEarliestDueDate([subscriber])?.formattedDate() ??
                            "",
                        style: textTheme(context)
                            .bodySmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
              right: 0,
              child: Row(
                children: [
                  Icon(
                    subscriber.subscriptionType?.toLowerCase() == "recurring"
                        ? Icons.autorenew
                        : Icons.timelapse,
                    color: themeLogoColorOrange,
                    size: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                              ClipboardData(text: subscriber.paymentLink ?? ""))
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
                  )
                ],
              ))
        ],
      ),
    );
  }

  void onSubscriberTap(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.subscriptionDetail,
        arguments: SubscriptionDetail(subscriber: subscriber));
  }

  bool isAllPlansPaid() => !(subscriber.planInfo
          ?.map((e) => e.paymentStatus?.toLowerCase() == 'paid')
          .contains(false) ??
      true);

  bool isAnyPlansExpired() => (subscriber.planInfo
          ?.map((e) => ((e.endDate?.isExpired() ?? false) && isRecurring()))
          .contains(true) ??
      false);

  bool isRecurring() =>
      subscriber.subscriptionType?.toLowerCase() == 'recurring';
}
