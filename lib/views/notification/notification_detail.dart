import 'package:bctpay/globals/index.dart';

class NotificationDetail extends StatefulWidget {
  final NotificationData? notification;

  const NotificationDetail({super.key, this.notification});

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var args =
          ModalRoute.of(context)!.settings.arguments as NotificationDetail;
      if (args.notification?.read == "false") {
        notificationsListBloc.add(
            ReadNotificationEvent(notificationId: [args.notification!.id]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as NotificationDetail;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).notifications),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                args.notification!.notificationTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                args.notification!.notificationDesc,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                args.notification!.createdAt?.formatRelativeDateTime(context) ??
                    "",
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: Text(appLocalizations(context).goBack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
