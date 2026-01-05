import 'package:bctpay/globals/index.dart';
import 'package:flutter/cupertino.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({super.key});

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  List<InvoiceData> invoiceList = [];
  int page = 1;
  int limit = 10;
  var invoiceListBloc = ApisBloc(ApisBlocInitialState());

  final searchController = TextEditingController();
  var searchBloc = SelectionBloc(SelectStringState(""));
  var selectPaymentStatusBloc = SelectionBloc(SelectStringState(""));
  var selectPaymentTypeBloc = SelectionBloc(SelectStringState(""));
  var selectPaymentBloc = SelectionBloc(SelectStringState(""));
  var selectDateRangeBloc = SelectionBloc(SelectionBlocInitialState());

  List<String>? paymentStatusList = [];
  List<String>? paymentTypeList = [];
  List<String>? paymentList = [];

  DateTimeRange? selectedDateTimeRange;

  @override
  void initState() {
    applyFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer(
        bloc: invoiceListBloc,
        listener: (context, state) {
          if (state is InvoiceListState) {
            var statusCode = state.value.code;
            if (statusCode == 200) {
              invoiceList = state.value.data?.invoicelist ?? [];
            } else if (statusCode ==
                HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(state.value.message, context);
            } else {
              showFailedDialog(state.value.message, context);
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
                        bloc: selectPaymentStatusBloc,
                        listener: (context, state) {
                          if (state is SelectStringState) {
                            if (state.isSelected ?? false) {
                              paymentStatusList?.add(state.value!);
                            } else {
                              paymentStatusList?.remove(state.value!);
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
                                  return FilterInvoiceBtn(
                                    selectDateRangeBloc: selectDateRangeBloc,
                                    selectPaymentStatusBloc:
                                        selectPaymentStatusBloc,
                                    selectPaymentBloc: selectPaymentBloc,
                                    selectPaymentTypeBloc:
                                        selectPaymentTypeBloc,
                                    filter: InvoiceFilterModel(
                                        name: searchController.text,
                                        paymentStatus: paymentStatusList,
                                        date: DateFilter(
                                          start: selectedDateTimeRange?.start,
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
              Expanded(
                child: BlocConsumer(
                    bloc: searchBloc,
                    listener: (context, state) {
                      if (state is SelectStringState) {
                        applyFilter();
                      }
                    },
                    builder: (context, searchState) {
                      if (invoiceList.isEmpty &&
                          state is ApisBlocLoadingState) {
                        return Loader();
                      } else if (invoiceList.isEmpty) {
                        return Center(
                            child: Text(appLocalizations(context).noData));
                      }
                      return AnimationLimiter(
                        child: ListView.builder(
                          itemCount: invoiceList.length,
                          itemBuilder: (context, index) => ListAnimation(
                              index: index,
                              child: InvoiceListItem(
                                  invoiceData: invoiceList[index])),
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }

  void applyFilter({bool isSearching = true}) {
    if (isSearching) {
      page = 1;
    }
    InvoiceFilterModel? filter = InvoiceFilterModel(
        name: searchController.text,
        paymentStatus: paymentStatusList,
        date: DateFilter(
            start: selectedDateTimeRange?.start,
            end: selectedDateTimeRange?.end));
    invoiceListBloc.add(InvoiceListEvent(
        limit: limit,
        page: page,
        filter: filter,
        fromAnotherScreen: isSearching));
  }
}
