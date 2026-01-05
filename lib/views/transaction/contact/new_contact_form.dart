import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class NewContactForm extends StatefulWidget {
  final bool isRequestToPay;
  final bool isMobileRecharge;

  const NewContactForm(
      {super.key, this.isRequestToPay = false, this.isMobileRecharge = false});

  @override
  State<NewContactForm> createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  String? countryPhoneCode;

  var phoneController = TextEditingController();

  var selectedPhoneCountryBloc = SelectionBloc(SelectionBlocInitialState());
  var verifyContactBloc = ApisBloc(ApisBlocInitialState());
  final checkBeneficiaryAccountStatusBloc = ApisBloc(ApisBlocInitialState());
  final _formKey = GlobalKey<FormState>();
  final loadingBloc = SelectionBloc(SelectionBlocInitialState());

  @override
  void initState() {
    kycBloc.add(GetKYCDetailEvent());
    getProfileDetailFromLocalBloc.stream.listen((state) {
      if (state is SharedPrefGetUserDetailState) {
        var user = state.user;
        countryPhoneCode = user.phoneCode;
        selectedPhoneCountryBloc.add(SelectCountryEvent(
            Country.parse(selectedCountry?.countryName ?? "GN"),
            selectedCountry!));
      }
    });
    selectedPhoneCountryBloc.stream.listen((state) {
      if (state is SelectCountryState) {
        countryPhoneCode = state.countryData.phoneCode;
      }
    });
    getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
    checkBeneficiaryAccountStatusBloc.stream.listen((state) {
      if (state is CheckBeneficiaryAccountStatusState) {
        if (state.value.code ==
            HTTPResponseStatusCodes.momoAccountStatusSuccessCode) {
          if (state.value.data?.status == "ACTIVE") {
            if (!mounted) return;
            Navigator.pushNamed(context, AppRoutes.transactiondetail,
                arguments: TransactionDetailScreen(
                  toAccount: state.beneficiary,
                  isContactPay: true,
                  receiverType: state.userType,
                ));
          } else {
            if (!mounted) return;
            showFailedDialog(state.value.message, context);
          }
        } else {
          if (!mounted) return;
          showFailedDialog(state.value.message, context);
        }
      }
      if (state is ApisBlocErrorState) {
        if (!mounted) return;
        showFailedDialog(state.message, context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: appLocalizations(context).newContact),
        body: BlocBuilder(
            bloc: kycBloc,
            builder: (context, kycState) {
              if (kycState is GetKYCDetailState) {
                var kycStatus = kycState.value.data?.kycStatus;
                return BlocConsumer(
                    bloc: verifyContactBloc,
                    listener: (context, state) {
                      if (state is VerifyContactState) {
                        if (state.value.code == 200) {
                          var beneficiary = state.value.data;
                          if (beneficiary != null) {
                            SharedPreferenceHelper.getUserId()
                                .then((myCustomerId) {
                              if (beneficiary.bankInfo?.customerId ==
                                  myCustomerId) {
                                if (!context.mounted) return;
                                Navigator.pop(context);
                                showFailedDialog(
                                    appLocalizations(context)
                                        .youCanNotTransferAmountToYourselfSelectOtherAccountToProceed,
                                    context);
                              } else {
                                checkBeneficiaryAccountStatusBloc
                                    .add(CheckBeneficiaryAccountStatusEvent(
                                  beneficiary: state.value.data!.bankInfo!,
                                  receiverType: "CONTACT",
                                  userType: state.value.data?.userType,
                                ));
                              }
                            });
                          }
                        } else if (state.value.code ==
                            HTTPResponseStatusCodes.sessionExpireCode) {
                          sessionExpired(state.value.message, context);
                        } else {
                          showFailedDialog(state.value.message, context);
                        }
                      }
                      if (state is CheckContactExistState) {
                        if (state.value.code == 200) {
                          Navigator.pushNamed(context, AppRoutes.selftransfer,
                              arguments: RouteArguments(
                                isRequestToPay: true,
                                requestToContact: Contact(
                                    id: "0",
                                    phones: [
                                      Phone(
                                          number:
                                              "${state.receiverPhoneCode}${state.receiverPhoneNumber}",
                                          label:
                                              appLocalizations(context).unknown)
                                    ],
                                    emails: [],
                                    structuredName: StructuredName(
                                        displayName: "Unknown",
                                        namePrefix: "",
                                        givenName: "",
                                        middleName: "",
                                        familyName: "",
                                        nameSuffix: ""),
                                    organization: null),
                              ));
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
                      }
                      if (state is ApisBlocErrorState) {
                        showFailedDialog(state.message, context);
                      }
                    },
                    builder: (context, verifyContactState) {
                      return ModalProgressHUD(
                        progressIndicator: const Loader(),
                        inAsyncCall:
                            verifyContactState is ApisBlocLoadingState ||
                                kycBloc is ApisBlocLoadingState,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              children: [
                                CustomTextField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  labelText:
                                      appLocalizations(context).mobileNumber,
                                  hintText: AppLocalizations.of(context)!
                                      .enterMobileNumber,
                                  prefixWidget: CountryPickerTxtFieldPrefix(
                                    readOnly: false,
                                    selectPhoneCountryBloc:
                                        selectedPhoneCountryBloc,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return appLocalizations(context)
                                          .pleaseEnterYourMobileNumber;
                                    }
                                    if (countryPhoneCode == "224" &&
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomBtn(
                                          onTap: () {
                                            if (kycStatus !=
                                                KYCStatus.approved) {
                                              loadingBloc
                                                  .add(SelectBoolEvent(false));
                                              showFailedDialog(
                                                  appLocalizations(context)
                                                      .kycNotApprovedDialogMessage,
                                                  context);
                                            } else if (validatePhone(
                                                    phoneController.text) &&
                                                _formKey.currentState!
                                                    .validate()) {
                                              if (countryPhoneCode != null) {
                                                var newContact = Contact(
                                                    id: "0",
                                                    phones: [
                                                      Phone(
                                                          number:
                                                              "+$countryPhoneCode${phoneController.text}",
                                                          label: "Unknown")
                                                    ],
                                                    emails: const <Email>[],
                                                    structuredName:
                                                        const StructuredName(
                                                            displayName:
                                                                "Unknown",
                                                            namePrefix: "",
                                                            givenName: "",
                                                            middleName: "",
                                                            familyName: "",
                                                            nameSuffix: ""),
                                                    organization: null);
                                                if (widget.isRequestToPay) {
                                                  verifyContactBloc.add(
                                                      CheckContactExistEvent(
                                                          receiverPhoneCode:
                                                              "+$countryPhoneCode",
                                                          receiverPhoneNumber:
                                                              phoneController
                                                                  .text));
                                                } else if (widget
                                                    .isMobileRecharge) {
                                                  Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .mobilerechargeform,
                                                      arguments:
                                                          MobileRechargeForm(
                                                        contact: newContact,
                                                      ));
                                                } else {
                                                  verifyContactBloc.add(
                                                      VerifyContactEvent(
                                                          receiverPhoneCode:
                                                              "+$countryPhoneCode",
                                                          receiverPhoneNumber:
                                                              phoneController
                                                                  .text));
                                                }
                                              } else {
                                                showToast(appLocalizations(
                                                        context)
                                                    .pleaseSelectCountryPhoneCode);
                                              }
                                            } else {
                                              showToast(appLocalizations(
                                                      context)
                                                  .pleaseEnterValidMobileNumber);
                                            }
                                          },
                                          text:
                                              appLocalizations(context).submit),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CustomBtn(
                                          color: Colors.red,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          text:
                                              appLocalizations(context).cancel),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return const Loader();
            }),
      ),
    );
  }
}
