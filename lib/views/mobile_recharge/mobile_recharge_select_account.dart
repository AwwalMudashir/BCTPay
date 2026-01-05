import 'package:bctpay/globals/index.dart';

class MobileRechargeSelectAccount extends StatefulWidget {
  final Plan? plan;
  final Contact? contact;

  const MobileRechargeSelectAccount({super.key, this.plan, this.contact});

  @override
  State<MobileRechargeSelectAccount> createState() =>
      _MobileRechargeSelectAccountState();
}

class _MobileRechargeSelectAccountState
    extends State<MobileRechargeSelectAccount> {
  List<BankAccount> bankAccountList = [];
  List<BankAccount> walletList = [];
  BankAccount? selectedAccount;
  var mobileRechargeBloc = ApisBloc(ApisBlocInitialState());

  var momoIdController = TextEditingController();

  @override
  void initState() {
    bankAccountListBloc.add(GetBankAccountListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments
        as MobileRechargeSelectAccount;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: appLocalizations(context).payWith),
      body: BlocConsumer(
          bloc: mobileRechargeBloc,
          listener: (context, state) {
            if (state is BillPaymentState) {
              if (state.value.code == 200) {
                showRechargeSuccessfulDialog(state.value);
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(state.value.message, context);
              } else {
                showFailedDialog(state.value.message, context);
              }
            }
            if (state is ApisBlocErrorState) {
              showFailedDialog(state.message, context);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is ApisBlocLoadingState,
              progressIndicator: const Loader(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    CustomTextField(
                      controller: momoIdController,
                      labelText: appLocalizations(context).momoId,
                      hintText: appLocalizations(context).enterMomoId,
                    ),
                    TitleWidget(
                      title: AppLocalizations.of(context)!.selectAccount,
                    ),
                    BlocConsumer(
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
                                  state.value.message ??
                                      state.value.error ??
                                      "",
                                  context);
                            } else if (state.value.code ==
                                HTTPResponseStatusCodes.sessionExpireCode) {
                              sessionExpired(
                                  state.value.message ??
                                      state.value.error ??
                                      "",
                                  context);
                            } else {
                              showFailedDialog(
                                  state.value.message ??
                                      state.value.error ??
                                      "",
                                  context);
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
                            var accountList = state.value.data ?? [];
                            bankAccountList = accountList
                                .where(
                                    (element) => element.accountRole == "BANK")
                                .toList();
                            return bankAccountList.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!.noAccount,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  )
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: bankAccountList.length,
                                    itemBuilder: (context, index) =>
                                        AccountListItem(
                                      onTap: () {
                                        selectedAccount =
                                            bankAccountList[index];
                                        setState(() {});
                                      },
                                      isSelected: selectedAccount ==
                                          bankAccountList[index],
                                      account: bankAccountList[index],
                                      showCheckBox: true,
                                      showPoupMenuBtn: false,
                                    ),
                                  );
                          }
                          return const Loader();
                        }),
                    TitleWidget(
                      title: AppLocalizations.of(context)!.wallet,
                    ),
                    BlocBuilder(
                        bloc: bankAccountListBloc,
                        builder: (context, state) {
                          if (state is GetBankAccountListState) {
                            var accountList = state.value.data ?? [];
                            walletList = accountList
                                .where((element) =>
                                    element.accountRole == "WALLET")
                                .toList();
                            return walletList.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!.noWallet,
                                    ),
                                  )
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: walletList.length,
                                    itemBuilder: (context, index) =>
                                        AccountListItem(
                                      account: walletList[index],
                                      isSelected:
                                          selectedAccount == walletList[index],
                                      showCheckBox: true,
                                      showPoupMenuBtn: false,
                                      onTap: () {
                                        selectedAccount = walletList[index];
                                        setState(() {});
                                      },
                                    ),
                                  );
                          }
                          return const Loader();
                        }),
                    CustomBtn(
                      text: appLocalizations(context).pay,
                      onTap: () {
                        if (selectedAccount != null) {
                          mobileRechargeBloc.add(BillPaymentEvent(
                              paymentwith: "momo",
                              amount: args.plan!.minimum.sendValue,
                              customerPhone: args.contact!.phones.first.number,
                              skuCode: args.plan!.skuCode,
                              sendCurrencyIso:
                                  args.plan!.minimum.sendCurrencyIso,
                              accountNumber: selectedAccount!.accountnumber ??
                                  selectedAccount!.walletPhonenumber!));
                        } else {
                          showFailedDialog(
                              appLocalizations(context).selectAccount, context);
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  void showRechargeSuccessfulDialog(BillPaymentResponse billPaymentResponse) {
    var textTheme = Theme.of(context).textTheme;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Image.asset(
                Assets.assetsImagesRechargeSuccessDialog,
                width: 121,
                height: 121,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(appLocalizations(context).recharge,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: themeYellowColor,
                      )),
                  Text(
                    appLocalizations(context).rechargehasBeenSuccessfullyDone,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                      formatCurrency(
                          billPaymentResponse.data!.payableAmount ?? "0.00"),
                      style: const TextStyle(
                          fontSize: 31,
                          fontWeight: FontWeight.w500,
                          color: themeGreyColor)),
                  IconButton(
                      onPressed: () {
                        Navigator.popUntil(
                            context,
                            (route) =>
                                route.settings.name == AppRoutes.bottombar);
                      },
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 40,
                        color: themeGreyColor,
                      ))
                ],
              ),
            ));
  }
}
