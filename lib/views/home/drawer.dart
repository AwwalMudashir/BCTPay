import 'package:bctpay/globals/index.dart';
import 'package:flutter/cupertino.dart';

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
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                backgroundColor: backgroundColor,
                bottomNavigationBar: Container(
                  alignment: Alignment.center,
                  height: 90,
                  child: Column(
                    children: [
                      BlocConsumer(
                          bloc: selectThemeBloc,
                          listener: (context, state) {
                            if (state is SelectThemeState) {}
                          },
                          builder: (context, selectThemeState) {
                            if (selectThemeState is SelectThemeState) {
                              return ToggleButtons(
                                selectedBorderColor: themeLogoColorOrange,
                                fillColor: themeLogoColorOrange,
                                borderColor: themeLogoColorOrange,
                                borderRadius: BorderRadius.circular(20),
                                onPressed: (i) {
                                  isSelected =
                                      isSelected.map((e) => false).toList();
                                  isSelected[i] = true;
                                  selectThemeBloc.add(SelectThemeEvent(i == 0
                                      ? ThemeMode.dark
                                      : ThemeMode.light));
                                  customerSettingBloc.add(
                                      UpdateCustomerSettingEvent(
                                          themeColor:
                                              i == 0 ? "dark" : "light"));
                                },
                                isSelected: isSelected,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.dark_mode_outlined,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          appLocalizations(context).dark,
                                          style: textTheme.titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.light_mode,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          appLocalizations(context).light,
                                          style: textTheme.titleSmall
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const Loader();
                          }),
                      10.height,
                      FutureBuilder(
                        future: getAppVersionInfo(),
                        builder: (context, snapshot) => Text(
                          "${appLocalizations(context).version} ${snapshot.data?.version ?? ""}",
                          style:
                              textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ),
                      10.height
                    ],
                  ),
                ),
                body: ListView(
                  children: [
                    ProfilePicView(),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder(
                        bloc: getProfileDetailFromLocalBloc,
                        builder: (context, state) {
                          if (state is SharedPrefGetUserDetailState) {
                            var userName = state.user.userName;
                            var email = state.user.email;
                            return Column(
                              children: [
                                Text(
                                  userName,
                                  softWrap: true,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: textTheme.displayLarge,
                                ),
                                Text(email, style: textTheme.bodySmall),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    AccountMenu(
                      title: appLocalizations(context).accountDetailDrawer,
                      image: Assets.assetsImagesMenuPerson,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.profileDetails);
                      },
                    ),
                    AccountMenu(
                      title: appLocalizations(context).transactions,
                      icon: Icon(Icons.currency_exchange_outlined),
                      onTap: () {
                        bottomNavigationBloc.add(SelectIntEvent(2));
                        Navigator.pop(context);
                      },
                    ),
                    AccountMenu(
                      title: appLocalizations(context).paymentRequests,
                      image: Assets.assetsImagesSendMoney2,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.paymentRequests);
                      },
                    ),
                    AccountMenu(
                      title: appLocalizations(context).billsNSubscriptions,
                      icon: const Icon(Icons.blinds_closed),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.billsNSubscription);
                      },
                    ),
                    ExpansionMenu(
                      leading: Icon(Icons.settings_outlined),
                      title: Text(appLocalizations(context).settings),
                      children: [
                        BlocBuilder(
                            bloc: localizationBloc,
                            builder: (context, state) {
                              if (state is ChangeLocaleState) {
                                return AccountMenu(
                                  title: appLocalizations(context).language,
                                  prefix: CountryFlag.fromLanguageCode(
                                    state.locale.languageCode == "en"
                                        ? "en-us"
                                        : state.locale.languageCode,
                                    height: 20,
                                    width: 20,
                                  ),
                                  image: Assets.assetsImagesMenuLang,
                                  onTap: () {
                                    _showDialog(context);
                                  },
                                );
                              }
                              return const Loader();
                            }),
                        AccountMenu(
                          title: appLocalizations(context).security,
                          image: Assets.assetsImagesMenuSecurity,
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.webview,
                                arguments: CustomWebView(
                                  isAvailable: true,
                                  title: appLocalizations(context).security,
                                  url: securityWebUrl,
                                ));
                          },
                        ),
                        AccountMenu(
                          title: appLocalizations(context).privacyPolicy,
                          image: Assets.assetsImagesMenuPolicy,
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.webview,
                                arguments: CustomWebView(
                                  isAvailable: true,
                                  title:
                                      appLocalizations(context).privacyPolicy,
                                  url: privacyPolicyWebUrl,
                                ));
                          },
                        ),
                      ],
                    ),
                    ExpansionMenu(
                        leading: Icon(Icons.support_agent),
                        title: Text(appLocalizations(context).helpNSupport),
                        children: [
                          AccountMenu(
                            title: appLocalizations(context).faq,
                            image: Assets.assetsImagesMenuHelp,
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.faq);
                            },
                          ),
                          AccountMenu(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.queries);
                              },
                              title: appLocalizations(context).queries,
                              image: Assets.assetsImagesMenuPhone),
                        ]),
                    AccountMenu(
                      title: appLocalizations(context).logout,
                      image: Assets.assetsImagesMenuLogout,
                      onTap: () {
                        showLogoutDialog(context);
                      },
                    ),
                  ],
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

  void _showDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: isDarkMode(context) ? themeLogoColorBlue : Colors.white,
        child: SafeArea(
          top: false,
          child: BlocBuilder(
              bloc: localizationBloc,
              builder: (context, state) {
                if (state is ChangeLocaleState) {
                  return CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: 32,
                    scrollController: FixedExtentScrollController(
                      initialItem: supportedLocales.indexWhere(
                          (e) => e.languageCode == state.locale.languageCode),
                    ),
                    onSelectedItemChanged: (int selectedItem) {
                      var locale = supportedLocales[selectedItem];
                      localizationBloc.add(ChangeLocaleEvent(locale));
                      customerSettingBloc.add(UpdateCustomerSettingEvent(
                          language: locale.languageCode));
                    },
                    children: supportedLocales
                        .map((e) => Text(LanguageCodes.fromCode(e.languageCode)
                            .nativeName
                            .capitalize()))
                        .toList(),
                  );
                }
                return const Loader();
              }),
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
