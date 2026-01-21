import 'package:bctpay/globals/index.dart';

class CountryPickerView extends StatefulWidget {
  final SelectionBloc? bloc;
  const CountryPickerView({
    super.key,
    this.bloc,
  });

  @override
  State<CountryPickerView> createState() => _CountryPickerViewState();
}

class _CountryPickerViewState extends State<CountryPickerView> {
  var searchController = TextEditingController();

  List<CountryData> filteredCountries = [];

  @override
  void initState() {
    super.initState();
    countryListBloc.add(CountryListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: countryListBloc,
      listener: (context, countryListBlocState) {
        if (countryListBlocState is CountryListState) {
          var countries = countryListBlocState.value.data;
          filteredCountries = countries;
        }
      },
      builder: (context, countryListBlocState) {
        if (countryListBlocState is CountryListState) {
          var countries = countryListBlocState.value.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextField(
                  controller: searchController,
                  labelText: appLocalizations(context).country,
                  hintText: appLocalizations(context).enterCountry,
                  onChanged: (txt) {
                    filteredCountries = countries
                        .where((country) =>
                    country.countryName
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()) ||
                    ("+${country.phoneCode}")
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()))
                        .toList();
                    setState(() {});
                  },
                ),
                Expanded(
                  child: filteredCountries.isEmpty
                      ? Text(appLocalizations(context).noCountry)
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredCountries.length,
                          itemBuilder: (context, index) => CountryListItem(
                                bloc: widget.bloc,
                                country: filteredCountries[index],
                              )),
                ),
              ],
            ),
          );
        }
        return const Loader();
      },
    );
  }
}

class CountryListItem extends StatelessWidget {
  final CountryData country;
  final SelectionBloc? bloc;
  const CountryListItem({super.key, required this.country, this.bloc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        (bloc ?? selectCountryBloc).add(
            SelectCountryEvent(Country.parse(country.countryCode), country));
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _FlagThumb(
              flagPath: country.countryFlag,
              countryCode: country.countryCode,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                country.countryName,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "+${country.phoneCode}",
              style: const TextStyle(
                fontSize: 18,
                color: themeLogoColorOrange,
              ),
            ),
          ],
        ),
      ),
    );
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
