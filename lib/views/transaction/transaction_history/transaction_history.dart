import 'package:bctpay/globals/index.dart';
import 'package:flutter/cupertino.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List<TransactionData> transactions = [];

  var searchController = TextEditingController();
  final searchBloc = SelectionBloc(SelectStringState(""));

  var scrollController = ScrollController();
  List<TransactionData> filteredTransactions = [];

  int limit = 25;
  int page = 1;
  var loadingBloc = SelectionBloc(SelectBoolState(false));

  late String userId;

  var selectPaymentStatusBloc = SelectionBloc(SelectStringState(""));
  var selectPaymentTypeBloc = SelectionBloc(SelectStringState(""));
  var selectPaymentBloc = SelectionBloc(SelectStringState(""));
  var selectDateRangeBloc = SelectionBloc(SelectionBlocInitialState());

  List<String>? paymentStatusList = [];
  List<String>? paymentTypeList = [];
  List<String>? paymentList = [];

  DateTimeRange? selectedDateTimeRange;

  void applyFilter({bool isSearching = true}) {
    if (isSearching) {
      page = 1;
    }
    TxnFilterModel? filter = TxnFilterModel(
        name: searchController.text,
        paymentType: paymentTypeList,
        paymentStatus: paymentStatusList,
        payment: paymentList,
        date: DateFilter(
            start: selectedDateTimeRange?.start,
            end: selectedDateTimeRange?.end));
    transactionHistoryBloc.add(TransactionHistoryEvent(
        limit: limit,
        page: page,
        filter: filter,
        fromAnotherScreen: isSearching));
  }

  void pagination() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      loadingBloc.add(SelectBoolEvent(true));
      page++;
      applyFilter(isSearching: false);
    }
  }

  @override
  void initState() {
    SharedPreferenceHelper.getUserId().then((value) => userId = value);
    scrollController.addListener(pagination);
    applyFilter();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(pagination);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocConsumer(
          bloc: transactionHistoryBloc,
          listener: (context, state) {
            if (state is TransactionHistoryState) {
              if (state.value.code == 200) {
                var totalTxns = state.value.data?.list ?? [];
                if (state.fromAnotherScreen) {
                  page = 1;
                  transactions.clear();
                }
                transactions.addAll(totalTxns);
                loadingBloc.add(SelectBoolEvent(false));
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(state.value.message, context);
              }
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView(
                controller: scrollController,
                children: [
                  CustomTextField(
                    controller: searchController,
                    labelText: AppLocalizations.of(context)!.search,
                    hintText: AppLocalizations.of(context)!.searchHere,
                    prefix: const Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                    suffix: BlocConsumer(
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
                                  return FilterTxnBtn(
                                    selectDateRangeBloc: selectDateRangeBloc,
                                    dateTimeRange: selectedDateTimeRange,
                                    selectPaymentStatusBloc:
                                        selectPaymentStatusBloc,
                                    paymentStatusList: paymentStatusList,
                                    selectPaymentBloc: selectPaymentBloc,
                                    paymentList: paymentList,
                                    selectPaymentTypeBloc:
                                        selectPaymentTypeBloc,
                                    paymentTypeList: paymentTypeList,
                                  );
                                });
                          }
                          return Loader();
                        }),
                    onChanged: (p0) {
                      searchBloc.add(SelectStringEvent(p0));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleWidget(
                      title: AppLocalizations.of(context)!.allTransactions),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer(
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
                      builder: (context, selectPaymentTypeState) {
                        return BlocListener(
                          bloc: selectPaymentBloc,
                          listener: (context, selectPaymentTypeState) {
                            if (selectPaymentTypeState is SelectStringState) {
                              if (selectPaymentTypeState.isSelected ?? false) {
                                paymentList?.add(selectPaymentTypeState.value!);
                              } else {
                                paymentList
                                    ?.remove(selectPaymentTypeState.value!);
                              }
                              applyFilter();
                            }
                          },
                          child: BlocConsumer(
                              bloc: searchBloc,
                              listener: (context, state) {
                                if (state is SelectStringState) {
                                  applyFilter();
                                }
                              },
                              builder: (context, searchState) {
                                if (searchState is SelectStringState) {
                                  filteredTransactions = transactions;
                                  if (filteredTransactions.isEmpty &&
                                      state is ApisBlocLoadingState) {
                                    return Loader();
                                  } else if (filteredTransactions.isEmpty) {
                                    return Center(
                                        child: Text(appLocalizations(context)
                                            .noTransaction));
                                  }
                                  return AnimationLimiter(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: filteredTransactions.length,
                                      itemBuilder: (context, index) =>
                                          ListAnimation(
                                        index: index,
                                        child: Column(
                                          children: [
                                            TransactionListItem(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .transactionHistoryDetail,
                                                      arguments:
                                                          TransactionHistoryDetail(
                                                        transaction:
                                                            filteredTransactions[
                                                                index],
                                                      ));
                                                },
                                                transaction:
                                                    filteredTransactions[
                                                        index]),
                                            if (index ==
                                                filteredTransactions.length - 1)
                                              BlocBuilder(
                                                  bloc: loadingBloc,
                                                  builder:
                                                      (context, loadingState) {
                                                    if (loadingState
                                                        is SelectBoolState) {
                                                      if (loadingState.value) {
                                                        return const Loader();
                                                      }
                                                    }
                                                    return const SizedBox
                                                        .shrink();
                                                  })
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return const Loader();
                              }),
                        );
                      })
                ],
              ),
            );
          }),
    );
  }
}
