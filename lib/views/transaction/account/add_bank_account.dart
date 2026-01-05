import 'package:bctpay/globals/index.dart';

class AddBankAccountForm extends StatefulWidget {
  final List<BankAccount> bankAccountList;
  final List<BankAccount> walletAccountList;

  const AddBankAccountForm(
      {super.key,
      required this.bankAccountList,
      required this.walletAccountList});

  @override
  State<AddBankAccountForm> createState() => _AddBankAccountFormState();
}

class _AddBankAccountFormState extends State<AddBankAccountForm> {
  var bankCodeController = TextEditingController();

  var accountNumberController = TextEditingController();
  var beneficiaryNameController = TextEditingController();
  var clientIdController = TextEditingController();
  var walletPhoneNumberController = TextEditingController();
  var selectedAccountRole = "BANK";
  var selectBankBloc = SelectionBloc(SelectionBlocInitialState());

  var formKey = GlobalKey<FormState>();

  var selectedAccountRoleBloc = SelectionBloc(SelectionBlocInitialState());

  var accountLimitBloc = ApisBloc(ApisBlocInitialState());

  String? countryPhoneCode;

  int totalBankAccountAllowed = 0;
  int totalSameBankAccountAllowed = 0;
  int totalWalletAccountAllowed = 0;
  int totalSameWalletAccountAllowed = 0;

  bool canAddAccount = false;

  var enableSubmitBtnBloc = SelectionBloc(SelectBoolState(false));

  var verifyOrangeWalletBloc = ApisBloc(ApisBlocInitialState());

  String? orderId;

  String? omToken;

  String? msisdnNumber = "7701101246";
  var otpController = TextEditingController();

