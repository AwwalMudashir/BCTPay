import 'package:bctpay/globals/index.dart';

class NotificationScreen extends StatefulWidget {
  final bool? showAppbar;

  const NotificationScreen({super.key, this.showAppbar});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int page = 1;
  int limit = 10;
  List<NotificationData> notifications = [];
  var scrollController = ScrollController();
  var loadingBloc = SelectionBloc(SelectBoolState(false));
  var screenLoadingBloc = SelectionBloc(SelectBoolState(false));

  void pagination() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      loadingBloc.add(SelectBoolEvent(true));
      notificationsListBloc
          .add(GetNotificationListEvent(page: page, limit: limit));
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(pagination);
    notificationsListBloc
        .add(GetNotificationListEvent(page: page, limit: limit, clear: true));
  }

  @override
  void dispose() {
    scrollController.removeListener(pagination);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as NotificationScreen?;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: args?.showAppbar ?? false
          ? CustomAppBar(
              title: AppLocalizations.of(context)!.notifications,
              centerTitle: true,
              actions: [
                _notificationPopUpMenuActionButton(),
              ],
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: BlocConsumer(
            bloc: notificationsListBloc,
            listener: (context, state) {
              if (state is GetNotificationsListState) {
                if (state.value.code == 200) {
                  if (state.clear ?? false) {
                    page = 1;
                    notifications.clear();
                  }
                  notifications
                      .addAll(state.value.data?.filteredNotifications ?? []);
                  page++;
                  loadingBloc.add(SelectBoolEvent(false));
                } else if (state.value.code == 401) {
                  sessionExpired(state.value.message, context);
                }
              }
              if (state is ReadNotificationState) {
                if (state.value.code == 200) {
                } else if (state.value.code == 401) {
                  sessionExpired(state.value.message, context);
                } else {
                  showFailedDialog(state.value.message, context);
                }
                page = 1;
                notificationsListBloc.add(GetNotificationListEvent(
                    page: page, limit: limit, clear: true));
              }
              if (state is ClearNotificationsState) {
                if (state.value.code == 200) {
                  showSuccessDialog(state.value.message, context);
                } else if (state.value.code == 401) {
                  sessionExpired(state.value.message, context);
                } else {
                  showFailedDialog(state.value.message, context);
                }
                page = 1;
                notificationsListBloc.add(GetNotificationListEvent(
                    page: page, limit: limit, clear: true));
              }
            },
            builder: (context, state) {
              if (notifications.isEmpty && state is ApisBlocLoadingState) {
                return Loader();
              } else if (notifications.isEmpty) {
                return Center(
                  child: Text(appLocalizations(context).noNotifications),
                );
              }
              return BlocBuilder(
                  bloc: screenLoadingBloc,
                  builder: (context, loadingState) {
                    if (loadingState is SelectBoolState) {
                      return ModalProgressHUD(
                        progressIndicator: const Loader(),
                        inAsyncCall:
                            state is ApisBlocLoadingState || loadingState.value,
                        child: AnimationLimiter(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: notifications.length,
                            itemBuilder: (context, index) => ListAnimation(
                              index: index,
                              child: Column(
                                children: [
                                  NotificationListItem(
                                      loadingBloc: screenLoadingBloc,
                                      notification: notifications[index]),
                                  if (index == notifications.length - 1)
                                    BlocBuilder(
                                        bloc: loadingBloc,
                                        builder: (context, loadingState) {
                                          if (loadingState is SelectBoolState) {
                                            if (loadingState.value) {
                                              return const Loader();
                                            }
                                          }
                                          return const SizedBox.shrink();
                                        })
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Loader();
                  });
            }),
      ),
    );
  }

  BlocConsumer<ApisBloc, Object?> _notificationPopUpMenuActionButton() =>
      BlocConsumer(
          bloc: notificationsListBloc,
          listener: (context, state) {
            if (state is GetNotificationsListState) {
              if (state.value.code == 200) {
                if (state.clear ?? false) {
                  notifications.clear();
                }
                notifications
                    .addAll(state.value.data?.filteredNotifications ?? []);
              } else if (state.value.code == 401) {
                sessionExpired(state.value.message, context);
              }
            }
          },
          builder: (context, state) {
            if (state is GetNotificationsListState) {
              if (notifications.isEmpty) {
                return const SizedBox.shrink();
              }
              return PopupMenuButton(
                style: ButtonStyle(visualDensity: VisualDensity.compact),
                color: isDarkMode(context) ? themeLogoColorBlue : Colors.white,
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  if (state.value.data?.unreadnotificationscount != 0)
                    PopupMenuItem(
                        onTap: () {
                          notificationsListBloc
                              .add(ReadNotificationEvent(readAll: true));
                        },
                        child: Text(
                            appLocalizations(context).readAllNotifications)),
                  PopupMenuItem(
                      onTap: () {
                        notificationsListBloc.add(ClearNotificationsEvent(
                          clearAll: true,
                        ));
                      },
                      child:
                          Text(appLocalizations(context).clearAllNotifications))
                ],
              );
            }
            return const SizedBox.shrink();
          });
}
