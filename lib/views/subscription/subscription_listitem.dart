import 'package:bctpay/globals/index.dart';

class SubscriptionListItem extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionListItem({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSubscriptionTap(context),
      child: Stack(
        children: [
          Container(
            decoration: shadowDecoration,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: shadowDecoration,
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          "$baseUrlProfileImage${subscription.subscriberUserAcc?.merchantId?.companyLogo}",
                      progressIndicatorBuilder: progressIndicatorBuilder,
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(Assets.assetsImagesPerson),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${subscription.subscriberUserAcc?.subscriberCategoryName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: textTheme(context).titleMedium?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${subscription.subscriberUserAcc?.merchantId?.businessCategoryName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: textTheme(context).bodySmall?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      if (getMostEarliestEndDate(subscription.subscriber) !=
                          null)
                        Row(
                          children: [
                            Text(
                              "${appLocalizations(context).expiryDate} : ",
                              style: textTheme(context)
                                  .bodySmall!
                                  .copyWith(color: Colors.grey),
                            ),
                            Text(
                              getMostEarliestEndDate(subscription.subscriber)
                                      ?.formattedDate() ??
                                  "",
                              style: textTheme(context)
                                  .bodySmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      if (getMostEarliestDueDate(subscription.subscriber) !=
                          null)
                        Row(
                          children: [
                            Text(
                              "${appLocalizations(context).dueDate} : ",
                              style: textTheme(context)
                                  .bodySmall!
                                  .copyWith(color: Colors.grey),
                            ),
                            Text(
                              getMostEarliestDueDate(subscription.subscriber)
                                      ?.formattedDate() ??
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
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Row(
              children: [
                Icon(
                  subscription.subscriber?.first.subscriptionType
                              ?.toLowerCase() ==
                          "recurring"
                      ? Icons.autorenew
                      : Icons.timelapse,
                  color: themeLogoColorOrange,
                  size: 20,
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(
                            text: subscription.subscriber?.first.paymentLink ??
                                ""))
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
              ],
            ),
          )
        ],
      ),
    );
  }

  void onSubscriptionTap(BuildContext context) {
    if ((subscription.subscriber?.length ?? 0) < 2) {
      Navigator.pushNamed(context, AppRoutes.subscriptionDetail,
          arguments: SubscriptionDetail(
              subscriber: subscription.subscriber?.first.copyWith(
                  merchantId: subscription.subscriberUserAcc?.merchantId)));
    } else {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor:
            isDarkMode(context) ? themeLogoColorBlue : Colors.white,
        builder: (context) => AnimationLimiter(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(5),
              itemCount: subscription.subscriber?.length,
              itemBuilder: (context, index) {
                var subscribers = subscription.subscriber ?? [];
                return ListAnimation(
                  index: index,
                  child: SubscriberListItem(
                    subscriber: subscribers[index].copyWith(
                        merchantId: subscription.subscriberUserAcc?.merchantId),
                  ),
                );
              }),
        ),
      );
    }
  }
}

DateTime? getMostEarliestEndDate(List<Subscriber>? subscribers) {
  if (subscribers == null || subscribers.isEmpty) {
    return null;
  }

  // Collect all non-null endDates
  final dates = subscribers
      .expand<PlanInfo>((s) => s.planInfo ?? []) // flatten plans
      .map((p) => p.endDate) // DateTime?
      .whereType<DateTime>() // keep only non-null
      .toList();

  if (dates.isEmpty) {
    return null;
  }

  // Earliest = smallest
  return dates.reduce((a, b) => a.isBefore(b) ? a : b);
}

DateTime? getMostEarliestDueDate(List<Subscriber>? subscribers) {
  if (subscribers == null || subscribers.isEmpty) {
    // return DateTime.now(); // if you want a fallback
    return null;
  }

  // Collect all non-null endDates
  final dates = subscribers
      .expand<PlanInfo>((s) => s.planInfo ?? []) // flatten plans
      .map((p) => p.dueDate) // DateTime?
      .whereType<DateTime>() // keep only non-null
      .toList();

  if (dates.isEmpty) {
    return null;
  }

  // Earliest = smallest
  return dates.reduce((a, b) => a.isBefore(b) ? a : b);
}
