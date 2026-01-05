import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class NotificationListItem extends StatefulWidget {
  final SelectionBloc loadingBloc;
  final NotificationData notification;

  const NotificationListItem(
      {super.key, required this.notification, required this.loadingBloc});

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  var dismissKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    width = MediaQuery.of(context).size.width;
    return BlocBuilder(
        bloc: notificationsListBloc,
        builder: (context, state) {
          return Dismissible(
            key: dismissKey,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                notificationsListBloc.add(ClearNotificationsEvent(
                    notificationIds: [widget.notification.id]));
                return state is ClearNotificationsState;
              } else if (direction == DismissDirection.startToEnd) {
                if (widget.notification.read == "false") {
                  notificationsListBloc.add(ReadNotificationEvent(
                      notificationId: [widget.notification.id]));
                }
                return false;
              }
              return false;
            },
            background: Container(
                color: Colors.green, child: const Icon(Icons.mark_as_unread)),
            secondaryBackground: Container(
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: InkWell(
              onTap: () async {
                widget.loadingBloc.add(SelectBoolEvent(true));
                if (widget.notification.read == "false") {
                  notificationsListBloc.add(ReadNotificationEvent(
                      notificationId: [widget.notification.id]));
                }
                var notificationType =
                    widget.notification.notificationType.toLowerCase();
                await navigateByType(
                        RemoteMessage(data: {
                          "id": widget.notification.eventId ?? "",
                          "type": notificationType.contains("profile")
                              ? "profile_update"
                              : notificationType.contains("kyc")
                                  ? "kyc_approved"
                                  : notificationType
                                          .contains("payment_received")
                                      ? "payment_received"
                                      : notificationType
                                              .contains("payment_sent")
                                          ? "payment_sent"
                                          : notificationType
                                                  .contains("request_to_pay")
                                              ? "request_to_pay"
                                              : notificationType
                                                      .contains("invoice")
                                                  ? "Invoice generated"
                                                  : notificationType //"default"
                        }),
                        context,
                        notification: widget.notification)
                    .whenComplete(() {
                  widget.loadingBloc.add(SelectBoolEvent(false));
                });
              },
              child: Card(
                elevation: 5,
                color: tileColor,
                child: Container(
                  decoration: BoxDecoration(
                      color: tileColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                          right: BorderSide(
                              width: 8,
                              color: widget.notification.read != "true"
                                  ? const Color.fromARGB(255, 30, 141, 11)
                                  : const Color.fromARGB(255, 108, 106, 106)))),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox.square(
                        dimension: 50,
                        child: Card(
                          elevation: 5,
                          color: tileColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              Assets.assetsImagesMenuNotification,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.notification.notificationTitle,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleSmall?.copyWith(
                                      color: Colors.black,
                                      fontWeight:
                                          widget.notification.read != "true"
                                              ? FontWeight.bold
                                              : null,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.notification.createdAt
                                          ?.formatRelativeDateTime(context) ??
                                      "",
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight:
                                        widget.notification.read != "true"
                                            ? FontWeight.bold
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.notification.notificationDesc,
                              maxLines: 2,
                              style: textTheme.headlineSmall?.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
