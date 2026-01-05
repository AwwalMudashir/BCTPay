import 'package:bctpay/globals/index.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  // debugPrint(
  //     "Push Message received while app in background: ${message.toMap()}");
}

Future<String?> getFcmToken() async {
  await requestPushNotificationPermission();
  return _firebaseMessaging.getToken();
}

StreamSubscription onTokenReferesh() {
  return _firebaseMessaging.onTokenRefresh.listen((value) {
    // debugPrint("FCM Token refreshed: $value");
    // SharedPreferance.saveLoginData(loginResponse);
    // You can send the new token to your server or save it locally
    // For example, you might want to call a function to update the token in your backend
    // updateFcmToken(value);
  });
}

Future<void> firebase(BuildContext context) async {
  LocalNotificationService.init(context);
  requestPushNotificationPermission();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // debugPrint(
    //     "Push Message received while app in forground: ${message.toMap()}");
    handleOnMessageByType(message);
    if (message.notification != null) {
      ///local notification
      LocalNotificationService.showNotification(
          0, message.notification?.title, message.notification?.body,
          payload: jsonEncode(message.toMap()));
    }
  });

  _firebaseMessaging.getInitialMessage().then((message) {
    // debugPrint(
    //     "Push Message received while app terminated: ${message?.toMap()}");
    if (message != null) {
      if (!context.mounted) return;
      navigateByType(message, context);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // debugPrint(
    //     "Push Message received while app is opening: ${message.toMap()}");
    if (!context.mounted) return;
    navigateByType(message, context);
  });
}

Future requestPushNotificationPermission() async {
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  debugPrint(
      'User granted permission to receive push notification: ${settings.authorizationStatus}');
}

void handleOnMessageByType(RemoteMessage message) {
  var notificationType = notificationTypeValues.map[message.data['type']];
  switch (notificationType) {
    case NotificationType.profileUpdate:
      profileBloc.add(GetProfileEvent());
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycStatus:
      kycBloc.add(GetKYCDetailEvent());
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycUnderReview:
      kycBloc.add(GetKYCDetailEvent());
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycApproved:
      kycBloc.add(GetKYCDetailEvent());
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycSuspended:
      kycBloc.add(GetKYCDetailEvent());
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycRejected:
      kycBloc.add(GetKYCDetailEvent());
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycExpired:
      kycBloc.add(GetKYCDetailEvent());
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycUploaded:
      kycBloc.add(GetKYCDetailEvent());
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.kycUpdated:
      kycBloc.add(GetKYCDetailEvent());
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.transaction:
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      transactionHistoryBloc.add(
          TransactionHistoryEvent(limit: 10, page: 1, fromAnotherScreen: true));
      break;

    case NotificationType.requestToPay:
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    case NotificationType.paymentSent:
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      transactionHistoryBloc.add(
          TransactionHistoryEvent(limit: 10, page: 1, fromAnotherScreen: true));

      break;

    case NotificationType.paymentReceived:
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      transactionHistoryBloc.add(
          TransactionHistoryEvent(limit: 10, page: 1, fromAnotherScreen: true));

      break;

    case NotificationType.invoiceGenerated:
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;
    case NotificationType.invoiceUpdated:
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;
    case NotificationType.planNotification:
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;
    case NotificationType.default1:
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;
    case null:
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;

    default:
      // bottomNavigationBloc.add(SelectIntEvent(3));
      notificationsListBloc
          .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      break;
  }
}

