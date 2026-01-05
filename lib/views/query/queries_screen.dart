import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:flutter/cupertino.dart';

class QueriesScreen extends StatefulWidget {
  const QueriesScreen({super.key});

  @override
  State<QueriesScreen> createState() => _QueriesScreenState();
}

class _QueriesScreenState extends State<QueriesScreen> {
  int page = 1;
  int limit = 10;
  final queriesListBloc = ApisBloc(ApisBlocInitialState());

  final searchController = TextEditingController();
  var searchBloc = SelectionBloc(SelectStringState(""));
  var selectQueryTypesBloc = SelectionBloc(SelectStringState(""));
  var selectPaymentTypeBloc = SelectionBloc(SelectStringState(""));
  var selectPaymentBloc = SelectionBloc(SelectStringState(""));
  var selectDateRangeBloc = SelectionBloc(SelectionBlocInitialState());

  List<String>? queryTypes = [];
  List<String>? paymentTypeList = [];
  List<String>? paymentList = [];

  DateTimeRange? selectedDateTimeRange;

  List<Query> queries = [];

  @override
  void initState() {
    applyFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: appLocalizations(context).queryHistory),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: themeColorHeader,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.contactUs);
            }),
        body: BlocConsumer(
            bloc: queriesListBloc,
            listener: (context, state) {
              if (state is GetQueriesState) {
                var code = state.value.code;
                if (code == 200) {
                  queries = state.value.data?.querieslist ?? [];
                } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message ?? "", context);
                } else {
                  showFailedDialog(state.value.message ?? "", context);
                }
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  CustomTextField(
                    controller: searchController,
                    labelText: AppLocalizations.of(context)!.search,
                    hintText: AppLocalizations.of(context)!.searchHere,
                    prefix: const Icon(
                      CupertinoIcons.search,
                      color: Color.fromRGBO(158, 158, 158, 1),
                    ),
                    suffix: BlocListener(
                      bloc: selectPaymentTypeBloc,
                      listener: (context, state) {
                        if (state is SelectStringState) {
                          if (state.isSelected ?? false) {
                            paymentTypeList?.add(state.value!);
                          } else {
                            paymentTypeList?.remove(state.value!);
                          }
                          applyFilter();
                        }
                      },
                      child: BlocListener(
                        bloc: selectPaymentBloc,
                        listener: (context, state) {
                          if (state is SelectStringState) {
                            if (state.isSelected ?? false) {
                              paymentList?.add(state.value!);
                            } else {
                              paymentList?.remove(state.value!);
                            }
                            applyFilter();
                          }
                        },
                        child: BlocConsumer(
                            bloc: selectQueryTypesBloc,
                            listener: (context, state) {
                              if (state is SelectStringState) {
                                if (state.isSelected ?? false) {
                                  queryTypes?.add(state.value!);
                                } else {
                                  queryTypes?.remove(state.value!);
                                }
                                applyFilter();
                              }
                            },
                            builder: (context, state) {
                              if (state is SelectStringState) {
                                return BlocConsumer(
                                    bloc: selectDateRangeBloc,
                                    listener: (context, state) {
                                      if (state is SelectDateRangeState) {
                                        selectedDateTimeRange = state.value;
                                        applyFilter();
                                      }
                                    },
                                    builder: (context, state) {
                                      return FilterQueriesBtn(
                                        selectDateRangeBloc:
                                            selectDateRangeBloc,
                                        selectQueryTypesBloc:
                                            selectQueryTypesBloc,
                                        selectPaymentBloc: selectPaymentBloc,
                                        selectPaymentTypeBloc:
                                            selectPaymentTypeBloc,
                                        filter: QueryFilterModel(
                                            name: searchController.text,
                                            queryTypes: queryTypes,
                                            date: DateFilter(
                                              start:
                                                  selectedDateTimeRange?.start,
                                              end: selectedDateTimeRange?.end,
                                            )),
                                      );
                                    });
                              }
                              return Loader();
                            }),
                      ),
                    ),
                    onChanged: (p0) {
                      searchBloc.add(SelectStringEvent(p0));
                    },
                  ),
                  BlocConsumer(
                      bloc: searchBloc,
                      listener: (context, state) {
                        if (state is SelectStringState) {
                          applyFilter();
                        }
                      },
                      builder: (context, searchState) {
                        if (queries.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                appLocalizations(context).noQueryMessage,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        return Expanded(
                          child: AnimationLimiter(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: queries.length,
                              itemBuilder: (context, index) => ListAnimation(
                                index: index,
                                child: QueryListItem(
                                  query: queries[index],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              );
            }));
  }

  void applyFilter({bool isSearching = true}) {
    if (isSearching) {
      page = 1;
    }
    QueryFilterModel? filter = QueryFilterModel(
        name: searchController.text,
        queryTypes: queryTypes,
        date: DateFilter(
            start: selectedDateTimeRange?.start,
            end: selectedDateTimeRange?.end));
    queriesListBloc.add(GetQueriesEvent(
        limit: limit,
        page: page,
        filter: filter,
        fromAnotherScreen: isSearching));
  }
}
