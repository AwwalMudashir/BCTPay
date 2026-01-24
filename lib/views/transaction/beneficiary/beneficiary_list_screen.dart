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
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: args?.showAppbar ?? false
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: Text(
                appLocalizations(context).beneficiaries,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.04, // 4% of screen width
                    0,
                    MediaQuery.of(context).size.width * 0.04, // 4% of screen width
                    16,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: appLocalizations(context).searchBeneficiaries,
                        hintStyle: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade500,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        searchBloc.add(SelectStringEvent(value));
                      },
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButton: BlocBuilder(
        bloc: showHideAddBtnBloc,
        builder: (context, state) {
          if (state is SelectBoolState) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: FloatingActionButton(
                onPressed: () {
                  if (!state.value) {
                    // Mobile tab - add contact
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => const NewContactForm(),
                    );
                  } else {
                    // Wallet/Bank tab - add beneficiary
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => AddBeneficiaryScreen(
                        selectedAccountRole: tabController?.index == 1 ? "WALLET" : "BANK",
                      ),
                    );
                  }
                },
                backgroundColor: themeLogoColorBlue,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.07, // Responsive size
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
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
                      showFailedDialog(
                          state.value.responseMessage, context);
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
                        // Modern Tab Bar
                        Container(
                          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TabBar(
                            controller: tabController,
                            indicator: BoxDecoration(
                              color: themeLogoColorBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey.shade600,
                            labelStyle: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            padding: const EdgeInsets.all(4),
                            tabs: [
                              Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(appLocalizations(context).mobileNo),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(appLocalizations(context).wallet),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(appLocalizations(context).bank),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              // Mobile Contacts Tab
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: BlocBuilder(
                                        bloc: searchBloc,
                                        builder: (context, searchState) {
                                          if (searchState is SelectStringState) {
                                            return ContactsList(
                                              searchController.text,
                                              kycStatus: kycStatus,
                                              showContactWhenNotExist: true,
                                            );
                                          }
                                          return const Center(
                                            child: Text(
                                              "Loading contacts...",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Wallet Beneficiaries Tab
                              _ModernBeneficiaryListView(
                                beneficiaryList: beneficiaryList
                                    .where((e) => e.accountRole == "WALLET")
                                    .toList(),
                                scrollController: scrollController,
                                loadingBloc: loadingBloc,
                                kycStatus: kycStatus,
                                emptyMessage: "No wallet beneficiaries yet",
                                emptyIcon: Icons.account_balance_wallet,
                              ),

                              // Bank Beneficiaries Tab
                              _ModernBeneficiaryListView(
                                beneficiaryList: beneficiaryList
                                    .where((e) => e.accountRole == "BANK")
                                    .toList(),
                                scrollController: scrollController,
                                loadingBloc: loadingBloc,
                                kycStatus: kycStatus,
                                emptyMessage: "No bank beneficiaries yet",
                                emptyIcon: Icons.account_balance,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: Text(
                      "Loading beneficiaries...",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text(
                "Verifying account...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
    );
  }
}

class _ModernBeneficiaryListView extends StatelessWidget {
  final List<BankAccount> beneficiaryList;
  final ScrollController scrollController;
  final SelectionBloc loadingBloc;
  final KYCStatus kycStatus;
  final String emptyMessage;
  final IconData emptyIcon;

  const _ModernBeneficiaryListView({
    required this.beneficiaryList,
    required this.scrollController,
    required this.loadingBloc,
    required this.kycStatus,
    required this.emptyMessage,
    required this.emptyIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = appLocalizations(context);

    if (beneficiaryList.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  emptyIcon,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                emptyMessage,
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Add beneficiaries to send money easily",
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: beneficiaryList.length,
                itemBuilder: (context, index) {
                  final beneficiary = beneficiaryList[index];
                  return ListAnimation(
                    index: index,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: themeLogoColorBlue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            beneficiary.accountRole == "WALLET"
                                ? Icons.account_balance_wallet
                                : Icons.account_balance,
                            color: themeLogoColorBlue,
                            size: 24,
                          ),
                        ),
                        title: Text(
                          beneficiary.beneficiaryname ?? "Unknown",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              beneficiary.accountRole == "WALLET"
                                  ? "${beneficiary.phoneCode ?? ""} ${beneficiary.walletPhonenumber ?? beneficiary.accountnumber ?? ""}"
                                  : beneficiary.accountnumber ?? "",
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              beneficiary.bankname ?? "Bank Account",
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                        onTap: () {
                          if (kycStatus != KYCStatus.approved) {
                            showFailedDialog(
                              t.kycNotApprovedDialogMessage,
                              context,
                            );
                          } else {
                            // Navigate to transaction detail
                            Navigator.pushNamed(
                              context,
                              AppRoutes.transactiondetail,
                              arguments: TransactionDetailScreen(
                                toAccount: beneficiary,
                                receiverType: beneficiary.userType,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Loading indicator at bottom
          BlocBuilder(
            bloc: loadingBloc,
            builder: (context, loadingState) {
              if (loadingState is SelectBoolState && loadingState.value) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
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
