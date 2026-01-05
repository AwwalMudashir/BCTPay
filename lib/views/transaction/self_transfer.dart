import 'package:bctpay/globals/index.dart';

class SelfTransferScreen extends StatefulWidget {
  const SelfTransferScreen({
    super.key,
  });

  @override
  State<SelfTransferScreen> createState() => _SelfTransferScreenState();
}

class _SelfTransferScreenState extends State<SelfTransferScreen> {
  BankAccount? toAccount;
  List<BankAccount> toAccountList = [];
  var selectAccountBloc = SelectionBloc(SelectionBlocInitialState());

  @override
  void initState() {
    bankAccountListBloc.add(GetBankAccountListEvent());
    selectAccountBloc.add(SelectAccountEvent(null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var args = ModalRoute.of(context)?.settings.arguments as RouteArguments;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
          title: args.isRequestToPay
              ? appLocalizations(context).selectAccountToReceiveInto
              : appLocalizations(context).transferMoneyTo),
      body: BlocConsumer(
          bloc: bankAccountListBloc,
          listener: (context, state) {
            if (state is GetBankAccountListState) {
              if (state.value.code == 200) {
                var accountList = state.value.data ?? [];
                toAccountList = accountList
                    .where((account) => account.accountstatus == "1")
                    .toList();
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(state.value.message, context);
              }
            }
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
          },
          builder: (context, state) {
            if (state is GetBankAccountListState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    toAccountList.isEmpty
                        ? Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.noAccount,
                                  style: textTheme.titleMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                AddAccount(
                                  accountList: toAccountList,
                                )
                              ],
                            ),
                          )
                        : BlocConsumer(
                            bloc: selectAccountBloc,
                            listener: (context, selectAccountState) {
                              if (selectAccountState is SelectAccountState) {
                                toAccount = selectAccountState.account;
                              }
                            },
                            builder: (context, selectAccountState) {
                              if (selectAccountState is SelectAccountState) {
                                return Column(
                                  children: [
                                    AnimationLimiter(
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: toAccountList.length,
                                        itemBuilder: (context, index) =>
                                            ListAnimation(
                                          index: index,
                                          child: AccountListItem(
                                            showPoupMenuBtn: false,
                                            account: toAccountList[index],
                                            isSelected:
                                                selectAccountState.account ==
                                                    toAccountList[index],
                                            onTap: () {
                                              toAccount = toAccountList[index];
                                              selectAccountBloc.add(
                                                  SelectAccountEvent(
                                                      toAccount));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    CustomBtn(
                                      maxWidth: double.infinity,
                                      text: appLocalizations(context).continue1,
                                      onTap: toAccount == null
                                          ? null
                                          : () {
                                              if (toAccount != null) {
                                                if (args.isRequestToPay) {
                                                  Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .requestToPayDetail,
                                                      arguments:
                                                          RequestToPayDetail(
                                                        requestToContact: args
                                                            .requestToContact,
                                                        receivableAccount:
                                                            toAccount,
                                                      ));
                                                } else {
                                                  Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .transactiondetail,
                                                      arguments:
                                                          TransactionDetailScreen(
                                                        toAccount: toAccount,
                                                        isSelfTransfer: true,
                                                      ));
                                                }
                                              } else {
                                                showToast(
                                                    appLocalizations(context)
                                                        .selectAccount);
                                              }
                                            },
                                    ),
                                  ],
                                );
                              }
                              return const Loader();
                            }),
                  ],
                ),
              );
            }
            return const Loader();
          }),
    );
  }
}

class AddAccount extends StatelessWidget {
  final List<BankAccount> accountList;

  const AddAccount({super.key, required this.accountList});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor:
              isDarkMode(context) ? themeLogoColorBlue : Colors.white,
          builder: (context) => AddBankAccountForm(
            bankAccountList:
                accountList.where((e) => e.accountRole == "BANK").toList(),
            walletAccountList:
                accountList.where((e) => e.accountRole == "WALLET").toList(),
          ),
        );
      },
      child: Container(
        decoration: shadowDecoration.copyWith(color: tileColor),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
                height: 50,
                width: 50,
                decoration: shadowDecoration.copyWith(color: tileColor),
                child: Image.asset(Assets.assetsImagesAddBank)),
            const SizedBox(
              width: 10,
            ),
            Text(
              appLocalizations(context).addBankAccountSelfTransfer,
              style: textTheme.bodyLarge?.copyWith(color: Colors.black),
            ),
            const Spacer(),
            Container(
                height: 30,
                width: 30,
                decoration: shadowDecoration,
                padding: const EdgeInsets.all(5),
                child: Image.asset(Assets.assetsImagesAdd))
          ],
        ),
      ),
    );
  }
}
