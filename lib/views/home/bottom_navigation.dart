import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';

var bottomNavigationBloc = SelectionBloc(SelectIntState(0));

class _MoreScreen extends StatefulWidget {
  const _MoreScreen();

  @override
  State<_MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<_MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final bg = const Color(0xFFF6F7F9);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // 4% of screen width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations(context).moreTitle,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              _card([
                _moreTile(
                  context,
                  icon: Icons.account_balance_wallet_rounded,
                  title: appLocalizations(context).profile,
                  subtitle: appLocalizations(context).profile,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.accountDetail),
                ),
                _divider(),
                _moreTile(
                  context,
                  icon: Icons.receipt_long_rounded,
                  title: appLocalizations(context).transactions,
                  subtitle: appLocalizations(context).transactionHistoryTitle,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.transactionhistory),
                ),
                _divider(),
                _moreTile(
                  context,
                  icon: Icons.request_page_rounded,
                  title: appLocalizations(context).paymentRequests,
                  subtitle: appLocalizations(context).paymentRequests,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.paymentRequests),
                ),
                _divider(),
                _moreTile(
                  context,
                  icon: Icons.subscriptions_rounded,
                  title: appLocalizations(context).billsNSubscriptions,
                  subtitle: appLocalizations(context).billsNSubscriptions,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.billsNSubscription),
                ),
                _divider(),
                _moreTile(
                  context,
                  icon: Icons.settings_rounded,
                  title: appLocalizations(context).settings,
                  subtitle: appLocalizations(context).settings,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.language),
                ),
                _divider(),
                _moreTile(
                  context,
                  icon: Icons.headset_mic_rounded,
                  title: appLocalizations(context).contactUs,
                  subtitle: appLocalizations(context).helpSupport,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.contactUs),
                ),
              ]),
              const SizedBox(height: 12),
              BlocBuilder(
                  bloc: selectThemeBloc,
                  builder: (context, state) {
                    ThemeMode current = ThemeMode.light;
                    if (state is SelectThemeState) {
                      current = state.themeMode;
                    }
                    return _card([
                      _sectionTitle(textTheme, appLocalizations(context).theme),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _themeChip(
                            textTheme,
                            mode: ThemeMode.light,
                            current: current,
                            label: appLocalizations(context).light,
                          ),
                          _themeChip(
                            textTheme,
                            mode: ThemeMode.dark,
                            current: current,
                            label: appLocalizations(context).dark,
                          ),
                          _themeChip(
                            textTheme,
                            mode: ThemeMode.system,
                            current: current,
                            label: appLocalizations(context).themeAuto,
                          ),
                        ],
                      )
                    ]);
                  }),
              const SizedBox(height: 12),
              BlocBuilder(
                  bloc: localizationBloc,
                  builder: (context, state) {
                    Locale currentLocale = const Locale('en');
                    if (state is ChangeLocaleState) {
                      currentLocale = state.locale;
                    }
                    return _card([
                      _sectionTitle(textTheme, appLocalizations(context).language),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _languageChip(
                            textTheme,
                            locale: const Locale('en'),
                            current: currentLocale,
                            label: 'English',
                            flagCode: 'us',
                          ),
                          _languageChip(
                            textTheme,
                            locale: const Locale('fr'),
                            current: currentLocale,
                            label: 'Français',
                            flagCode: 'fr',
                          ),
                        ],
                      )
                    ]);
                  }),
              const SizedBox(height: 12),
              _card([
                _moreTile(
                  context,
                  icon: Icons.logout_rounded,
                  title: appLocalizations(context).logout,
                  subtitle: "",
                  isDestructive: true,
                  isLogout: true,
                  onTap: () => showLogoutDialog(context),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 6))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _moreTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap,
      bool isDestructive = false,
      bool isLogout = false}) {
    final textTheme = Theme.of(context).textTheme;
    final iconBg = isLogout ? Colors.red.shade100 : themeLogoColorBlue.withValues(alpha: 0.12);
    final iconColor = isLogout ? Colors.red.shade700 : themeLogoColorBlue;
    final textColor = (isDestructive || isLogout) ? Colors.red.shade700 : Colors.black87;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isLogout ? 16 : 12, horizontal: isLogout ? 8 : 0),
        margin: EdgeInsets.symmetric(vertical: isLogout ? 4 : 0),
        decoration: isLogout ? BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200, width: 1),
        ) : null,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: iconBg,
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700, color: textColor)),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: textTheme.bodySmall
                          ?.copyWith(color: Colors.grey.shade700, height: 1.3),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: Colors.grey, size: 20)
          ],
        ),
      ),
    );
  }

  Widget _divider() => Divider(height: 1, color: Colors.grey.shade200);

  Widget _sectionTitle(TextTheme textTheme, String title) => Text(
        title,
        style:
            textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      );

  Widget _themeChip(TextTheme textTheme,
      {required ThemeMode mode,
      required ThemeMode current,
      required String label}) {
    final selected = current == mode;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          selectThemeBloc.add(SelectThemeEvent(mode));
          customerSettingBloc.add(UpdateCustomerSettingEvent(
              themeColor: mode == ThemeMode.dark
                  ? "dark"
                  : mode == ThemeMode.light
                      ? "light"
                      : "auto"));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: selected
                ? themeLogoColorBlue.withValues(alpha: 0.2)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: selected
                    ? themeLogoColorBlue
                    : Colors.grey.shade300,
                width: selected ? 2 : 1),
            boxShadow: selected ? [
              BoxShadow(
                color: themeLogoColorBlue.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              )
            ] : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: selected ? themeLogoColorBlue : Colors.black87,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
              if (selected) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: themeLogoColorBlue,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageChip(TextTheme textTheme,
      {required Locale locale,
      required Locale current,
      required String label,
      required String flagCode}) {
    final selected = current.languageCode == locale.languageCode;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          localizationBloc.add(ChangeLocaleEvent(locale));
          customerSettingBloc.add(UpdateCustomerSettingEvent(
              language: locale.languageCode));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: selected
                ? themeLogoColorBlue.withValues(alpha: 0.2)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: selected
                    ? themeLogoColorBlue
                    : Colors.grey.shade300,
                width: selected ? 2 : 1),
            boxShadow: selected ? [
              BoxShadow(
                color: themeLogoColorBlue.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              )
            ] : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountryFlag.fromCountryCode(
                flagCode,
                height: 16,
                width: 16,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: selected ? themeLogoColorBlue : Colors.black87,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
              if (selected) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: themeLogoColorBlue,
                ),
              ],
            ],
          ),
        ),
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
    const Dashboard(), // Index tab - same content as Home
  ];

  final selectedItemColor = themeLogoColorBlue;
  final unselectedItemColor = Colors.grey;

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
          // Avoid force logout on profile fetch mismatch; keep user in-app
          showToast(state.value.message);
        } else {
          showToast(state.value.message);
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fingerPrintConfiguration(context);
      // Disabled legacy profile & setting fetch to avoid "Invalid token" from legacy base
      // profileBloc.add(GetProfileEvent());
      // customerSettingBloc.add(CustomerSettingEvent());
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
    return Stack(
      children: [
        PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            // Defer dialog to avoid Navigator re-entrancy during pop handling
            Future.microtask(() => onBackButtonPressed(context));
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
                                Navigator.pushNamed(context, AppRoutes.myQr);
                              },
                              icon: const Icon(Icons.qr_code_2_rounded)),
                        ]),
                    drawer: const DrawerScreen(),
                    body: screens[currentIndex],
                    bottomNavigationBar: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(20, 0, 0, 0),
                            blurRadius: 6,
                            offset: Offset(0, -1),
                          ),
                        ],
                      ),
                      child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                        backgroundColor: Colors.white,
                        elevation: 0,
                      currentIndex: currentIndex,
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                        selectedFontSize: 12,
                        unselectedFontSize: 12,
                      onTap: (index) {
                        selectProfileCountry(context);
                        bottomNavigationBloc.add(SelectIntEvent(index));
                      },
                        selectedItemColor: themeLogoColorBlue,
                        unselectedItemColor: Colors.grey,
                      items: [
                        BottomNavigationBarItem(
                            icon: const Icon(Icons.home_rounded),
                          label: AppLocalizations.of(context)!.home,
                        ),
                        BottomNavigationBarItem(
                            icon: const Icon(Icons.swap_horiz_rounded),
                          label: AppLocalizations.of(context)!.transfer,
                        ),
                        BottomNavigationBarItem(
                            icon: const Icon(Icons.qr_code_scanner_rounded),
                          label: AppLocalizations.of(context)!.scan,
                        ),
                        BottomNavigationBarItem(
                            icon: const Icon(Icons.more_horiz_rounded),
                          label: "More",
                        ),
                      ],
                      ),
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

  Widget bCTPayIsLockedView() => Positioned.fill(
  child: PopScope(
    canPop: false,
    child: Container(
      color: Colors.black.withValues(alpha: 0.45), // translucent
      alignment: Alignment.center,
      child: AlertDialog(
        title: Text(appLocalizations(context).bCTPayIsLocked),
        content: Text(
          appLocalizations(context)
              .authenticationIsRequiredToAccessTheBCTPayApp,
        ),
        actions: [
          ElevatedButton(
            child: Text(appLocalizations(context).unlockNow),
            onPressed: () async {
              final ok = await authenticate(context);
              if (!mounted) return;
              setState(() {
                dialogShowing = !ok;
              });
            },
          )
        ],
      ),
    ),
  ),
);
}