  @override
  void initState() {
    accountLimitBloc.stream.listen((state) {
      if (state is AccountLimitState) {
        if (state.value.code == 200) {
          var bankAccountLimitData = state.value.data!.accountPermissions
              .where((e) => e.accountType == "BANK");
          if (bankAccountLimitData.isNotEmpty) {
            totalBankAccountAllowed =
                bankAccountLimitData.first.totalAccountAllowed;
            totalSameBankAccountAllowed =
                bankAccountLimitData.first.totalSameAccountAllowed;
          }
          var walletAccountLimitData = state.value.data!.accountPermissions
              .where((e) => e.accountType == "WALLET");
          if (walletAccountLimitData.isNotEmpty) {
            totalWalletAccountAllowed =
                walletAccountLimitData.first.totalAccountAllowed;
            totalSameWalletAccountAllowed =
                walletAccountLimitData.first.totalSameAccountAllowed;
          }
        } else if (state.value.code ==
            HTTPResponseStatusCodes.sessionExpireCode) {
          if (!mounted) return;
          sessionExpired(state.value.message, context);
        }
      }
    });
    accountLimitBloc.add(GetAccountLimitEvent());
    selectedAccountRoleBloc.add(SelectStringEvent(selectedAccountRole));

    getProfileDetailFromLocalBloc.stream.listen((state) {
      if (state is SharedPrefGetUserDetailState) {
        var user = state.user;
        beneficiaryNameController.text = user.userName;
        countryPhoneCode = user.phoneCode;

        seperatePhoneAndDialCode(user.phoneCode).then((country) {
          if (country != null) {}
        });
      }
    });
    getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: appLocalizations(context).addBankAccount),
      body: BlocConsumer(
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
                          style: textTheme.displayMedium,
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
          builder: (context, verifyOrangeWalletState) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: verifyOrangeWalletState is ApisBlocLoadingState,
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    BlocConsumer(
                        bloc: selectedAccountRoleBloc,
                        listener: (context, state) {
                          if (state is SelectStringState) {}
                          isValidated("");
                        },
                        builder: (context, state) {
                          if (state is SelectStringState) {
                            return Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                      groupValue: state.value,
                                      fillColor: WidgetStatePropertyAll(
                                        isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      title: Text(
                                        appLocalizations(context).bank,
                                        style: textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      value: "BANK",
                                      onChanged: (value) {
                                        selectedAccountRole = value!;
                                        selectedAccountRoleBloc.add(
                                            SelectStringEvent(
                                                selectedAccountRole));
                                        banksListBloc.add(GetBanksListEvent(
                                            accountType: selectedAccountRole));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      groupValue: state.value,
                                      fillColor: WidgetStatePropertyAll(
                                        isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      title: Text(
                                        appLocalizations(context).wallet,
                                        style: textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      value: "WALLET",
                                      onChanged: (value) {
                                        selectedAccountRole = value!;
                                        selectedAccountRoleBloc.add(
                                            SelectStringEvent(
                                                selectedAccountRole));
                                        banksListBloc.add(GetBanksListEvent(
                                            accountType: selectedAccountRole));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const Loader();
                        }),
                    BlocBuilder(
                        bloc: selectedAccountRoleBloc,
                        builder: (context, state) {
                          if (state is SelectStringState) {
                            return state.value == "BANK"
                                ? Column(
                                    children: [
                                      SelectBankDropDown(
                                        selectBankBloc: selectBankBloc,
                                        accountType: state.value!,
                                      ),
                                      CustomTextField(
                                        controller: bankCodeController,
                                        labelText:
                                            "${appLocalizations(context).institutionCode} *",
                                        hintText: appLocalizations(context)
                                            .enterInstitutionCode,
                                        validator: (String? p1) {
                                          if (p1!.isEmpty) {
                                            return appLocalizations(context)
                                                .pleaseEnterInstitutionCode;
                                          } else if (!specialCharWithoutSpaceRegex
                                              .hasMatch(p1)) {
                                            return appLocalizations(context)
                                                .pleaseEnterValidValue;
                                          }
                                          return null;
                                        },
                                        onChanged: isValidated,
                                      ),
                                      CustomTextField(
                                        controller: accountNumberController,
                                        labelText:
                                            "${appLocalizations(context).accountNumber} *",
                                        hintText: appLocalizations(context)
                                            .enterAccountNumber,
                                        validator: (String? p1) {
                                          if (p1!.isEmpty) {
                                            return appLocalizations(context)
                                                .pleaseEnterAccountNumber;
                                          } else if (!specialCharWithoutSpaceRegex
                                              .hasMatch(p1)) {
                                            return appLocalizations(context)
                                                .pleaseEnterValidValue;
                                          }
                                          return null;
                                        },
                                        onChanged: isValidated,
                                      ),
                                      CustomTextField(
                                        controller: beneficiaryNameController,
                                        readOnly: true,
                                        labelText:
                                            "${appLocalizations(context).accountHolderName} *",
                                        hintText: appLocalizations(context)
                                            .enterAccountHolderName,
                                        validator: (String? p1) {
                                          if (p1!.isEmpty) {
                                            return appLocalizations(context)
                                                .pleaseEnterAccountHolderName;
                                          } else if (!specialCharRegex
                                              .hasMatch(p1)) {
                                            return appLocalizations(context)
                                                .pleaseEnterValidValue;
                                          }
                                          return null;
                                        },
                                        onChanged: isValidated,
                                      ),
                                      CustomTextField(
                                        controller: clientIdController,
                                        labelText:
                                            "${appLocalizations(context).clientId} *",
                                        hintText: appLocalizations(context)
                                            .enterClientId,
                                        validator: (String? p1) {
                                          if (p1!.isEmpty) {
                                            return appLocalizations(context)
                                                .pleaseEnterClientID;
                                          } else if (!specialCharWithoutSpaceRegex
                                              .hasMatch(p1)) {
                                            return appLocalizations(context)
                                                .pleaseEnterValidValue;
                                          }
                                          return null;
                                        },
                                        onChanged: isValidated,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SelectBankDropDown(
                                        selectBankBloc: selectBankBloc,
                                        accountType: state.value!,
                                      ),
                                      CustomTextField(
                                        controller: beneficiaryNameController,
                                        readOnly: true,
                                        labelText:
                                            "${appLocalizations(context).accountHolderName} *",
                                        hintText: appLocalizations(context)
                                            .enterAccountHolderName,
                                        validator: (String? p1) {
                                          if (p1!.isEmpty) {
                                            return appLocalizations(context)
                                                .pleaseEnterAccountHolderName;
                                          } else if (!specialCharRegex
                                              .hasMatch(p1)) {
                                            return appLocalizations(context)
                                                .pleaseEnterValidValue;
                                          }
                                          return null;
                                        },
                                        onChanged: isValidated,
                                      ),
                                      CustomTextField(
                                        controller: walletPhoneNumberController,
                                        keyboardType: TextInputType.number,
                                        labelText:
                                            "${appLocalizations(context).walletPhoneNumber} *",
                                        hintText: appLocalizations(context)
                                            .enterWalletPhoneNumber,
                                        onChanged: isValidated,
                                        prefixWidget:
                                            const CountryPickerTxtFieldPrefix(
                                          readOnly: true,
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return appLocalizations(context)
                                                .pleaseEnterWalletPhoneNumber;
                                          }
                                          if (countryPhoneCode == "+224" &&
                                              !gnPhoneRegx.hasMatch(value)) {
                                            return appLocalizations(context)
                                                .pleaseEnterValidWalletPhoneNumber;
                                          } else if (!validatePhone(value)) {
                                            return appLocalizations(context)
                                                .pleaseEnterValidWalletPhoneNumber;
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  );
                          }
                          return const Loader();
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: BlocBuilder(
                              bloc: enableSubmitBtnBloc,
                              builder: (context, enableSubmitBtnState) {
                                if (enableSubmitBtnState is SelectBoolState) {
                                  bool isValidated = enableSubmitBtnState.value;
                                  return BlocConsumer(
                                      bloc: selectBankBloc,
                                      listener: (context, state) {
                                        if (state is SelectBankState) {
                                          if (selectedAccountRole == "BANK") {
                                            canAddAccount = checkLimit(
                                              accountList:
                                                  widget.bankAccountList,
                                              accountLimit:
                                                  totalBankAccountAllowed,
                                              sameAccountLimit:
                                                  totalSameBankAccountAllowed,
                                              bankName: state.bank?.name ?? "",
                                              context: context,
                                            );
                                          } else if (selectedAccountRole ==
                                              "WALLET") {
                                            canAddAccount = checkLimit(
                                              accountList:
                                                  widget.walletAccountList,
                                              accountLimit:
                                                  totalWalletAccountAllowed,
                                              sameAccountLimit:
                                                  totalSameWalletAccountAllowed,
                                              bankName: state.bank?.name ?? "",
                                              context: context,
                                            );
                                          }
                                        }
                                      },
                                      builder: (context, selectBankBlocState) {
                                        if (selectBankBlocState
                                            is SelectBankState) {
                                          return CustomBtn(
                                            text: appLocalizations(context)
                                                .submit,
                                            onTap: (selectBankBlocState.bank ==
                                                        null ||
                                                    !canAddAccount ||
                                                    !isValidated)
                                                ? null
                                                : () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      if (countryPhoneCode !=
                                                          null) {
                                                        if (selectBankBlocState
                                                            .bank!.name
                                                            .toLowerCase()
                                                            .contains(
                                                                "orange")) {
                                                          verifyOrangeWalletBloc.add(
                                                              InitiateVerifyOMTxnEvent(
                                                                  phoneCode:
                                                                      countryPhoneCode!,
                                                                  phoneNumber:
                                                                      walletPhoneNumberController
                                                                          .text,
                                                                  returnUrl:
                                                                      orangeMoneyReturnUrl,
                                                                  cancelUrl:
                                                                      orangeMoneyCancelUrl));
                                                        } else {
                                                          bankAccountListBloc
                                                              .add(
                                                            AddBankAccountEvent(
                                                                bankcode:
                                                                    bankCodeController
                                                                        .text,
                                                                bankname:
                                                                    selectBankBlocState
                                                                        .bank!
                                                                        .name,
                                                                accountnumber:
                                                                    accountNumberController
                                                                        .text,
                                                                beneficiaryname:
                                                                    beneficiaryNameController
                                                                        .text,
                                                                clientId:
                                                                    clientIdController
                                                                        .text,
                                                                accountRole:
                                                                    selectedAccountRole,
                                                                walletPhoneNumber:
                                                                    walletPhoneNumberController
                                                                        .text,
                                                                phoneCode:
                                                                    countryPhoneCode!),
                                                          );
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      } else {
                                                        showToast(appLocalizations(
                                                                context)
                                                            .pleaseSelectCountryPhoneCode);
                                                      }
                                                    }
                                                  },
                                          );
                                        }
                                        return CustomBtn(
                                            text: appLocalizations(context)
                                                .submit);
                                      });
                                }
                                return const Loader();
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomBtn(
                            color: Colors.red,
                            text: appLocalizations(context).cancel,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void isValidated(String p0) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      enableSubmitBtnBloc
          .add(SelectBoolEvent(formKey.currentState!.validate()));
    });
  }
}

bool checkLimit(
    {required List<BankAccount> accountList,
    required int accountLimit,
    required int sameAccountLimit,
    required String? bankName,
    required BuildContext context}) {
  //Check how many bank accounts added
  int totalAddedAccountsCount = accountList.length;
  if (totalAddedAccountsCount >= accountLimit) {
    showFailedDialog(
        appLocalizations(context)
            .cantAddMoreAccountsForThisBankYouHaveReachedTheLimit,
        context);
    return false;
  } else {
    //check same bank accounts limit
    int totalAddedSameAccountsCount =
        accountList.where((bank) => bankName == bank.bankname).length;
    if (totalAddedSameAccountsCount >= sameAccountLimit) {
      //reached the limit
      showFailedDialog(
          appLocalizations(context)
              .cantAddMoreAccountsForThisBankYouHaveReachedTheLimit,
          context);
      return false;
    } else {
      ///you can add accounts
      return true;
    }
  }
}
