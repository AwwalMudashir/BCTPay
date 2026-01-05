import 'package:bctpay/globals/index.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NetworkBloc(),
        ),
        BlocProvider(
          create: (context) => ApisBloc(ApisBlocInitialState()),
        )
      ],
      child: BlocListener(
        bloc: customerSettingBloc,
        listener: (context, state) {
          if (state is UpdateCustomerSettingState) {
            if (state.value.code == 200) {
              if (state.value.data != null &&
                  state.value.data!.language != null &&
                  state.value.data!.language != "") {
                customerSettingBloc.add(CustomerSettingEvent());
              }
            } else if (state.value.code ==
                HTTPResponseStatusCodes.sessionExpireCode) {}
          }
          if (state is CustomerSettingState) {
            if (state.value.code == 200) {
              if (state.value.data != null &&
                  state.value.data!.language != null &&
                  state.value.data!.language != "") {
                selectedLanguage = state.value.data!.language ?? "fr";
                currencyTextInputFormatter =
                    CurrencyTextInputFormatter.currency(
                  locale: "${selectedLanguage}_${selectedCountry?.countryCode}",
                  decimalDigits: 2,
                  symbol: "", //selectedCountry?.currencySymbol,
                  enableNegative: false,
                );
                localizationBloc.add(ChangeLocaleEvent(Locale(
                    state.value.data!.language!, selectedLocale.countryCode)));
                var themeColor = state.value.data?.themeColor ?? "dark";
                selectThemeBloc.add(SelectThemeEvent(
                    themeColor == "light" ? ThemeMode.light : ThemeMode.dark));
              }
            } else if (state.value.code ==
                HTTPResponseStatusCodes.sessionExpireCode) {
              SharedPreferenceHelper.getLanguage().then((languageCode) {
                if (languageCode != null) {
                  localizationBloc.add(ChangeLocaleEvent(
                      Locale(languageCode, selectedLocale.countryCode)));
                } else {
                  localizationBloc.add(ChangeLocaleEvent(
                      Locale(selectedLanguage, selectedLocale.countryCode)));
                }
              });
            }
          }
        },
        child: BlocConsumer(
            bloc: localizationBloc,
            listener: (context, state) {
              if (state is ChangeLocaleState) {
                selectedLanguage = state.locale.languageCode;
                SharedPreferenceHelper.setLanguage(state.locale.languageCode);
              }
            },
            builder: (context, state) {
              if (state is ChangeLocaleState) {
                return BlocBuilder(
                    bloc: selectThemeBloc,
                    builder: (context, selectThemeState) {
                      if (selectThemeState is SelectThemeState) {
                        var themeMode = selectThemeState.themeMode;
                        return MaterialApp(
                          themeMode: themeMode,
                          debugShowCheckedModeBanner: false,
                          title: projectName,
                          theme: lightTheme(),
                          darkTheme: darkTheme(),
                          locale: state.locale,
                          localizationsDelegates: localizationsDelegates,
                          supportedLocales: supportedLocales,
                          initialRoute: AppRoutes.splash,
                          routes: routes,
                          onUnknownRoute: (RouteSettings settings) {
                            return MaterialPageRoute(
                              settings: settings,
                              builder: (BuildContext context) => Scaffold(
                                  appBar: const CustomAppBar(title: ""),
                                  body: Center(
                                      child: Text(
                                          appLocalizations(context).notFound))),
                            );
                          },
                        );
                      }
                      return const Loader();
                    });
              }
              return const Loader();
            }),
      ),
    );
  }
}
