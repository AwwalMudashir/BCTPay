import 'package:bctpay/globals/index.dart';

class StatePickerView extends StatefulWidget {
  final SelectionBloc bloc;

  const StatePickerView({
    super.key,
    required this.bloc,
  });

  @override
  State<StatePickerView> createState() => _StatePickerViewState();
}

class _StatePickerViewState extends State<StatePickerView> {
  var stateCityListBloc = ApisBloc(ApisBlocInitialState());
  var searchController = TextEditingController();

  List<StateData> filteredStates = [];

  @override
  void initState() {
    super.initState();
    stateCityListBloc.add(GetStateCitiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: stateCityListBloc,
      listener: (context, state) {
        if (state is GetStateCitiesState) {
          var states = state.value.data ?? [];
          filteredStates = states;
        }
      },
      builder: (context, state) {
        if (state is GetStateCitiesState) {
          var states = state.value.data ?? [];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextField(
                  controller: searchController,
                  labelText: appLocalizations(context).state,
                  hintText: appLocalizations(context).searchHere,
                  onChanged: (txt) {
                    filteredStates = states
                        .where((e) =>
                            e.state?.toLowerCase().contains(
                                searchController.text.toLowerCase()) ??
                            false)
                        .toList();
                    setState(() {});
                  },
                ),
                Expanded(
                  child: filteredStates.isEmpty
                      ? Text(appLocalizations(context).noData)
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredStates.length,
                          itemBuilder: (context, index) => StateListItem(
                                bloc: widget.bloc,
                                state: filteredStates[index],
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

class StateListItem extends StatelessWidget {
  final StateData state;
  final SelectionBloc bloc;

  const StateListItem({super.key, required this.state, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bloc.add(SelectStateEvent(state));
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                state.state ?? "",
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
