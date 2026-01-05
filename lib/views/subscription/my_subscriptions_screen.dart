import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MySubscriptions extends StatefulWidget {
  const MySubscriptions({super.key});

  @override
  State<MySubscriptions> createState() => _MySubscriptionsState();
}

class _MySubscriptionsState extends State<MySubscriptions> {
  final subscriptionBloc = ApisBloc(ApisBlocInitialState());
  int page = 1;
  int limit = 10;

  final _refreshController = RefreshController();

  List<Subscription> subscriptions = [];
  final searchController = TextEditingController();

  var searchBloc = SelectionBloc(SelectStringState(""));

  var selectPaymentStatusBloc = SelectionBloc(SelectStringState(""));
  var selectPaymentTypeBloc = SelectionBloc(SelectStringState(""));
  var selectPaymentBloc = SelectionBloc(SelectStringState(""));
  var selectDateRangeBloc = SelectionBloc(SelectionBlocInitialState());

  List<String>? paymentStatusList = [];
  List<String>? subscriptionTypeList = [];
  List<String>? paymentList = [];

  DateTimeRange? selectedDateTimeRange;

  @override
  void initState() {
    super.initState();
    applyFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: PullToRefreshHeader(),
        child: BlocConsumer(
            bloc: subscriptionBloc,
            listener: (context, state) {
              if (state is GetSubscriptionsState) {
                if (state.value.code == 200) {
                  subscriptions = state.value.data?.subscriptions ?? [];
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
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
                            subscriptionTypeList?.add(state.value!);
                          } else {
                            subscriptionTypeList?.remove(state.value!);
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
                                      return FilterSubscriptionBtn(
                                        filter: SubscriptionFilterModel(
                                            name: searchController.text,
                                            subscriptionType:
                                                subscriptionTypeList,
                                            paymentStatus: paymentStatusList,
                                            date: DateFilter(
                                              start:
                                                  selectedDateTimeRange?.start,
                                              end: selectedDateTimeRange?.end,
                                            )),
                                        selectDateRangeBloc:
                                            selectDateRangeBloc,
                                        selectPaymentStatusBloc:
                                            selectPaymentStatusBloc,
                                        selectPaymentBloc: selectPaymentBloc,
                                        selectSubscriptionTypeBloc:
                                            selectPaymentTypeBloc,
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
                          if (subscriptions.isEmpty &&
                              state is ApisBlocLoadingState) {
                            return Loader();
                          } else if (subscriptions.isEmpty) {
                            return Center(
                              child: Text(appLocalizations(context).noData),
                            );
                          }
                          return AnimationLimiter(
                            child: ListView.builder(
                                itemCount: subscriptions.length,
                                itemBuilder: (context, index) => ListAnimation(
                                      index: index,
                                      child: SubscriptionListItem(
                                        subscription: subscriptions[index],
                                      ),
                                    )),
                          );
                        }),
                  ),
                ],
              );
            }),
      ),
    );
  }

  void _onRefresh() {
    subscriptionBloc.add(GetSubscriptionsEvent(page: page, limit: limit));
    _refreshController.refreshCompleted();
  }

  void applyFilter({bool isSearching = true}) {
    if (isSearching) {
      page = 1;
    }
    SubscriptionFilterModel? filter = SubscriptionFilterModel(
        name: searchController.text,
        subscriptionType: subscriptionTypeList,
        paymentStatus: paymentStatusList,
        date: DateFilter(
            start: selectedDateTimeRange?.start,
            end: selectedDateTimeRange?.end));
    subscriptionBloc.add(GetSubscriptionsEvent(
        limit: limit,
        page: page,
        filter: filter,
        fromAnotherScreen: isSearching));
  }
}
