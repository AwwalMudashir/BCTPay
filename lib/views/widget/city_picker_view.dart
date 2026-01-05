import 'package:bctpay/globals/index.dart';

class CityPickerView extends StatefulWidget {
  final SelectionBloc bloc;
  final StateData? selectedState;

  const CityPickerView({
    super.key,
    required this.bloc,
    required this.selectedState,
  });

  @override
  State<CityPickerView> createState() => _CityPickerViewState();
}

class _CityPickerViewState extends State<CityPickerView> {
  var searchController = TextEditingController();

  List<String> filteredCities = [];

  List<String> cities = [];

  @override
  void initState() {
    super.initState();
    cities = widget.selectedState?.cities ?? [];
    filteredCities = cities
        .where((e) =>
            e.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomTextField(
            controller: searchController,
            labelText: appLocalizations(context).city,
            hintText: appLocalizations(context).searchHere,
            onChanged: (txt) {
              filteredCities = cities
                  .where((e) => e
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()))
                  .toList();
              setState(() {});
            },
          ),
          Expanded(
            child: filteredCities.isEmpty
                ? Text(appLocalizations(context).noData)
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) => CityListItem(
                          bloc: widget.bloc,
                          city: filteredCities[index],
                        )),
          ),
        ],
      ),
    );
  }
}

class CityListItem extends StatelessWidget {
  final String city;
  final SelectionBloc bloc;

  const CityListItem({super.key, required this.city, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bloc.add(SelectStringEvent(city));
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                city,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
