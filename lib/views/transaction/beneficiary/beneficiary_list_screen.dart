import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class BeneficiaryListScreen extends StatefulWidget {
  final bool showAppbar;

  const BeneficiaryListScreen({super.key, this.showAppbar = false});

  @override
  State<BeneficiaryListScreen> createState() => _BeneficiaryListScreenState();
}

class _BeneficiaryListScreenState extends State<BeneficiaryListScreen>
    with SingleTickerProviderStateMixin {
  int page = 1;
  int limit = 10;

  var scrollController = ScrollController();
  var loadingBloc = SelectionBloc(SelectBoolState(false));
  var showHideAddBtnBloc = SelectionBloc(SelectBoolState(false));
  final searchBloc = SelectionBloc(SelectStringState(""));

  List<BankAccount> beneficiaryList = [];

  TabController? tabController;

  var searchController = TextEditingController();

  void pagination() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      loadingBloc.add(SelectBoolEvent(true));
      beneficiaryListBloc
          .add(GetBeneficiaryListEvent(limit: limit, page: page));
    }
  }

  void tabChangeListner() {
    showHideAddBtnBloc
        .add(SelectBoolEvent(tabController?.index == 0 ? false : true));
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController?.addListener(tabChangeListner);
    scrollController.addListener(pagination);
    kycBloc.add(GetKYCDetailEvent());
    super.initState();
  }

  @override
  void dispose() {
    tabController?.removeListener(tabChangeListner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as RouteArguments?;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: args?.showAppbar ?? false
          ? CustomAppBar(title: appLocalizations(context).beneficiaryList)
          : null,
      floatingActionButton: BlocBuilder(
          bloc: showHideAddBtnBloc,
          builder: (context, state) {
            if (state is SelectBoolState) {
              if (!state.value) {
                return FloatingActionButton.extended(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          backgroundColor: isDarkMode(context)
                              ? themeLogoColorBlue
                              : Colors.white,
                          builder: (context) => const NewContactForm());
                    },
                    label: Text(appLocalizations(context).newContact,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: Colors.black)));
              }
              return FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    backgroundColor:
                        isDarkMode(context) ? themeLogoColorBlue : Colors.white,
                    builder: (context) => AddBeneficiaryScreen(
                      selectedAccountRole:
                          tabController?.index == 1 ? "WALLET" : "BANK",
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: themeColorHeader,
                ),
              );
            }
            return const Loader();
          }),
      body: BlocConsumer(
          bloc: kycBloc,
          listener: (context, kycState) {
            if (kycState is GetKYCDetailState) {
              if (kycState.value.code == 200) {
                beneficiaryListBloc
                    .add(GetBeneficiaryListEvent(limit: limit, page: page));
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
              return BlocConsumer(
                bloc: beneficiaryListBloc,
                listener: (context, state) {
                  if (state is GetBeneficiaryListState) {
                    if (state.value.code == 200) {
                      var newBeneficiaryList =
                          state.value.data?.transactionlist ?? [];
                      if (newBeneficiaryList.isNotEmpty) {
                        beneficiaryList.addAll(newBeneficiaryList);
                        page++;
                      }
                      loadingBloc.add(SelectBoolEvent(false));
                    } else if (state.value.code ==
                        HTTPResponseStatusCodes.sessionExpireCode) {
                      sessionExpired(state.value.message, context);
                    }
                  }
                  if (state is AddBeneficiaryState) {
                    if (state.value.code == 200) {
                      beneficiaryList.clear();
                      page = 1;
                      showSuccessDialog(state.value.message, context);
                    } else if (state.value.code ==
                        HTTPResponseStatusCodes.sessionExpireCode) {
                      sessionExpired(state.value.message, context);
                    } else {
                      showFailedDialog(state.value.message, context);
                    }
                    beneficiaryListBloc
                        .add(GetBeneficiaryListEvent(limit: limit, page: page));
                  }
                  if (state is DeleteBeneficiaryState) {
                    if (state.value.code == 200) {
                      beneficiaryList.clear();
                      page = 1;
                      showSuccessDialog(state.value.message, context);
                    } else if (state.value.code ==
                        HTTPResponseStatusCodes.sessionExpireCode) {
                      sessionExpired(state.value.message, context);
                    } else {
                      showFailedDialog(state.value.message, context);
                    }
                    beneficiaryListBloc
                        .add(GetBeneficiaryListEvent(limit: limit, page: page));
                  }
                  if (state is UpdateBeneficiaryState) {
                    if (state.value.code == 200) {
                      beneficiaryList.clear();
                      page = 1;
                      showSuccessDialog(state.value.message, context);
                    } else if (state.value.code ==
                        HTTPResponseStatusCodes.sessionExpireCode) {
                      sessionExpired(state.value.message, context);
                    } else {
                      showFailedDialog(state.value.message, context);
                    }
                    beneficiaryListBloc
                        .add(GetBeneficiaryListEvent(limit: limit, page: page));
                  }
                },
                builder: (context, state) {
                  if (state is GetBeneficiaryListState) {
                    return Column(
                      children: [
                        Container(
                          height: 50,
                          color: isDarkMode(context)
                              ? themeColorHeader
                              : Colors.white,
                          child: TabBar(
                            indicatorColor: themeLogoColorOrange,
                            controller: tabController,
                            tabs: [
                              Text(
                                appLocalizations(context).mobileNo,
                                style: textTheme.bodyMedium?.copyWith(),
                              ),
                              Text(
                                appLocalizations(context).wallet,
                                style: textTheme.bodyMedium?.copyWith(),
                              ),
                              Text(
                                appLocalizations(context).bank,
                                style: textTheme.bodyMedium?.copyWith(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: CustomTextField(
                                      controller: searchController,
                                      labelText:
                                          appLocalizations(context).search,
                                      hintText:
                                          appLocalizations(context).searchHere,
                                      prefix: const Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      onChanged: (p0) {
                                        searchBloc.add(SelectStringEvent(p0));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: BlocBuilder(
                                        bloc: searchBloc,
                                        builder: (context, searchState) {
                                          if (searchState
                                              is SelectStringState) {
                                            return ContactsList(
                                              searchController.text,
                                              kycStatus: kycStatus,
                                              showContactWhenNotExist: true,
                                            );
                                          }
                                          return const Loader();
                                        }),
                                  ),
                                ],
                              ),
                              BeneficiaryListView(
                                beneficiaryList: beneficiaryList
                                    .where((e) => e.accountRole == "WALLET")
                                    .toList(),
                                scrollController: scrollController,
                                loadingBloc: loadingBloc,
                                kycStatus: kycStatus,
                              ),
                              BeneficiaryListView(
                                beneficiaryList: beneficiaryList
                                    .where((e) => e.accountRole == "BANK")
                                    .toList(),
                                scrollController: scrollController,
                                loadingBloc: loadingBloc,
                                kycStatus: kycStatus,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const Loader();
                },
              );
            }
            return const Loader();
          }),
    );
  }
}

class BeneficiaryListView extends StatelessWidget {
  final bool requestToPay;
  final List<BankAccount> beneficiaryList;
  final ScrollController scrollController;
  final SelectionBloc loadingBloc;
  final KYCStatus kycStatus;
  final TextEditingController searchController = TextEditingController();
  final checkBeneficiaryAccountStatusBloc = ApisBloc(ApisBlocInitialState());
  final searchBloc = SelectionBloc(SelectStringState(""));

  BeneficiaryListView({
    super.key,
    required this.beneficiaryList,
    required this.scrollController,
    required this.loadingBloc,
    this.requestToPay = false,
    required this.kycStatus,
  });

  @override
  Widget build(BuildContext context) {
    return (beneficiaryList.isEmpty)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sentiment_dissatisfied,
                  size: 48, color: Colors.grey),
              const SizedBox(height: 8),
              Text(appLocalizations(context).noBeneficiary,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey)),
            ],
          )
        : BlocConsumer(
            bloc: checkBeneficiaryAccountStatusBloc,
            listener: (context, state) {
              if (state is CheckBeneficiaryAccountStatusState) {
                if (state.value.code ==
                    HTTPResponseStatusCodes.momoAccountStatusSuccessCode) {
                  if (state.value.data?.status == "ACTIVE") {
                    //account is active go for txns
                    if (requestToPay) {
                    } else {
                      Navigator.pushNamed(context, AppRoutes.transactiondetail,
                          arguments: TransactionDetailScreen(
                            toAccount: state.value.data?.receiverDetails,
                            receiverType:
                                state.value.data?.receiverDetails?.userType,
                          ));
                    }
                  } else if (state.value.code ==
                      HTTPResponseStatusCodes.sessionExpireCode) {
                    sessionExpired(state.value.message, context);
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
                        onChanged: (p0) {
                          searchBloc.add(SelectStringEvent(p0));
                        },
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder(
                          bloc: searchBloc,
                          builder: (context, searchState) {
                            if (searchState is SelectStringState) {
                              var filteredBeneficiaryList = beneficiaryList
                                  .where((e) => (e.beneficiaryname!
                                          .toLowerCase()
                                          .contains(searchController.text
                                              .toLowerCase()) ||
                                      e.accountnumber!.toLowerCase().contains(
                                          searchController.text.toLowerCase())))
                                  .toList();
                              if (filteredBeneficiaryList.isEmpty) {
                                return Center(
                                    child: Text(appLocalizations(context)
                                        .noBeneficiary));
                              }
                              return AnimationLimiter(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: filteredBeneficiaryList.length,
                                  itemBuilder: (context, index) =>
                                      ListAnimation(
                                    index: index,
                                    child: Column(
                                      children: [
                                        BeneficiaryListItem(
                                            onTap: () {
                                              if (kycStatus !=
                                                  KYCStatus.approved) {
                                                showFailedDialog(
                                                    appLocalizations(context)
                                                        .kycNotApprovedDialogMessage,
                                                    context);
                                              } else {
                                                checkBeneficiaryAccountStatusBloc
                                                    .add(
                                                        CheckBeneficiaryAccountStatusEvent(
                                                  beneficiary:
                                                      filteredBeneficiaryList[
                                                          index],
                                                  receiverType: "BENEFICIARY",
                                                  userType: "Other",
                                                ));
                                              }
                                            },
                                            beneficiary:
                                                filteredBeneficiaryList[index]),
                                        if (index ==
                                            filteredBeneficiaryList.length - 1)
                                          BlocBuilder(
                                              bloc: loadingBloc,
                                              builder: (context, loadingState) {
                                                if (loadingState
                                                    is SelectBoolState) {
                                                  if (loadingState.value) {
                                                    return const Loader();
                                                  }
                                                }
                                                return const SizedBox.shrink();
                                              })
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const Loader();
                          }),
                    ),
                  ],
                ),
              );
            });
  }
}
