import 'package:bctpay/globals/index.dart';

class AccountsListScreen extends StatefulWidget {
  final bool showAppbar;
  final String? titleText;

  const AccountsListScreen(
      {super.key, this.showAppbar = false, this.titleText});

  @override
  State<AccountsListScreen> createState() => _AccountsListScreenState();
}

class _AccountsListScreenState extends State<AccountsListScreen> {
  List<BankAccount> accountList = [];

  List<BankAccount> walletList = [];

  Offset position = Offset.zero;

  List<BankAccount> bankAccountsList = [];

  String? orderId;

  String? omToken;

  String? msisdnNumber = "7701101246";
  var otpController = TextEditingController();

  @override
  void initState() {
    bankAccountListBloc.add(GetBankAccountListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as AccountsListScreen?;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: args?.showAppbar ?? false
          ? CustomAppBar(
              title: args?.titleText ??
                  AppLocalizations.of(context)!.banksAndWallets,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.primaryAccountHistory);
                    },
                    icon: const Icon(Icons.history))
              ],
            )
          : null,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor:
                isDarkMode(context) ? themeLogoColorBlue : Colors.white,
            builder: (context) => AddBankAccountForm(
              bankAccountList: accountList,
              walletAccountList: walletList,
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: themeColorHeader,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener(
          bloc: verifyOrangeWalletBloc,
          listener: (context, state) {
            if (state is InitiateVerifyOMTxnState) {
              if (state.value.code ==
                  HTTPResponseStatusCodes.momoTxnSuccessCode) {
                orderId = state
                    .value.data?.thirdPartyTransactionRefrenceNumberWithUser;
                omToken = state.value.data?.omPaymentUrl?.split("/").last ?? "";
                showCustomDialog("", context,
                    body: Column(
                      children: [
                        Text(
                          appLocalizations(context).verificationCode,
                          style: textTheme(context).displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Pinput(
                          length: 6,
                          defaultPinTheme: defaultPinTheme,
                          controller: otpController,
                          onCompleted: (pin) {},
                        ),
                      ],
                    ), onYesTap: () {
                  verifyOrangeWalletBloc.add(
                    FinalizeOMPaymentEvent(
                        token: omToken ?? "",
                        msisdnNumber: msisdnNumber ?? "",
                        otp: otpController.text,
                        orderId: orderId ?? ""),
                  );
                  otpController.clear();
                  Navigator.pop(context);
                },
                    btnOkText: appLocalizations(context).submit,
                    btnNoText: appLocalizations(context).cancel);
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(state.value.message, context);
              } else {
                showFailedDialog(state.value.message, context);
              }
            }
            if (state is CheckoutVerifyOMTxnState) {
              if (state.value.code == 200) {
                bankAccountListBloc.add(GetBankAccountListEvent());
                showSuccessDialog(
                    state.value.message ?? state.value.error ?? "", context,
                    dismissOnBackKeyPress: false,
                    dismissOnTouchOutside: false, onOkBtnPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }

            if (state is FinalizeOMPaymentState) {
              if (state.value.code == 200 && state.value.data != null) {
                verifyOrangeWalletBloc
                    .add(CheckoutVerifyOMTxnEvent(orderId: orderId ?? ""));
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }
            if (state is ApisBlocErrorState) {
              showFailedDialog(state.message, context);
            }
          },
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
                        state.value.message ?? state.value.error ?? "",
                        context);
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
                  bankAccountListBloc.add(GetBankAccountListEvent());
                }
                if (state is GetBankAccountListState) {
                  if (state.value.code == 200) {
                    bankAccountsList = state.value.data ?? [];
                    accountList = bankAccountsList
                        .where((element) => element.accountRole == "BANK")
                        .toList();
                    walletList = bankAccountsList
                        .where((element) => element.accountRole == "WALLET")
                        .toList();
                  } else if (state.value.code ==
                      HTTPResponseStatusCodes.sessionExpireCode) {
                    sessionExpired(state.value.message, context);
                  }
                }
              },
              builder: (context, state) {
                if (bankAccountsList.isEmpty && state is ApisBlocLoadingState) {
                  return Loader();
                } else if (bankAccountsList.isEmpty) {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.noAccount,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ModalProgressHUD(
                  progressIndicator: Loader(),
                  inAsyncCall: state is ApisBlocLoadingState,
                  child: ListView(
                    children: [
                      if (accountList.isNotEmpty)
                        TitleWidget(
                          title: AppLocalizations.of(context)!.bank,
                        ),
                      AnimationLimiter(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: accountList.length,
                          itemBuilder: (context, index) => ListAnimation(
                            index: index,
                            child: AccountListItem(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.accountDetail,
                                    arguments: AccountDetail(
                                      account: accountList[index],
                                    ));
                              },
                              account: accountList[index],
                              showCheckBox: false,
                            ),
                          ),
                        ),
                      ),
                      10.height,
                      if (walletList.isNotEmpty)
                        TitleWidget(
                          title: AppLocalizations.of(context)!.wallet,
                        ),
                      AnimationLimiter(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: walletList.length,
                          itemBuilder: (context, index) => ListAnimation(
                            index: index,
                            child: AccountListItem(
                              account: walletList[index],
                              showCheckBox: false,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.accountDetail,
                                    arguments: AccountDetail(
                                      account: walletList[index],
                                    ));
                              },
                            ),
                          ),
                        ),
                      ),
                      10.height,
                      CardsList()
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
