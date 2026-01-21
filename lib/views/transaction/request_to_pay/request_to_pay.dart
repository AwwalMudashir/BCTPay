import 'package:bctpay/globals/index.dart';

class RequestToPayScreen extends StatefulWidget {
  final bool showAppbar;

  const RequestToPayScreen({super.key, this.showAppbar = false});

  @override
  State<RequestToPayScreen> createState() => _RequestToPayScreenState();
}

class _RequestToPayScreenState extends State<RequestToPayScreen>
    with SingleTickerProviderStateMixin {
  int page = 1;
  int limit = 10;

  var scrollController = ScrollController();
  var loadingBloc = SelectionBloc(SelectBoolState(false));
  var showHideAddBtnBloc = SelectionBloc(SelectBoolState(false));

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
    tabController = TabController(length: 1, vsync: this);
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: args?.showAppbar ?? false
          ? CustomAppBar(title: appLocalizations(context).requestPayment)
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
                          builder: (context) => const NewContactForm(
                                isRequestToPay: true,
                              ));
                    },
                    label: Text(appLocalizations(context).newContact,
                        style: textTheme(context)
                            .bodyMedium
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer(
                  bloc: beneficiaryListBloc,
                  listener: (context, state) {
                    if (state is GetBeneficiaryListState) {
                      if (state.value.isSuccess) {
                        var newBeneficiaryList = state.value.beneficiaryList
                            .map((e) => BankAccount(
                                  id: e.beneficiaryAccountNo.isNotEmpty
                                      ? e.beneficiaryAccountNo
                                      : e.id,
                                  accountRole: "BANK",
                                  beneficiaryname: e.beneficiaryName,
                                  accountnumber: e.beneficiaryAccountNo,
                                  bankname: e.beneficiaryBankName,
                                  bankcode: e.beneficiaryBankCode,
                                  userType: e.beneficiaryBankName,
                                  walletPhonenumber: null,
                                  phoneCode: null,
                                  verifystatus: null,
                                  accountstatus: null,
                                  primaryaccount: null,
                                  createdAt: null,
                                  updatedAt: null,
                                  v: null,
                                  clientId: null,
                                  logo: null,
                                  merchantId: null,
                                  bctpayCustomerId: null,
                                  customerId: e.id,
                                ))
                            .toList();
                        if (newBeneficiaryList.isNotEmpty) {
                          beneficiaryList.addAll(newBeneficiaryList);
                          page++;
                        }
                        loadingBloc.add(SelectBoolEvent(false));
                      } else {
                        loadingBloc.add(SelectBoolEvent(false));
                        showFailedDialog(state.value.responseMessage, context);
                      }
                    }
                    if (state is AddBeneficiaryState) {
                      if (state.value.isSuccess) {
                        beneficiaryList.clear();
                        page = 1;
                        showSuccessDialog(state.value.message, context);
                      } else if (state.value.isSessionExpired) {
                        sessionExpired(state.value.message, context);
                      } else {
                        showFailedDialog(state.value.message, context);
                      }
                      beneficiaryListBloc.add(
                          GetBeneficiaryListEvent(limit: limit, page: page));
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
                      beneficiaryListBloc.add(
                          GetBeneficiaryListEvent(limit: limit, page: page));
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
                      beneficiaryListBloc.add(
                          GetBeneficiaryListEvent(limit: limit, page: page));
                    }
                  },
                  builder: (context, state) {
                    if (state is GetBeneficiaryListState) {
                      return Column(
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
                                setState(() {});
                              },
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                ContactsList(
                                  searchController.text,
                                  isRequestToPay: true,
                                  kycStatus: kycStatus,
                                  showContactWhenNotExist: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return const Loader();
                  },
                ),
              );
            }
            return const Loader();
          }),
    );
  }
}
