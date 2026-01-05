import 'package:bctpay/globals/index.dart';

var productListBloc = ApisBloc(ApisBlocInitialState());

class MobileRechargeForm extends StatefulWidget {
  final Contact? contact;

  const MobileRechargeForm({super.key, this.contact});

  @override
  State<MobileRechargeForm> createState() => _MobileRechargeFormState();
}

class _MobileRechargeFormState extends State<MobileRechargeForm>
    with SingleTickerProviderStateMixin {
  var regionBloc = ApisBloc(ApisBlocInitialState());
  var providerBloc = ApisBloc(ApisBlocInitialState());
  var accountLookupBloc = ApisBloc(ApisBlocInitialState());
  ProviderListItem? selectedProvider;
  var selectProviderBloc = SelectionBloc(SelectionBlocInitialState());
  TabController? tabController;
  String benefits = "";
  MobileRechargeForm? args;

  List<RegionListItem>? regions = [];

  List<AccountLookupListItem>? accountLookupListItems = [];

  List<ProviderListItem> providers = [];

  @override
  void initState() {
    checkPrimaryOrActiveAccountAvailability(context);
    tabController = TabController(length: 4, vsync: this);
    tabController!.addListener(() {});
    WidgetsBinding.instance.addPostFrameCallback((timestemp) {
      args = ModalRoute.of(context)!.settings.arguments as MobileRechargeForm;
      accountLookupBloc.add(GetAccountLookupEvent(
          accountNumber:
              args!.contact!.phones.first.number.replaceAll(" ", "")));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as MobileRechargeForm;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: appLocalizations(context).mobileRecharge),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            ContactListItem(
              contact: args!.contact!,
              onTap: () {},
            ),
            BlocConsumer(
                bloc: accountLookupBloc,
                listener: (context, accountLookupState) {
                  if (accountLookupState is GetAccountLookupState) {
                    var accountLookupData = accountLookupState.value.data;
                    accountLookupListItems = accountLookupData?.items ?? [];
                    regionBloc.add(RegionListEvent(
                        countryIsos: accountLookupListItems!.isEmpty
                            ? selectedCountry!.countryCode
                            : accountLookupListItems!.first.regionCode));
                    if (accountLookupState.value.code ==
                        HTTPResponseStatusCodes.sessionExpireCode) {
                      sessionExpired(accountLookupState.value.message, context);
                    }
                  }
                },
                builder: (context, accountLookupState) {
                  if (accountLookupState is GetAccountLookupState) {
                    var accountLookupData = accountLookupState.value.data;
                    accountLookupListItems = accountLookupData?.items ?? [];
                    return BlocConsumer(
                      bloc: regionBloc,
                      listener: (context, regionListstate) {
                        if (regionListstate is RegionListState) {
                          var regionListData = regionListstate.value.data;
                          regions = regionListData?.items ?? [];
                          providerBloc.add(ProviderListEvent(
                              providerCodes: accountLookupListItems!.isNotEmpty
                                  ? accountLookupListItems!.first.providerCode
                                  : "",
                              countryIsos: regions!.isNotEmpty
                                  ? regions!.first.countryIso
                                  : accountLookupData?.countryIso,
                              regionCodes: regions!.isNotEmpty
                                  ? regions!.first.regionCode
                                  : accountLookupData?.countryIso,
                              accountNumber: accountLookupListItems!.isNotEmpty
                                  ? args!.contact!.phones.first.number
                                      .replaceAll(" ", "")
                                  : "",
                              benefits: "",
                              skuCodes: ""));
                        }
                      },
                      builder: (context, regionListstate) {
                        if (regionListstate is RegionListState) {
                          RegionListData? regionListData =
                              regionListstate.value.data;
                          regions = regionListData?.items ?? [];
                          if (regions!.isEmpty) {
                            return Center(
                              child: Text(appLocalizations(context).noRegions),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: regions!.length,
                            itemBuilder: (context, index) =>
                                _buildProvidersView(),
                          );
                        }
                        return const Loader();
                      },
                    );
                  }
                  return const Loader();
                }),
          ],
        ),
      ),
    );
  }

  Widget plansView() {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 50,
            width: width,
            child: TabBar(controller: tabController, onTap: (value) {}, tabs: [
              Text(
                appLocalizations(context).forYou,
                style: textTheme.bodyMedium,
              ),
              Text(
                appLocalizations(context).data,
                style: textTheme.bodyMedium,
              ),
              Text(
                appLocalizations(context).topUp,
                style: textTheme.bodyMedium,
              ),
              Text(
                appLocalizations(context).roaming,
                style: textTheme.bodyMedium,
              ),
            ]),
          ),
        ),
        SizedBox(
          height: 500,
          child: TabBarView(
            controller: tabController,
            children: [
              for (int i in [0, 1, 2, 3])
                PlansListView(
                  regionCode: regions!.first.regionCode,
                  mobileNo: i == 0
                      ? args!.contact!.phones.first.number.replaceAll(" ", "")
                      : "",
                  providerCode: accountLookupListItems!.isEmpty
                      ? selectedProvider!.providerCode
                      : accountLookupListItems!.first.providerCode,
                  benefits: getBenefit(i),
                  contact: args!.contact!,
                ),
            ],
          ),
        )
      ],
    );
  }

  BlocConsumer<ApisBloc, Object?> _buildProvidersView() => BlocConsumer(
        bloc: providerBloc,
        listener: (context, providerBlocState) {
          if (providerBlocState is ProviderListState) {
            providers = providerBlocState.value.data?.items ?? [];
            if (providers.isNotEmpty) {
              selectedProvider = providers.first;
              selectProviderBloc.add(SelectProviderEvent(selectedProvider!));
            }
          }
        },
        builder: (context, providerBlocState) {
          if (providerBlocState is ProviderListState) {
            providers = providerBlocState.value.data?.items ?? [];
            if (providers.isEmpty) {
              return Center(child: Text(appLocalizations(context).noProviders));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(title: appLocalizations(context).mobileOperators),
                accountLookupListItems!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: providers.length,
                        itemBuilder: (context, i) =>
                            OperatorListItem(item: providers[i]),
                      )
                    : BlocConsumer(
                        bloc: selectProviderBloc,
                        listener: (context, selectProviderState) {
                          if (selectProviderState is SelectProviderState) {
                            productListBloc.add(ProductListEvent(
                                regionCodes: regions!.first.regionCode,
                                accountNumber: tabController!.index == 0
                                    ? args!.contact!.phones.first.number
                                        .replaceAll(" ", "")
                                    : "",
                                providerCode:
                                    selectProviderState.provider.providerCode,
                                benefits: getBenefit(tabController!.index)));
                          }
                        },
                        builder: (context, selectProviderState) {
                          if (selectProviderState is SelectProviderState) {
                            return DropdownButton(
                              value: selectedProvider,
                              isExpanded: true,
                              itemHeight: null,
                              items: providers
                                  .map((provider) => DropdownMenuItem(
                                      value: provider,
                                      child: OperatorListItem(item: provider)))
                                  .toList(),
                              onChanged: (value) {
                                selectProviderBloc
                                    .add(SelectProviderEvent(value!));
                                selectedProvider = value;
                              },
                            );
                          }
                          return const Loader();
                        }),

                /// show products below
                plansView()
              ],
            );
          }
          return const Loader();
        },
      );
}

