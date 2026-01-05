import 'package:bctpay/globals/index.dart';

class AddBeneficiaryScreen extends StatefulWidget {
  final String selectedAccountRole;

  const AddBeneficiaryScreen({super.key, required this.selectedAccountRole});

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  var bankCodeController = TextEditingController();

  var accountNumberController = TextEditingController();
  var beneficiaryNameController = TextEditingController();
  var clientIdController = TextEditingController();
  var walletPhoneNumberController = TextEditingController();
  var selectedAccountRoleBloc = SelectionBloc(SelectionBlocInitialState());
  var selectedAccountRole = "BANK";

  var formKey = GlobalKey<FormState>();

  var selectBankBloc = SelectionBloc(SelectionBlocInitialState());

  String? countryPhoneCode;

  var enableSubmitBtnBloc = SelectionBloc(SelectBoolState(false));

  @override
  void initState() {
    var selectedAccountRole = widget.selectedAccountRole;
    selectedAccountRoleBloc.add(SelectStringEvent(selectedAccountRole));
    getProfileDetailFromLocalBloc.stream.listen((state) {
      if (state is SharedPrefGetUserDetailState) {
        var user = state.user;
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
      appBar: CustomAppBar(title: appLocalizations(context).addBeneficiary),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            BlocConsumer(
                bloc: selectedAccountRoleBloc,
                listener: (context, state) {
                  if (state is SelectStringState) {
                    selectedAccountRole = state.value ?? "BANK";
                  }
                  isValidated("");
                },
                builder: (context, state) {
                  if (state is SelectStringState) {
                    return Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              groupValue: state.value,
                              fillColor: WidgetStatePropertyAll(
                                isDarkMode ? Colors.white : Colors.black,
                              ),
                              title: Text(
                                appLocalizations(context).bank,
                                style: textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              value: "BANK",
                              onChanged: (value) {
                                selectedAccountRole = value!;
                                selectedAccountRoleBloc.add(
                                    SelectStringEvent(selectedAccountRole));
                                        banksListBloc.add(GetBanksListEvent(
                                            accountType: selectedAccountRole));
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              groupValue: state.value,
                              fillColor: WidgetStatePropertyAll(
                                isDarkMode ? Colors.white : Colors.black,
                              ),
                              title: Text(
                                appLocalizations(context).wallet,
                                style: textTheme.bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              value: "WALLET",
                              onChanged: (value) {
                                selectedAccountRole = value!;
                                selectedAccountRoleBloc.add(
                                    SelectStringEvent(selectedAccountRole));
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
                              accountType: selectedAccountRole,
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
                              hintText:
                                  appLocalizations(context).enterAccountNumber,
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
                              labelText:
                                  "${appLocalizations(context).beneficiaryName} *",
                              hintText: appLocalizations(context)
                                  .enterBeneficiaryName,
                              validator: (String? p1) {
                                if (p1!.isEmpty) {
                                  return appLocalizations(context)
                                      .pleaseEnterBeneficiaryName;
                                } else if (!specialCharRegex.hasMatch(p1)) {
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
                              hintText: appLocalizations(context).enterClientId,
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
                              accountType: selectedAccountRole,
                            ),
                            CustomTextField(
                              controller: beneficiaryNameController,
                              labelText:
                                  "${appLocalizations(context).beneficiaryName} *",
                              hintText: appLocalizations(context)
                                  .enterBeneficiaryName,
                              validator: (String? p1) {
                                if (p1!.isEmpty) {
                                  return appLocalizations(context)
                                      .pleaseEnterBeneficiaryName;
                                } else if (!specialCharRegex.hasMatch(p1)) {
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
                              prefixWidget: const CountryPickerTxtFieldPrefix(
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
              },
            ),
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
                              listener: (context, selectBankBlocState) {
                                if (selectBankBlocState is SelectBankState) {}
                              },
                              builder: (context, selectBankBlocState) {
                                if (selectBankBlocState is SelectBankState) {
                                  return CustomBtn(
                                    text: appLocalizations(context).submit,
                                    onTap: (selectBankBlocState.bank == null ||
                                            !isValidated)
                                        ? null
                                        : () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (countryPhoneCode != null) {
                                                beneficiaryListBloc
                                                    .add(AddBeneficiaryEvent(
                                                  bankcode:
                                                      bankCodeController.text,
                                                  bankname: selectBankBlocState
                                                      .bank!.name,
                                                  accountnumber:
                                                      accountNumberController
                                                          .text,
                                                  beneficiaryname:
                                                      beneficiaryNameController
                                                          .text,
                                                  clientId:
                                                      clientIdController.text,
                                                  accountRole:
                                                      selectedAccountRole,
                                                  walletPhoneNumber:
                                                      walletPhoneNumberController
                                                          .text,
                                                  phoneCode: countryPhoneCode!,
                                                ));
                                                Navigator.pop(context);
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
                                  text: appLocalizations(context).submit,
                                );
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
  }

  void isValidated(String p0) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      enableSubmitBtnBloc
          .add(SelectBoolEvent(formKey.currentState!.validate()));
    });
  }
}
