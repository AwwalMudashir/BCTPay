import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class PaymentRequestsScreen extends StatefulWidget {
  final bool showAppbar;

  const PaymentRequestsScreen({super.key, this.showAppbar = false});

  @override
  State<PaymentRequestsScreen> createState() => _PaymentRequestsScreenState();
}

class _PaymentRequestsScreenState extends State<PaymentRequestsScreen>
    with SingleTickerProviderStateMixin {
  List<BankAccount> beneficiaryList = [];
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    kycBloc.add(GetKYCDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: appLocalizations(context).paymentRequests,
      ),
      body: BlocConsumer(
          bloc: kycBloc,
          listener: (context, kycState) {
            if (kycState is GetKYCDetailState) {
              if (kycState.value.code == 200) {
              } else if (kycState.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(
                    kycState.value.message ?? kycState.value.error ?? "",
                    context);
              } else {
                showFailedDialog(
                    kycState.value.message ?? kycState.value.error ?? "",
                    context);
              }
            }
          },
          builder: (context, kycState) {
            if (kycState is GetKYCDetailState) {
              var kycStatus =
                  kycState.value.data?.kycStatus ?? KYCStatus.pending;
              return Column(
                children: [
                  Container(
                    height: 50,
                    color:
                        isDarkMode(context) ? themeColorHeader : Colors.white,
                    child: TabBar(
                      indicatorColor: themeLogoColorOrange,
                      controller: tabController,
                      tabs: [
                        Text(
                          appLocalizations(context).sent,
                          style: textTheme.bodyMedium?.copyWith(),
                        ),
                        Text(
                          appLocalizations(context).received,
                          style: textTheme.bodyMedium?.copyWith(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        SentRequestsList(
                          kycStatus: kycStatus,
                        ),
                        ReceivedRequestsList(
                          kycStatus: kycStatus,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Loader();
          }),
    );
  }
}

class SentRequestsList extends StatefulWidget {
  final KYCStatus kycStatus;

  const SentRequestsList({
    super.key,
    required this.kycStatus,
  });

  @override
  State<SentRequestsList> createState() => _SentRequestsListState();
}

class _SentRequestsListState extends State<SentRequestsList> {
  var searchController = TextEditingController();
  int page = 1;
  int limit = 10;
  List<PaymentRequest> requestsList = [];
  final checkBeneficiaryAccountStatusBloc = ApisBloc(ApisBlocInitialState());
  var scrollController = ScrollController();
  var loadingBloc = SelectionBloc(SelectBoolState(false));
  var paymentRequestBloc = ApisBloc(ApisBlocInitialState());

  var selectFilterBloc = SelectionBloc(SelectStringState(""));

  String? filterString;

  void pagination() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      loadingBloc.add(SelectBoolEvent(true));
      paymentRequestBloc
          .add(PaymentRequestsByMeEvent(page: page, limit: limit));
    }
  }

  @override
  void initState() {
    paymentRequestBloc.add(PaymentRequestsByMeEvent(page: page, limit: limit));
    scrollController.addListener(pagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: checkBeneficiaryAccountStatusBloc,
        listener: (context, state) {
          if (state is CheckBeneficiaryAccountStatusState) {
            if (state.value.code ==
                HTTPResponseStatusCodes.momoAccountStatusSuccessCode) {
              if (state.value.data?.status == "ACTIVE") {
                //account is active go for txns
                Navigator.pushNamed(context, AppRoutes.transactiondetail,
                    arguments:
                        TransactionDetailScreen(toAccount: state.beneficiary));
              } else {
                //account is not active show error dialog
                showFailedDialog(state.value.message, context);
              }
            } else {
              //getting error code from momo server
              showFailedDialog(state.value.message, context);
            }
          }
          if (state is ApisBlocErrorState) {
            //bad response
            showFailedDialog(state.message, context);
          }
        },
        builder: (context, state) {
          return BlocConsumer(
              bloc: paymentRequestBloc,
              listener: (context, state) {
                if (state is PaymentRequestsByMeState) {
                  if (state.value.code == 200) {
                    var newList = state.value.data?.list ?? [];
                    if (newList.isNotEmpty) {
                      requestsList.addAll(newList);
                      page++;
                    }
                    loadingBloc.add(SelectBoolEvent(false));
                  } else if (state.value.code ==
                      HTTPResponseStatusCodes.sessionExpireCode) {
                    sessionExpired(state.value.message, context);
                  }
                }
                if (state is RejectPaymentRequestState) {
                  if (state.value.code == 200) {
                  } else if (state.value.code ==
                      HTTPResponseStatusCodes.sessionExpireCode) {
                    sessionExpired(
                        state.value.message ?? state.value.error ?? "",
                        context);
                  } else {
                    showFailedDialog(
                        state.value.message ?? state.value.error ?? "",
                        context);
                  }
                  page = 1;
                  requestsList.clear();
                  paymentRequestBloc
                      .add(PaymentRequestsByMeEvent(page: page, limit: limit));
                }
              },
              builder: (context, paymentRequestListState) {
                if (paymentRequestListState is ApisBlocErrorState) {
                  return Center(
                    child: Text(appLocalizations(context).serverError),
                  );
                }
                if (paymentRequestListState is PaymentRequestsByMeState) {
                  var filteredRequestList = requestsList
                      .where((request) =>
                          (request.senderName.toLowerCase().contains(
                                  searchController.text.toLowerCase()) ||
                              request.id.toLowerCase().contains(
                                  searchController.text.toLowerCase())) &&
                          ((filterString?.isEmpty ?? true)
                              ? true
                              : request.status == filterString))
                      .toList();
                  if (requestsList.isEmpty) {
                    return Center(
                      child: Text(appLocalizations(context).noRequest),
                    );
                  }
                  return ModalProgressHUD(
                    progressIndicator: const Loader(),
                    inAsyncCall: state is ApisBlocLoadingState,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CustomTextField(
                            controller: searchController,
                            labelText: appLocalizations(context).search,
                            hintText: appLocalizations(context).searchHere,
                            prefix: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            suffix: BlocConsumer(
                                bloc: selectFilterBloc,
                                listener: (context, state) {
                                  if (state is SelectStringState) {
                                    filterString = state.value;
                                    setState(() {});
                                  }
                                },
                                builder: (context, state) {
                                  if (state is SelectStringState) {
                                    return FilterBtn(
                                      bloc: selectFilterBloc,
                                      filterString: filterString,
                                    );
                                  }
                                  return Loader();
                                }),
                            onChanged: (p0) {
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: (filteredRequestList.isEmpty)
                              ? Center(
                                  child:
                                      Text(appLocalizations(context).noRequest),
                                )
                              : AnimationLimiter(
                                  child: ListView.builder(
                                    controller: scrollController,
                                    itemCount: filteredRequestList.length,
                                    itemBuilder: (context, index) =>
                                        ListAnimation(
                                      index: index,
                                      child: Column(
                                        children: [
                                          PaymentRequestListItem(
                                              paymentRequestBloc:
                                                  paymentRequestBloc,
                                              showPoupMenuBtn: false,
                                              isSentRequest: true,
                                              request:
                                                  filteredRequestList[index]),
                                          if (index ==
                                              filteredRequestList.length - 1)
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
                                ),
                        ),
                      ],
                    ),
                  );
                }
                return const Loader();
              });
        });
  }
}

class ReceivedRequestsList extends StatefulWidget {
  final KYCStatus kycStatus;

  const ReceivedRequestsList({
    super.key,
    required this.kycStatus,
  });

  @override
  State<ReceivedRequestsList> createState() => ReceivedRequestsListState();
}

class ReceivedRequestsListState extends State<ReceivedRequestsList> {
  var searchController = TextEditingController();
  int page = 1;
  int limit = 10;
  List<PaymentRequest> requestsList = [];
  final checkBeneficiaryAccountStatusBloc = ApisBloc(ApisBlocInitialState());
  var scrollController = ScrollController();
  var loadingBloc = SelectionBloc(SelectBoolState(false));
  var paymentRequestBloc = ApisBloc(ApisBlocInitialState());

  String? filterString;

  var selectFilterBloc = SelectionBloc(SelectStringState(""));

  void pagination() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      loadingBloc.add(SelectBoolEvent(true));
      paymentRequestBloc
          .add(PaymentRequestsByOtherEvent(limit: limit, page: page));
    }
  }

  @override
  void initState() {
    paymentRequestBloc
        .add(PaymentRequestsByOtherEvent(page: page, limit: limit));
    scrollController.addListener(pagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: checkBeneficiaryAccountStatusBloc,
        listener: (context, state) {
          if (state is CheckBeneficiaryAccountStatusState) {
            if (state.value.code ==
                HTTPResponseStatusCodes.momoAccountStatusSuccessCode) {
              if (state.value.data?.status == "ACTIVE") {
                //account is active go for txns
                Navigator.pushNamed(context, AppRoutes.transactiondetail,
                    arguments: TransactionDetailScreen(
                      toAccount: state.beneficiary,
                      isRequestToPay: true,
                      request: state.request,
                    ));
              } else {
                //account is not active show error dialog
                showFailedDialog(state.value.message, context);
              }
            } else {
              //getting error code from momo server
              showFailedDialog(state.value.message, context);
            }
          }
          if (state is ApisBlocErrorState) {
            //bad response
            showFailedDialog(state.message, context);
          }
        },
        builder: (context, state) {
          return BlocConsumer(
              bloc: paymentRequestBloc,
              listener: (context, state) {
                if (state is PaymentRequestsByOtherState) {
                  if (state.value.code == 200) {
                    var newList = state.value.data?.list ?? [];
                    if (newList.isNotEmpty) {
                      requestsList.addAll(newList);
                      page++;
                    }
                    loadingBloc.add(SelectBoolEvent(false));
                  } else if (state.value.code ==
                      HTTPResponseStatusCodes.sessionExpireCode) {
                    sessionExpired(state.value.message, context);
                  }
                }
                if (state is RejectPaymentRequestState) {
                  if (state.value.code == 200) {
                  } else if (state.value.code ==
                      HTTPResponseStatusCodes.sessionExpireCode) {
                    sessionExpired(
                        state.value.message ?? state.value.error ?? "",
                        context);
                  } else {
                    showFailedDialog(
                        state.value.message ?? state.value.error ?? "",
                        context);
                  }
                  page = 1;
                  requestsList.clear();
                  paymentRequestBloc.add(
                      PaymentRequestsByOtherEvent(page: page, limit: limit));
                }
              },
              builder: (context, paymentRequestListState) {
                if (paymentRequestListState is ApisBlocErrorState) {
                  return Center(
                    child: Text(appLocalizations(context).serverError),
                  );
                }
                if (paymentRequestListState is PaymentRequestsByOtherState) {
                  var filteredRequestList = requestsList
                      .where((request) =>
                          (request.receiverName.toLowerCase().contains(
                                  searchController.text.toLowerCase()) ||
                              request.id.toLowerCase().contains(
                                  searchController.text.toLowerCase())) &&
                          ((filterString?.isEmpty ?? true)
                              ? true
                              : request.status == filterString))
                      .toList();
                  if (requestsList.isEmpty) {
                    return Center(
                      child: Text(appLocalizations(context).noRequest),
                    );
                  }
                  return ModalProgressHUD(
                    progressIndicator: const Loader(),
                    inAsyncCall: state is ApisBlocLoadingState,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CustomTextField(
                            controller: searchController,
                            labelText: appLocalizations(context).search,
                            hintText: appLocalizations(context).searchHere,
                            prefix: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            suffix: BlocConsumer(
                                bloc: selectFilterBloc,
                                listener: (context, state) {
                                  if (state is SelectStringState) {
                                    filterString = state.value;
                                    setState(() {});
                                  }
                                },
                                builder: (context, state) {
                                  if (state is SelectStringState) {
                                    return FilterBtn(
                                      bloc: selectFilterBloc,
                                      filterString: filterString,
                                    );
                                  }
                                  return Loader();
                                }),
                            onChanged: (p0) {
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: filteredRequestList.isEmpty
                              ? Center(
                                  child:
                                      Text(appLocalizations(context).noRequest),
                                )
                              : AnimationLimiter(
                                  child: ListView.builder(
                                    controller: scrollController,
                                    itemCount: filteredRequestList.length,
                                    itemBuilder: (context, index) =>
                                        ListAnimation(
                                      index: index,
                                      child: Column(
                                        children: [
                                          PaymentRequestListItem(
                                              paymentRequestBloc:
                                                  paymentRequestBloc,
                                              showPoupMenuBtn: false,
                                              onTap: () {
                                                if (widget.kycStatus !=
                                                    KYCStatus.approved) {
                                                  showFailedDialog(
                                                      appLocalizations(context)
                                                          .kycNotApprovedDialogMessage,
                                                      context);
                                                } else {
                                                  var request =
                                                      filteredRequestList[
                                                          index];
                                                  checkBeneficiaryAccountStatusBloc
                                                      .add(
                                                          CheckBeneficiaryAccountStatusEvent(
                                                    beneficiary: BankAccount(
                                                        id: request
                                                            .receiverAccountId,
                                                        customerId: request
                                                            .receiverBctpayId,
                                                        accountRole: "WALLET",
                                                        phoneCode: request
                                                            .requestToPayUserPhoneCode,
                                                        walletPhonenumber: request
                                                            .requestToPayUserPhoneNumber,
                                                        verifystatus: "1",
                                                        accountstatus: "1",
                                                        primaryaccount: "YES",
                                                        createdAt:
                                                            DateTime.now(),
                                                        updatedAt:
                                                            DateTime.now(),
                                                        v: 0,
                                                        beneficiaryname: request
                                                            .receiverName,
                                                        accountnumber: request
                                                                .requestToPayUserPhoneCode +
                                                            request
                                                                .requestToPayUserPhoneNumber,
                                                        clientId:
                                                            request.receiverId,
                                                        bankname: "N/A",
                                                        bankcode: "N/A",
                                                        logo: request
                                                            .receiverAccountLogo),
                                                    receiverType: "REQUESTED",
                                                    request: request,
                                                  ));
                                                }
                                              },
                                              request:
                                                  filteredRequestList[index]),
                                          if (index ==
                                              filteredRequestList.length - 1)
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
                                ),
                        ),
                      ],
                    ),
                  );
                }
                return const Loader();
              });
        });
  }
}