class PlansListView extends StatefulWidget {
  final String regionCode;
  final String mobileNo;
  final String providerCode;
  final String benefits;
  final Contact contact;

  const PlansListView({
    super.key,
    required this.regionCode,
    required this.mobileNo,
    required this.providerCode,
    required this.benefits,
    required this.contact,
  });

  @override
  State<PlansListView> createState() => _PlansListViewState();
}

class _PlansListViewState extends State<PlansListView> {
  @override
  void initState() {
    productListBloc.add(ProductListEvent(
        regionCodes: widget.regionCode,
        accountNumber: widget.mobileNo.replaceAll(" ", ""),
        providerCode: widget.providerCode,
        benefits: widget.benefits));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: productListBloc,
        listener: (context, state) {
          if (state is ProductListState) {}
        },
        builder: (context, state) {
          if (state is ProductListState) {
            var plans = state.value.data?.items ?? [];
            if (plans.isEmpty) {
              return Center(
                  child: Text(
                appLocalizations(context).noPlans,
              ));
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: plans.length,
              itemBuilder: (context, index) => PlanListItem(
                plan: plans[index],
                contact: widget.contact,
              ),
            );
          }
          return const Loader();
        });
  }
}

String getBenefit(int index) {
  String benefits = "";
  switch (index) {
    case 0:
      benefits = "";
      break;
    case 1:
      benefits = "Data";
      break;
    case 2:
      benefits = "Balance";
      break;
    case 3:
      benefits = "LongDistance";
      break;
  }
  return benefits;
}
