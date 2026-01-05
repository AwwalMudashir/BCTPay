import 'package:bctpay/globals/index.dart';

class SelectAccountFromList extends StatefulWidget {
  final BankAccount? beneficiary;

  const SelectAccountFromList({super.key, this.beneficiary});

  @override
  State<SelectAccountFromList> createState() => _SelectAccountFromListState();
}

class _SelectAccountFromListState extends State<SelectAccountFromList> {
  List<BankAccount> accountList = [];
  List<BankAccount> walletList = [];
  Offset position = Offset.zero;

  @override
  void initState() {
    bankAccountListBloc.add(GetBankAccountListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as SelectAccountFromList;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.payWith,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.popUntil(context,
                    (route) => route.settings.name == AppRoutes.bottombar);
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer(
            bloc: bankAccountListBloc,
            listener: (context, state) {
              if (state is AddBankAccountState) {
                if (state.value.code == 200) {
                  showSuccessDialog(state.value.message, context);
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                } else {
                  showFailedDialog(state.value.message, context);
                }
                bankAccountListBloc.add(GetBankAccountListEvent());
              }
              if (state is DeleteBankAccountState) {
                if (state.value.code == 200) {
                  showSuccessDialog(state.value.message, context);
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                } else {
                  showFailedDialog(state.value.message, context);
                }
                bankAccountListBloc.add(GetBankAccountListEvent());
              }
              if (state is UpdateBankAccountState) {
                if (state.value.code == 200) {
                  showSuccessDialog(state.value.message, context);
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                } else {
                  showFailedDialog(state.value.message, context);
                }
                bankAccountListBloc.add(GetBankAccountListEvent());
              }
              if (state is SetPrimaryAccountState) {
                if (state.value.code == 200) {
                  showSuccessDialog(state.value.message, context);
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                } else {
                  showFailedDialog(state.value.message, context);
                }
                bankAccountListBloc.add(GetBankAccountListEvent());
              }
              if (state is SetActiveAccountState) {
                if (state.value.code == 200) {
                  showSuccessDialog(
                      state.value.message ?? state.value.error ?? "", context);
                } else if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(
                      state.value.message ?? state.value.error ?? "", context);
                } else {
                  showFailedDialog(
                      state.value.message ?? state.value.error ?? "", context);
                }
                bankAccountListBloc.add(GetBankAccountListEvent());
              }
              if (state is GetBankAccountListState) {
                if (state.value.code ==
                    HTTPResponseStatusCodes.sessionExpireCode) {
                  sessionExpired(state.value.message, context);
                }
              }
            },
            builder: (context, state) {
              if (state is GetBankAccountListState) {
                var bankAccountsList = state.value.data ?? [];
                accountList = bankAccountsList
                    .where((element) => element.accountRole == "BANK")
                    .toList();
                walletList = bankAccountsList
                    .where((element) => element.accountRole == "WALLET")
                    .toList();
                if (bankAccountsList.isEmpty) {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.noAccount,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView(
                  children: [
                    if (accountList.isNotEmpty)
                      TitleWidget(
                        title: AppLocalizations.of(context)!.bank,
                      ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: accountList.length,
                      itemBuilder: (context, index) => AccountListItem(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.transactiondetail,
                            arguments: TransactionDetailScreen(
                              toAccount: args.beneficiary,
                            ),
                          );
                        },
                        account: accountList[index],
                        showCheckBox: false,
                      ),
                    ),
                    if (walletList.isNotEmpty)
                      TitleWidget(
                        title: AppLocalizations.of(context)!.wallet,
                      ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: walletList.length,
                      itemBuilder: (context, index) => AccountListItem(
                        account: walletList[index],
                        showCheckBox: false,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.transactiondetail,
                            arguments: TransactionDetailScreen(
                              toAccount: args.beneficiary,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              }
              return const Loader();
            }),
      ),
    );
  }
}