Future navigateByType(RemoteMessage message, BuildContext context,
    {NotificationData? notification}) async {
  var notificationType = notificationTypeValues.map[message.data['type']];
  switch (notificationType) {
    case NotificationType.profileUpdate:
      Navigator.of(context).pushNamed(AppRoutes.updateProfile);
      break;

    case NotificationType.kycUnderReview:
      Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
      break;

    case NotificationType.kycApproved:
      Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
      break;

    case NotificationType.kycSuspended:
      Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
      break;

    case NotificationType.kycUploaded:
      Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
      break;

    case NotificationType.kycUpdated:
      Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
      break;

    case NotificationType.transaction:
      await transactionDetail(transactionId: message.data["id"])
          .then((response) {
        if (response.code == 200) {
          if (response.data != null) {
            if (!context.mounted) return;
            Navigator.of(context).pushNamed(AppRoutes.transactionHistoryDetail,
                arguments: TransactionHistoryDetail(
                  transaction: TransactionData.fromJson(response.data),
                ));
          } else {
            if (!context.mounted) return;
            Navigator.pushNamed(context, AppRoutes.notificationDetail,
                arguments: NotificationDetail(
                  notification: notification,
                ));
          }
        } else {
          showToast(response.message ?? response.error ?? "");
        }
      });
      break;

    case NotificationType.requestToPay:
      Navigator.of(context).pushNamed(AppRoutes.paymentRequests);
      break;

    case NotificationType.paymentSent:
      await transactionDetail(transactionId: message.data["id"])
          .then((response) {
        if (response.code == 200) {
          if (response.data != null) {
            if (!context.mounted) return;
            Navigator.of(context).pushNamed(AppRoutes.transactionHistoryDetail,
                arguments: TransactionHistoryDetail(
                  transaction: TransactionData.fromJson(response.data),
                ));
          } else {
            if (!context.mounted) return;
            Navigator.pushNamed(context, AppRoutes.notificationDetail,
                arguments: NotificationDetail(
                  notification: notification,
                ));
          }
        } else if (response.code == HTTPResponseStatusCodes.sessionExpireCode) {
          if (!context.mounted) return;
          sessionExpired(response.message ?? response.error ?? "", context);
        } else {
          showToast(response.message ?? response.error ?? "");
        }
      });
      break;

    case NotificationType.paymentReceived:
      await transactionDetail(transactionId: message.data["id"])
          .then((response) {
        if (response.code == 200) {
          if (response.data != null) {
            if (!context.mounted) return;
            Navigator.of(context).pushNamed(AppRoutes.transactionHistoryDetail,
                arguments: TransactionHistoryDetail(
                  transaction: TransactionData.fromJson(response.data),
                ));
          } else {
            if (!context.mounted) return;
            Navigator.pushNamed(context, AppRoutes.notificationDetail,
                arguments: NotificationDetail(
                  notification: notification,
                ));
          }
        } else {
          showToast(response.message ?? response.error ?? "");
        }
      });
      break;

    case NotificationType.invoiceGenerated:
      await invoiceDetail(invoiceNumber: message.data["id"]).then((response) {
        if (!context.mounted) return;
        if (response.code == 200) {
          if (response.data != null) {
            Navigator.pushNamed(context, AppRoutes.invoiceDetail,
                arguments: InvoiceDetail(
                  invoiceData:
                      InvoiceData(invoiceDetails: response.data?.invoiceData),
                ));
          } else {
            Navigator.pushNamed(context, AppRoutes.notificationDetail,
                arguments: NotificationDetail(
                  notification: notification,
                ));
          }
        } else {
          showToast(response.message);
        }
      });
      break;

    case NotificationType.invoiceUpdated:
      await invoiceDetail(invoiceNumber: message.data["id"]).then((response) {
        if (response.code == 200) {
          if (!context.mounted) return;
          if (response.data != null) {
            Navigator.pushNamed(context, AppRoutes.invoiceDetail,
                arguments: InvoiceDetail(
                  invoiceData:
                      InvoiceData(invoiceDetails: response.data?.invoiceData),
                ));
          } else {
            Navigator.pushNamed(context, AppRoutes.notificationDetail,
                arguments: NotificationDetail(
                  notification: notification,
                ));
          }
        } else {
          showToast(response.message);
        }
      });
      break;

    case NotificationType.default1:
      Navigator.pushNamed(context, AppRoutes.notificationDetail,
          arguments: NotificationDetail(
            notification: notification,
          ));
      break;

    case NotificationType.kycRejected:
      Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
      break;
    case NotificationType.kycExpired:
      Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
      break;
    case NotificationType.kycStatus:
      Navigator.of(context).pushNamed(AppRoutes.kycTakeASelfie);
      break;
    case NotificationType.planNotification:
      await getSubscriptionById(id: message.data['id']).then((value) {
        if (!context.mounted) return;
        if (value.code == 200) {
          Navigator.pushNamed(context, AppRoutes.subscriptionDetail,
              arguments: SubscriptionDetail(
                subscriber: Subscriber.fromJson(value.data),
              ));
        } else if (value.code == HTTPResponseStatusCodes.sessionExpireCode) {
          sessionExpired(value.message ?? value.error ?? "", context);
        } else {
          showFailedDialog(value.message ?? value.error ?? "", context);
        }
      });
      break;
    case null:
      Navigator.pushNamed(context, AppRoutes.notificationDetail,
          arguments: NotificationDetail(
            notification: notification,
          ));
      break;
    default:
      Navigator.pushNamed(context, AppRoutes.notifications,
          arguments: NotificationScreen(
            showAppbar: true,
          ));
      break;
  }
  return true;
}
