import 'package:bctpay/globals/index.dart';

class KYCHistory extends StatefulWidget {
  const KYCHistory({super.key});

  @override
  State<KYCHistory> createState() => _KYCHistoryState();
}

class _KYCHistoryState extends State<KYCHistory> {
  var kycHistoryBloc = ApisBloc(ApisBlocInitialState());
  var loadingBloc = SelectionBloc(SelectBoolState(false));

  var scrollController = ScrollController();
  int page = 1;
  int limit = 10;

  List<KycList> kycHistoryList = [];

  void pagination() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      loadingBloc.add(SelectBoolEvent(true));
      kycHistoryBloc.add(GetKYCHistoryEvent(limit: limit, page: page));
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(pagination);
    kycHistoryBloc.add(GetKYCHistoryEvent(limit: limit, page: page));
  }

  @override
  void dispose() {
    scrollController.removeListener(pagination);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).kycHistory),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: BlocConsumer(
            bloc: kycHistoryBloc,
            listener: (context, state) {
              if (state is GetKYCHistoryState) {
                if (state.value.code == 200) {
                  page++;
                  loadingBloc.add(SelectBoolEvent(false));
                  kycHistoryList.addAll(state.value.data ?? []);
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                }
              }
            },
            builder: (context, state) {
              if (state is GetKYCHistoryState) {
                if (kycHistoryList.isEmpty) {
                  return Center(
                    child: Text(appLocalizations(context).noKycHistory),
                  );
                }
                return AnimationLimiter(
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: kycHistoryList.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) => ListAnimation(
                      index: index,
                      child: Column(
                        children: [
                          KYCHistoryListItem(kyc: kycHistoryList[index]),
                          if (index == kycHistoryList.length - 1)
                            BlocBuilder(
                                bloc: loadingBloc,
                                builder: (context, loadingState) {
                                  if (loadingState is SelectBoolState) {
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
    );
  }
}
