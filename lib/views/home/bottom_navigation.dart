import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';

var bottomNavigationBloc = SelectionBloc(SelectIntState(0));

class _MoreScreen extends StatelessWidget {
  const _MoreScreen();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Center(
      child: Text(
        "More",
        style: textTheme.titleMedium,
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final LocalAuthentication auth = LocalAuthentication();
  bool dialogShowing = false;

  Future<bool> fingerPrintConfiguration(BuildContext context) async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool isDeviceSupported = await auth.isDeviceSupported();
      final bool canAuthenticate =
          canAuthenticateWithBiometrics && isDeviceSupported;

      if (canAuthenticate) {
        if (!context.mounted) return false;
        final bool didAuthenticate = await authenticate(context);
        if (didAuthenticate) {
          dialogShowing = false;
          setState(() {});

          return true;
        } else {
          //Not authenticated
          dialogShowing = true;
          setState(() {});
          return false;
        }
      } else {
        dialogShowing = false;
        setState(() {});

        return true;
        //Auth not available
      }
    } catch (e) {
      //Exception
      dialogShowing = true;
      setState(() {});
      return false;
    }
  }

  Future<bool> authenticate(BuildContext context) {
    return auth.authenticate(
        localizedReason: appLocalizations(context)
            .enterPhoneScreenLockPatternPINPasswordOrFingerprint,
        authMessages: [
          AndroidAuthMessages(
            signInTitle: appLocalizations(context).unlockBCTPay,
            // cancelButton: appLocalizations(context).noThanks,
          ),
          const IOSAuthMessages(
              // cancelButton: appLocalizations(context).noThanks,
              ),
        ],
        options: const AuthenticationOptions(
            stickyAuth: true,
            useErrorDialogs: true,
            sensitiveTransaction: false));
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final screens = [
    const Dashboard(),
    const BeneficiaryListScreen(),
    const QRScanScreen(),
    const _MoreScreen(),
  ];

  final selectedItemColor = themeLogoColorBlue;
  final unselectedItemColor = Colors.black54;

  late final AppLifecycleListener _listener;

  List<NotificationData> notifications = [];

  @override
  void initState() {
    super.initState();
    profileBloc.stream.listen((state) {
      if (state is GetProfileState) {
        if (state.value.code == 200) {
          SharedPreferenceHelper.saveProfileData(state.value);
          if (state.value.data?.country != null) {
            getCountryWithCountryName(state.value.data!.country ?? "");
          }
        } else if (state.value.code ==
            HTTPResponseStatusCodes.sessionExpireCode) {
          if (!mounted) return;
          sessionExpired(state.value.message, context);
        } else {
          showToast(state.value.message);
        }
        notificationsListBloc
            .add(GetNotificationListEvent(limit: 10, page: 1, clear: true));
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fingerPrintConfiguration(context);
      profileBloc.add(GetProfileEvent());
      customerSettingBloc.add(CustomerSettingEvent());
    });
    firebase(context);
    onTokenReferesh();
    //DeveloperModeDetector.isEnabled(context);
    _listener = AppLifecycleListener(
      onShow: () {},
      onStateChange: (value) {},
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var iconColor = isDarkMode(context) ? Colors.white : Colors.black;

    return Stack(
      children: [
        PopScope(
          canPop: false,
          onPopInvokedWithResult: (onPop, result) async {
            onBackButtonPressed(context);
          },
          child: BlocBuilder(
              bloc: bottomNavigationBloc,
              builder: (context, state) {
                if (state is SelectIntState) {
                  int currentIndex = state.value;
                  return Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: backgroundColor,
                    appBar: CustomAppBar(
                        leading: IconButton(
                            key: drawerBtnKey,
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            icon: const Icon(Icons.menu)),
                        title: "",
                        titleWidget: const AppBarTitleWidget(),
                        centerTitle: true,
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.notifications,
                                    arguments: NotificationScreen(
                                      showAppbar: true,
                                    ));
                              },
                              icon: Stack(
                                children: [
                                  Icon(Icons.notifications_none_outlined),
                                  _badge()
                                ],
                              )),
                          if (currentIndex == 0)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ProfileQRCodeBtn(),
                            ),
                        ]),
                    drawer: const DrawerScreen(),
                    body: screens[currentIndex],
                    bottomNavigationBar: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor:
                          isDarkMode(context) ? themeColorHeader : Colors.white,
                      currentIndex: currentIndex,
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      onTap: (index) {
                        selectProfileCountry(context);
                        bottomNavigationBloc.add(SelectIntEvent(index));
                      },
                      selectedItemColor: selectedItemColor,
                      unselectedItemColor: unselectedItemColor,
                      items: [
                        BottomNavigationBarItem(
                          backgroundColor: themeColorHeader,
                          icon: Icon(Icons.home_rounded,
                              color: currentIndex == 0
                                  ? selectedItemColor
                                  : iconColor),
                          label: AppLocalizations.of(context)!.home,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.swap_horiz_rounded,
                              color: currentIndex == 1
                                  ? selectedItemColor
                                  : iconColor),
                          label: AppLocalizations.of(context)!.transfer,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.qr_code_scanner_rounded,
                              color: currentIndex == 2
                                  ? selectedItemColor
                                  : iconColor),
                          label: AppLocalizations.of(context)!.scan,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.more_horiz_rounded,
                              color: currentIndex == 3
                                  ? selectedItemColor
                                  : iconColor),
                          label: "More",
                        ),
                      ],
                    ),
                  );
                }
                return const Loader();
              }),
        ),
        if (dialogShowing) bCTPayIsLockedView()
      ],
    );
  }

  Widget _badge() {
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer(
        bloc: notificationsListBloc,
        listener: (context, state) {
          if (state is GetNotificationsListState) {
            if (state.value.code == 200) {
            } else if (state.value.code ==
                HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(state.value.message, context);
            }
          }
        },
        builder: (context, state) {
          if (state is GetNotificationsListState) {
            var notificationListData = state.value.data;
            var unreadNotificationCount =
                notificationListData?.unreadnotificationscount ?? 0;
            if (unreadNotificationCount == 0) {
              return const SizedBox.shrink();
            }
            return Positioned(
              child: Container(
                  margin: const EdgeInsets.only(left: 15, bottom: 0),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.8),
                      shape: BoxShape.circle),
                  child: Text(
                    unreadNotificationCount.toString(),
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            );
          }
          return const SizedBox.shrink();
        });
  }

  Widget bCTPayIsLockedView() => Positioned.fill(
        child: PopScope(
          canPop: false,
          child: Container(
            color: themeColorHeader,
            child: AlertDialog(
              title: Text(appLocalizations(context).bCTPayIsLocked),
              content: Text(appLocalizations(context)
                  .authenticationIsRequiredToAccessTheBCTPayApp),
              actions: [
                ElevatedButton(
                  child: Text(appLocalizations(context).unlockNow),
                  onPressed: () {
                    authenticate(context).then((didAuthenticate) {
                      if (didAuthenticate) {
                        dialogShowing = false;
                        setState(() {});
                      } else {
                        //Not authenticated
                        dialogShowing = true;
                        setState(() {});
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ),
      );
}
