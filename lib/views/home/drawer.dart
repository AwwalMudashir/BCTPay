import 'package:bctpay/globals/index.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    isSelected = isSelected.map((e) => false).toList();
    isSelected[isDarkMode ? 0 : 1] = true;
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return BlocListener(
      bloc: profileBloc,
      listener: (context, state) {
        if (state is UploadProfilePicState) {
          if (state.value.code == 200) {
            profileBloc.add(GetProfileEvent());
            if (mounted) {
              showSuccessDialog(
                  state.value.message ?? state.value.error ?? "", context);
            }
          } else if (state.value.code ==
              HTTPResponseStatusCodes.sessionExpireCode) {
            if (mounted) {
              sessionExpired(
                  state.value.message ?? state.value.error ?? "", context);
            }
          } else {
            if (mounted) {
              showFailedDialog(
                  state.value.message ?? state.value.error ?? "", context);
            }
          }
        }
        if (state is GetProfileState) {
          if (state.value.code == 200) {
            SharedPreferenceHelper.saveProfileData(state.value)
                .whenComplete(() {
              getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
            });
            if (state.value.data?.country != null) {
              getCountryWithCountryName(state.value.data!.country ?? "");
            }
          } else if (state.value.code ==
              HTTPResponseStatusCodes.sessionExpireCode) {
            if (mounted) sessionExpired(state.value.message, context);
          } else {
            showToast(state.value.message);
          }
        }
      },
      child: BlocListener(
        bloc: kycBloc,
        listener: (context, state) {},
        child: Stack(
          children: [
            Positioned(
              right: width * 0.2,
              left: 0,
              top: 0,
              bottom: 0,
              child: Scaffold(
                backgroundColor: const Color(0xFFF6F7F9),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // 4% of screen width
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder(
                          bloc: selectThemeBloc,
                          builder: (context, state) {
                            ThemeMode current = ThemeMode.light;
                            if (state is SelectThemeState) {
                              current = state.themeMode;
                            }
                            return _card([
                              _sectionTitle(textTheme, appLocalizations(context).theme),
                              const SizedBox(height: 12),
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
                                ],
                              )
                            ]);
                          }),
                      const SizedBox(height: 12),
                      FutureBuilder(
                        future: getAppVersionInfo(),
                        builder: (context, snapshot) => Text(
                          "${appLocalizations(context).version} ${snapshot.data?.version ?? ""}",
                          style: textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // 4% of screen width
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Section
                        _card([
                          Row(
                            children: [
                              ProfilePicView(),
                              const SizedBox(width: 12),
                              Expanded(
                                child: BlocBuilder(
                                    bloc: getProfileDetailFromLocalBloc,
                                    builder: (context, state) {
                                      if (state is SharedPrefGetUserDetailState) {
                                        var userName = state.user.userName;
                                        var email = state.user.email;
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userName,
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              email,
                                              style: textTheme.bodySmall?.copyWith(
                                                color: Colors.grey.shade600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    }),
                              ),
                            ],
                          ),
                        ]),
                        const SizedBox(height: 20),

                        // Account Section
                        _card([
                          _sectionTitle(textTheme, appLocalizations(context).account),
                          const SizedBox(height: 8),
                          _drawerTile(
                            context,
                            icon: Icons.account_balance_wallet_rounded,
                            title: appLocalizations(context).profile,
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.accountDetail),
                          ),
                          _divider(),
                          _drawerTile(
                            context,
                            icon: Icons.receipt_long_rounded,
                            title: appLocalizations(context).transactions,
                            onTap: () {
                              bottomNavigationBloc.add(SelectIntEvent(2));
                              Navigator.pop(context);
                            },
                          ),
                          _divider(),
                          _drawerTile(
                            context,
                            icon: Icons.request_page_rounded,
                            title: appLocalizations(context).paymentRequests,
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.paymentRequests),
                          ),
                          _divider(),
                          _drawerTile(
                            context,
                            icon: Icons.subscriptions_rounded,
                            title: appLocalizations(context).billsNSubscriptions,
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.billsNSubscription),
                          ),
                        ]),
                        const SizedBox(height: 12),

                        // Settings Section
                        _card([
                          _sectionTitle(textTheme, appLocalizations(context).settings),
                          const SizedBox(height: 8),
                          BlocBuilder(
                              bloc: localizationBloc,
                              builder: (context, state) {
                                Locale currentLocale = const Locale('en');
                                if (state is ChangeLocaleState) {
                                  currentLocale = state.locale;
                                }
                                return Column(
                                  children: [
                                    _sectionTitle(textTheme, appLocalizations(context).language),
                                    const SizedBox(height: 12),
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
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                );
                              }),
                          _drawerTile(
                            context,
                            icon: Icons.security_rounded,
                            title: appLocalizations(context).security,
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.webview,
                                arguments: CustomWebView(
                                  isAvailable: true,
                                  title: appLocalizations(context).security,
                                  url: securityWebUrl,
                                )),
                          ),
                          _divider(),
                          _drawerTile(
                            context,
                            icon: Icons.policy_rounded,
                            title: appLocalizations(context).privacyPolicy,
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.webview,
                                arguments: CustomWebView(
                                  isAvailable: true,
                                  title: appLocalizations(context).privacyPolicy,
                                  url: privacyPolicyWebUrl,
                                )),
                          ),
                        ]),
                        const SizedBox(height: 12),

                        // Help & Support Section
                        _card([
                          _sectionTitle(textTheme, appLocalizations(context).helpNSupport),
                          const SizedBox(height: 8),
                          _drawerTile(
                            context,
                            icon: Icons.help_outline_rounded,
                            title: appLocalizations(context).faq,
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.faq),
                          ),
                          _divider(),
                          _drawerTile(
                            context,
                            icon: Icons.support_agent_rounded,
                            title: appLocalizations(context).queries,
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.queries),
                          ),
                        ]),
                        const SizedBox(height: 12),

                        // Logout Section
                        _card([
                          _drawerTile(
                            context,
                            icon: Icons.logout_rounded,
                            title: appLocalizations(context).logout,
                            isDestructive: true,
                            isLogout: true,
                            onTap: () => showLogoutDialog(context),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: width * 0.2 - 20,
              top: 50,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CloseIcon(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _sectionTitle(TextTheme textTheme, String title) {
    return Text(
      title,
      style: textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  Widget _drawerTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? prefix,
    bool isDestructive = false,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isLogout ? 12 : 8, horizontal: isLogout ? 4 : 0),
        margin: EdgeInsets.symmetric(vertical: isLogout ? 4 : 0),
        decoration: isLogout ? BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200, width: 1),
        ) : null,
        child: Row(
          children: [
            Container(
              width: isLogout ? 40 : 32,
              height: isLogout ? 40 : 32,
              decoration: BoxDecoration(
                color: (isDestructive || isLogout)
                    ? Colors.red.shade100
                    : themeLogoColorBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: (isDestructive || isLogout) ? Border.all(color: Colors.red.shade300, width: 1) : null,
              ),
              child: Icon(
                icon,
                size: isLogout ? 22 : 18,
                color: (isDestructive || isLogout) ? Colors.red.shade700 : themeLogoColorBlue,
              ),
            ),
            const SizedBox(width: 12),
            if (prefix != null) ...[
              prefix,
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: (isDestructive || isLogout) ? Colors.red.shade700 : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1, color: Color(0xFFE5E7EB)),
    );
  }

  Widget _themeChip(
    TextTheme textTheme, {
    required ThemeMode mode,
    required ThemeMode current,
    required String label,
  }) {
    final isSelected = mode == current;
    return Expanded(
      child: InkWell(
        onTap: () {
          selectThemeBloc.add(SelectThemeEvent(mode));
          customerSettingBloc.add(UpdateCustomerSettingEvent(
            themeColor: mode == ThemeMode.dark ? "dark" : "light",
          ));
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? themeLogoColorBlue.withValues(alpha: 0.2)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isSelected
                    ? themeLogoColorBlue
                    : Colors.grey.shade300,
                width: isSelected ? 1.5 : 0.8),
            boxShadow: isSelected ? [
              BoxShadow(
                color: themeLogoColorBlue.withValues(alpha: 0.3),
                blurRadius: 6,
                spreadRadius: 0.5,
                offset: const Offset(0, 1),
              )
            ] : null,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? themeLogoColorBlue : Colors.black87,
                  ),
                ),
                if (isSelected) ...[
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
      ),
    );
  }

  Widget _languageChip(TextTheme textTheme,
      {required Locale locale,
      required Locale current,
      required String label,
      required String flagCode}) {
    final isSelected = current.languageCode == locale.languageCode;
    return Expanded(
      child: InkWell(
        onTap: () {
          localizationBloc.add(ChangeLocaleEvent(locale));
          customerSettingBloc.add(UpdateCustomerSettingEvent(
              language: locale.languageCode));
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? themeLogoColorBlue.withValues(alpha: 0.2)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isSelected
                    ? themeLogoColorBlue
                    : Colors.grey.shade300,
                width: isSelected ? 1.5 : 0.8),
            boxShadow: isSelected ? [
              BoxShadow(
                color: themeLogoColorBlue.withValues(alpha: 0.3),
                blurRadius: 6,
                spreadRadius: 0.5,
                offset: const Offset(0, 1),
              )
            ] : null,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CountryFlag.fromCountryCode(
                  flagCode,
                  height: 12,
                  width: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? themeLogoColorBlue : Colors.black87,
                    fontSize: 11,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 2),
                  Icon(
                    Icons.check_circle,
                    size: 12,
                    color: themeLogoColorBlue,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountMenu extends StatelessWidget {
  final String title;
  final String? image;
  final Widget? icon;
  final void Function()? onTap;
  final Widget? suffix;
  final Widget? prefix;
  final bool enableBorder;

  const AccountMenu(
      {super.key,
      required this.title,
      this.image,
      this.icon,
      this.onTap,
      this.suffix,
      this.prefix,
      this.enableBorder = false});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 1.5, color: Colors.grey.withValues(alpha: 0.1)),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              padding: EdgeInsets.all(enableBorder ? 1 : 4),
              decoration: enableBorder
                  ? BoxDecoration(
                      border: Border.all(
                          color: isDarkMode ? Colors.white : Colors.black,
                          width: 1.2),
                      borderRadius: BorderRadius.circular(5))
                  : null,
              child: prefix ??
                  icon ??
                  Image.asset(
                    image ?? "",
                    fit: BoxFit.contain,
                    color: isDarkMode ? Colors.white : Colors.black,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error),
                  ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: Text(title, style: textTheme.titleSmall)),
            if (suffix != null) suffix!
          ],
        ),
      ),
    );
  }
}
