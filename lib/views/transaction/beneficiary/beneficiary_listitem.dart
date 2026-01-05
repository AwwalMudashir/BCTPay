import 'package:bctpay/globals/index.dart';

class BeneficiaryListItem extends StatelessWidget {
  final BankAccount beneficiary;
  final void Function()? onTap;

  final bool showPoupMenuBtn;

  const BeneficiaryListItem(
      {super.key,
      required this.beneficiary,
      this.onTap,
      this.showPoupMenuBtn = true});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      onLongPressStart: (p0) {
        position = p0.globalPosition;
      },
      child: Card(
        color: tileColor,
        elevation: 5,
        margin: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: beneficiary.id,
                child: SizedBox.square(
                  dimension: 80,
                  child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                              imageUrl: "$baseUrlBankLogo${beneficiary.logo}",
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      beneficiary.beneficiaryname ??
                          appLocalizations(context).unknown,
                      style: textTheme.titleSmall?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          selectedCountry!.countryCode,
                          style: textTheme.headlineSmall
                              ?.copyWith(color: Colors.black),
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
                          beneficiary.accountRole == "BANK"
                              ? (beneficiary.accountnumber ?? "")
                                  .showLast4HideAll()
                              : ("${beneficiary.phoneCode ?? ""} ${(beneficiary.accountnumber ?? "").showLast4HideAll()}"),
                          style: textTheme.headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (showPoupMenuBtn) _popupMenuBtn(context)
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton _popupMenuBtn(BuildContext context) => PopupMenuButton(
      color: isDarkMode(context) ? themeLogoColorBlue : Colors.white,
      icon: const Icon(Icons.more_vert),
      iconColor: Colors.black,
      itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(appLocalizations(context).delete),
              onTap: () {
                showCustomDialog(
                  appLocalizations(context).doYouReallyWantToDeleteThisAccount,
                  context,
                  title: appLocalizations(context).warning,
                  dialogType: DialogType.warning,
                  onYesTap: () {
                    beneficiaryListBloc.add(
                        DeleteBeneficiaryEvent(beneficiaryId: beneficiary.id));
                    Navigator.pop(context);
                  },
                );
              },
            ),
            PopupMenuItem(
              child: Text(appLocalizations(context).viewAccount),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.beneficiaryDetail,
                    arguments: BeneficiaryDetail(
                      account: beneficiary,
                    ));
              },
            ),
            PopupMenuItem(
              child: Text(appLocalizations(context).update),
              onTap: () {
                updateBeneficiaryDialog(context, beneficiary);
              },
            ),
          ]);
}

void updateBeneficiaryDialog(BuildContext context, BankAccount account) {
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
        appLocalizations(context).updateBeneficiary,
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
                          labelText:
                              "${appLocalizations(context).beneficiaryName} *",
                          hintText:
                              appLocalizations(context).enterBeneficiaryName,
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
                          labelText:
                              "${appLocalizations(context).beneficiaryName} *",
                          hintText:
                              appLocalizations(context).enterBeneficiaryName,
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
                          beneficiaryListBloc.add(UpdateBeneficiaryEvent(
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
                          Navigator.pop(context);
                        }
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
