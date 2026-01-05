import 'package:bctpay/globals/index.dart';

class BankBalance extends StatefulWidget {
  final BankAccount? account;

  const BankBalance({super.key, this.account});

  @override
  State<BankBalance> createState() => _BankBalanceState();
}

class _BankBalanceState extends State<BankBalance> {
  var checkBankBalanceBloc = ApisBloc(ApisBlocInitialState());

  var bannersListBloc = ApisBloc(ApisBlocInitialState());

  @override
  void initState() {
    super.initState();
    bannersListBloc.add(BannersListEvent(page: 1, limit: 9999));
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as BankBalance;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(title: ""),
      body: Container(
        width: width,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PromotionalBannerSlider(),
            Column(
              children: [
                Text(
                  args.account!.bankname ?? "Unknown",
                  style: textTheme.displayLarge,
                ),
              ],
            ),
            Column(
              children: [
                BlocConsumer(
                    bloc: checkBankBalanceBloc
                      ..add(CheckBankBalanceEvent(accountId: args.account!.id)),
                    listener: (context, state) {
                      if (state is CheckBankBalanceState) {
                        if (state.value.code == 200) {
                        } else if (state.value.code ==
                            HTTPResponseStatusCodes.sessionExpireCode) {
                          sessionExpired(state.value.message, context);
                        } else {
                          showFailedDialog(state.value.message, context);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is CheckBankBalanceState &&
                          state.value.code == 200) {
                        double availableBalance = state.value.data
                                ?.responseContent?.availableBalance ??
                            0.00;
                        return Text(
                          formatCurrency(availableBalance.toStringAsFixed(2)),
                          style: textTheme.displayMedium!
                              .copyWith(color: themeLogoColorOrange),
                        );
                      }
                      return const Loader();
                    }),
                Text(
                  AppLocalizations.of(context)!.availableBalance,
                  style: textTheme.headlineSmall,
                ),
              ],
            ),
            SizedBox(
              height: height * 0.3,
            )
          ],
        ),
      ),
    );
  }
}
