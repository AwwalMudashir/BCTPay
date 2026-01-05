import 'package:bctpay/lib.dart';

class FilterQueriesScreen extends StatelessWidget {
  final SelectionBloc? selectQueryTypesBloc;

  final SelectionBloc? selectPaymentTypeBloc;

  final SelectionBloc? selectPaymentBloc;

  final SelectionBloc? selectDateRangeBloc;
  final QueryFilterModel? filter;

  const FilterQueriesScreen({
    super.key,
    this.selectQueryTypesBloc,
    this.selectPaymentTypeBloc,
    this.selectPaymentBloc,
    this.selectDateRangeBloc,
    this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).filter),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [
          _filterByQueryType(context),
          10.height,
          _filterByDate(context),
          10.height,
          Row(
            children: [
              Expanded(
                  child: CustomBtn(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: appLocalizations(context).applyQueriesFilter)),
              5.width,
              Expanded(
                child: CustomBtn(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                  text: appLocalizations(context).cancel,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _filterByQueryType(BuildContext context) {
    var arg = args(context) as FilterQueriesScreen;
    var queryTypeListBloc = ApisBloc(ApisBlocInitialState())
      ..add(GetTypeOfQueriesEvent());
    return Container(
      padding: EdgeInsets.all(10),
      decoration: shadowDecoration.copyWith(
          color: isDarkMode(context) ? themeLogoColorBlue : Colors.white),
      child: BlocBuilder(
          bloc: arg.selectQueryTypesBloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations(context).queryType,
                ),
                BlocBuilder(
                    bloc: queryTypeListBloc,
                    builder: (context, queryTypeListState) {
                      if (queryTypeListState is GetTypeOfQueriesState) {
                        var types = queryTypeListState.value.data ?? [];
                        return Wrap(
                          spacing: 5,
                          children: types
                              .map((e) => ChoiceChip.elevated(
                                  onSelected: (value) {
                                    arg.selectQueryTypesBloc?.add(
                                        SelectStringEvent(e.typeOfQueriesEn,
                                            isSelected: value));
                                  },
                                  label: Text(selectedLanguage == "en"
                                      ? e.typeOfQueriesEn ?? ""
                                      : e.typeOfQueriesGn ?? ""),
                                  selected: arg.filter?.queryTypes
                                          ?.contains(e.typeOfQueriesEn) ??
                                      false))
                              .toList(),
                        );
                      }
                      return Loader();
                    }),
              ],
            );
          }),
    );
  }

  Container _filterByDate(BuildContext context) {
    var arg = args(context) as FilterQueriesScreen;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: shadowDecoration.copyWith(
          color: isDarkMode(context) ? themeLogoColorBlue : Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations(context).dueDate,
          ),
          TextButton(
              onPressed: () {
                showDateRangePicker(
                        context: context,
                        initialDateRange: (arg.filter?.date?.start == null &&
                                arg.filter?.date?.end == null)
                            ? null
                            : DateTimeRange(
                                start: arg.filter!.date!.start!,
                                end: arg.filter!.date!.end!,
                              ),
                        firstDate: DateTime(2025),
                        lastDate: DateTime.now())
                    .then((selectedDate) {
                  if (selectedDate != null) {
                    arg.selectDateRangeBloc
                        ?.add(SelectDateRangeEvent(selectedDate));
                  }
                });
              },
              child: Column(
                children: [
                  BlocConsumer(
                      bloc: arg.selectDateRangeBloc,
                      listener: (context, state) {
                        if (state is SelectDateRangeState) {}
                      },
                      builder: (context, state) {
                        if (state is SelectDateRangeState &&
                            state.value != null) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${state.value?.start.formatValidityDateTime()} - ${state.value?.end.formatValidityDateTime()}"),
                              IconButton(
                                onPressed: () {
                                  arg.selectDateRangeBloc
                                      ?.add(SelectDateRangeEvent(null));
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          );
                        }
                        return Text(appLocalizations(context).selectDate);
                      }),
                ],
              ))
        ],
      ),
    );
  }
}
