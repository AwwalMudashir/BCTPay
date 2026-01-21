import 'package:bctpay/globals/index.dart';

class CountryPickerTxtFieldPrefix extends StatefulWidget {
  final SelectionBloc? selectPhoneCountryBloc;
  final bool? showPhoneCodeAlso;
  final bool readOnly;

  const CountryPickerTxtFieldPrefix(
      {super.key,
      this.showPhoneCodeAlso = false,
      this.readOnly = false,
      this.selectPhoneCountryBloc});

  @override
  State<CountryPickerTxtFieldPrefix> createState() =>
      _CountryPickerTxtFieldPrefixState();
}

class _CountryPickerTxtFieldPrefixState
    extends State<CountryPickerTxtFieldPrefix> {
  bool isOneCountry = false;

  bool checkIsOneCountry(List<CountryData> countries) {
    if (countries.length == 1) {
      isOneCountry = true;
    } else {
      isOneCountry = false;
    }
    return isOneCountry;
  }

  @override
  void initState() {
    super.initState();
    countryListBloc.add(CountryListEvent());
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocConsumer(
        bloc: countryListBloc,
        listener: (context, state) {
          if (state is CountryListState) {
            final code = state.value.code;
            if (code == "200" || code == "000" || code == "201") {
              var countries = state.value.data;
              setDefaultCountry(countries);
              checkIsOneCountry(countries);
            }
          }
        },
        builder: (context, state) {
          return InkWell(
            onTap: widget.readOnly
                ? null
                : () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor:
                          isDarkMode ? themeLogoColorBlue : Colors.white,
                      builder: (context) => CountryPickerView(
                        bloc: widget.selectPhoneCountryBloc,
                      ),
                    );
                  },
            child: BlocBuilder(
                bloc: widget.selectPhoneCountryBloc ?? selectCountryBloc,
                builder: (context, state) {
                  if (state is SelectCountryState) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: widget.showPhoneCodeAlso!
                          ? shadowDecoration.copyWith(
                              color: isDarkMode ? Colors.black : Colors.white)
                          : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations(context).countryCode,
                            style: textTheme.labelSmall
                                ?.copyWith(color: themeLogoColorOrange),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _FlagThumb(
                                flagPath: state.countryData.countryFlag,
                                countryCode: state.countryData.countryCode,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  "+${state.selectedCountry.phoneCode}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleSmall
                                      ?.copyWith(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    );
                  }
                  return const Loader();
                }),
          );
        });
  }
}

class _FlagThumb extends StatelessWidget {
  final String flagPath;
  final String countryCode;
  const _FlagThumb({required this.flagPath, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    if (countryCode.isNotEmpty) {
      return CountryFlag.fromCountryCode(
        countryCode,
        height: 30,
        width: 30,
        shape: const RoundedRectangle(4),
      );
    }
    final fullUrl = flagPath.startsWith('http')
        ? flagPath
        : (baseUrlCountryFlag.isNotEmpty ? "$baseUrlCountryFlag$flagPath" : "");
    if (fullUrl.isEmpty) {
      return const Icon(Icons.flag, color: Colors.grey);
    }
    return CachedNetworkImage(
      imageUrl: fullUrl,
      height: 30,
      width: 30,
      progressIndicatorBuilder: progressIndicatorBuilder,
      errorWidget: (c, o, s) => const Icon(
        Icons.flag,
        color: Colors.grey,
      ),
    );
  }
}
