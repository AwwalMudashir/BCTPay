import 'package:bctpay/globals/index.dart';
import 'package:bctpay/views/widget/custom_txtfield.dart';

Offset position = Offset.zero;

class AccountListItem extends StatelessWidget {
  final BankAccount account;
  final bool showCheckBox;
  final bool showPoupMenuBtn;
  final bool showSetPrimaryBtnAndAccountStatus;
  final bool isSelected;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function(TapUpDetails)? onTapUp;

  final Color? bgColor;

  final double? elevation;

  final double? leadingDimension;

  const AccountListItem({
    super.key,
    required this.account,
    this.showCheckBox = true,
    this.showPoupMenuBtn = true,
    this.showSetPrimaryBtnAndAccountStatus = true,
    this.onTap,
    this.onLongPress,
    this.onTapUp,
    this.isSelected = false,
    this.bgColor,
    this.elevation = 5,
    this.leadingDimension = 80,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      onLongPressStart: (p0) {
        position = p0.globalPosition;
      },
      child: Card(
        color: account.primaryaccount != "YES"
            ? bgColor ?? tileColor
            : Color(0xFF836224).withValues(alpha: 0.9),
        elevation: elevation,
        margin: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: account.id,
                child: SizedBox.square(
                  dimension: leadingDimension,
                  child: Card(
                      color: tileColor,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                              imageUrl: "$baseUrlBankLogo${account.logo}",
                              progressIndicatorBuilder:
                                  progressIndicatorBuilder,
                              errorWidget:
                                  (BuildContext c, String s, Object o) =>
                                      const Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                      )),
                        ),
                      )),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                account.beneficiaryname ??
                                    appLocalizations(context).unknown,
                                style: textTheme.titleSmall?.copyWith(
                                    color: account.primaryaccount != "YES"
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    selectedCountry!.countryCode,
                                    style: textTheme.headlineSmall?.copyWith(
                                      color: account.primaryaccount != "YES"
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CountryFlag.fromCountryCode(
                                    selectedCountry!.countryCode,
                                    height: 20,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    account.accountRole == "BANK"
                                        ? (account.accountnumber ?? "")
                                            .showLast4HideAll()
                                        : ("${account.phoneCode ?? ""} ${(account.accountnumber ?? "").showLast4HideAll()}"),
                                    style: textTheme.headlineSmall?.copyWith(
                                      color: account.primaryaccount != "YES"
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (showCheckBox)
                          Checkbox(
                            value: isSelected,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onChanged: null,
                          ),
                        if (showPoupMenuBtn) _popupMenuBtn(context)
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    if (showSetPrimaryBtnAndAccountStatus)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (account.primaryaccount != "YES" &&
                              account.accountstatus == "1")
                            InkWell(
                              onTap: () {
                                bankAccountListBloc.add(
                                    SetPrimaryAccountEvent(account: account));
                              },
                              child: Row(
                                children: [
                                  Radio(
                                    groupValue: true,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    fillColor: const WidgetStatePropertyAll(
                                        Colors.black),
                                    visualDensity: VisualDensity.compact,
                                    value: account.primaryaccount == "YES",
                                    onChanged: (value) {
                                      bankAccountListBloc.add(
                                          SetPrimaryAccountEvent(
                                              account: account));
                                    },
                                  ),
                                  Text(
                                    appLocalizations(context).setPrimary,
                                    style: textTheme.headlineSmall?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (account.primaryaccount == "YES")
                            const PrimaryStatusView(),
                          const SizedBox(
                            width: 5,
                          ),
                          ActiveInactiveStatusView(
                            isActive: account.accountstatus == "1",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          VerifiedNotVerifiedStatusView(
                            isVerified: account.verifystatus == "1",
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onDeleteTapped(BuildContext context) {
    showCustomDialog(
      appLocalizations(context).doYouReallyWantToDeleteThisAccount,
      context,
      title: appLocalizations(context).warning,
      dialogType: DialogType.warning,
      onYesTap: () {
        bankAccountListBloc.add(DeleteBankAccountEvent(
          account: account,
        ));
        Navigator.pop(context);
      },
    );
  }

  PopupMenuButton _popupMenuBtn(BuildContext context) => PopupMenuButton(
      color: isDarkMode(context) ? themeLogoColorBlue : Colors.white,
      icon: const Icon(Icons.more_vert),
      iconColor: Colors.black,
      itemBuilder: (context) => [
            if (account.primaryaccount != "YES")
              PopupMenuItem(
                child: Text(appLocalizations(context).delete),
                onTap: () {
                  onDeleteTapped(context);
                },
              ),
            if (account.primaryaccount != "YES")
              PopupMenuItem(
                child: Text(account.accountstatus == "0"
                    ? appLocalizations(context).setActive
                    : appLocalizations(context).setInActive),
                onTap: () {
                  bankAccountListBloc
                      .add(SetActiveAccountEvent(account: account));
                },
              ),
            PopupMenuItem(
              child: Text(appLocalizations(context).viewAccount),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.accountDetail,
                    arguments: AccountDetail(
                      account: account,
                    ));
              },
            ),
          ]);
}

void updateBankAccountDialog(BuildContext context, BankAccount account) {
  var textTheme = Theme.of(context).textTheme;
  var bankCodeController = TextEditingController();
  var bankNameController = TextEditingController();
  var accountNumberController = TextEditingController();
  var beneficiaryNameController = TextEditingController();
  var clientIdController = TextEditingController();
  var walletPhoneNumberController = TextEditingController();
  bankCodeController.text = account.bankcode ?? "";
  bankNameController.text = account.bankname ?? "";
  accountNumberController.text = account.accountnumber ?? "";
  beneficiaryNameController.text = account.beneficiaryname ?? "";
  clientIdController.text = account.clientId ?? "";
  walletPhoneNumberController.text = account.accountnumber ?? "";
  var countryPhoneCode = account.phoneCode;
  var formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        appLocalizations(context).updateBankAccount,
        style: textTheme.displayLarge,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              account.accountRole == "BANK"
                  ? Column(
                      children: [
                        CustomTextField(
                          controller: bankCodeController,
                          labelText:
                              "${appLocalizations(context).institutionCode} *",
                          hintText:
                              appLocalizations(context).enterInstitutionCode,
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
                          readOnly: true,
                          labelText:
                              "${appLocalizations(context).accountHolderName} *",
                          hintText:
                              appLocalizations(context).enterAccountHolderName,
                          validator: (String? p1) {
                            if (p1!.isEmpty) {
                              return appLocalizations(context)
                                  .pleaseEnterAccountHolderName;
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
                          labelText: "${appLocalizations(context).clientId} *",
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
                        CustomTextField(
                          controller: beneficiaryNameController,
                          readOnly: true,
                          labelText:
                              "${appLocalizations(context).accountHolderName} *",
                          hintText:
                              appLocalizations(context).enterAccountHolderName,
                          validator: (String? p1) {
                            if (p1!.isEmpty) {
                              return appLocalizations(context)
                                  .pleaseEnterAccountHolderName;
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
                          hintText:
                              appLocalizations(context).enterWalletPhoneNumber,
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
                    ),
              Row(
                children: [
                  Expanded(
                    child: CustomBtn(
                      text: appLocalizations(context).submit,
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          bankAccountListBloc.add(UpdateBankAccountEvent(
                              accountRole: account.accountRole,
                              accountId: account.id,
                              bankcode: bankCodeController.text,
                              bankname: bankNameController.text,
                              accountnumber: accountNumberController.text,
                              beneficiaryname: beneficiaryNameController.text,
                              clientId: clientIdController.text,
                              walletPhonenumber:
                                  walletPhoneNumberController.text,
                              phoneCode: countryPhoneCode));
                        }
                        Navigator.pop(context);
                      },
                    ),
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
      ),
    ),
  );
}

void isValidated(String p0) {
  // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //   enableSubmitBtnBloc.add(SelectBoolEvent(formKey.currentState!.validate()));
  // });
}
