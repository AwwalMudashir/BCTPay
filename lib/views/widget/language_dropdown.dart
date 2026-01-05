import 'package:bctpay/globals/index.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({super.key});

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.selectLanguage,
        centerTitle: true,
      ),
      body: const LanguageWidget(),
    );
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: localizationBloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              underline: const SizedBox(),
              value: Locale((state as ChangeLocaleState).locale.languageCode),
              items: supportedLocales
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          CountryFlag.fromLanguageCode(
                            e.languageCode == "en" ? "en-us" : e.languageCode,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            LanguageCodes.fromCode(e.languageCode)
                                .nativeName
                                .capitalize(),
                            style: const TextStyle(
                                // color: Colors.white,
                                ),
                          ),
                        ],
                      )))
                  .toList(),
              onChanged: (locale) {
                localizationBloc.add(ChangeLocaleEvent(locale!));
                customerSettingBloc.add(
                    UpdateCustomerSettingEvent(language: locale.languageCode));
              },
            ),
          );
        });
  }
}
