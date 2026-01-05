import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class ContactsList extends StatefulWidget {
  final String searchText;
  final bool isRequestToPay;
  final bool isMobileRecharge;
  final KYCStatus kycStatus;
  final ScrollPhysics? physics;
  final bool showContactWhenNotExist;
  final SelectionBloc? selectPhoneCountryBloc;

  const ContactsList(
    this.searchText, {
    super.key,
    this.isRequestToPay = false,
    required this.kycStatus,
    this.isMobileRecharge = false,
    this.physics,
    this.showContactWhenNotExist = false,
    this.selectPhoneCountryBloc,
  });

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final checkBeneficiaryAccountStatusBloc = ApisBloc(ApisBlocInitialState());
  final permissionBloc = PermissionBloc(PermissionBlocInitialState());
  var loadingBloc = SelectionBloc(SelectBoolState(false));

  var phoneController = TextEditingController();

  Contact? newContact;

  var verifyContactBloc = ApisBloc(ApisBlocInitialState());
  var selectPhoneCountryBloc = SelectionBloc(SelectCountryState(
      Country.parse(selectedCountry?.countryName ?? "GN"), selectedCountry!));

  CountryData? selectedPhoneCountry = selectedCountry;

  Future<List<Contact>>? getContactFuture;

  @override
  void initState() {
    super.initState();
    permissionBloc.add(PermissionRequestEvent(permission: Permission.contacts));
    (widget.selectPhoneCountryBloc ?? selectPhoneCountryBloc)
        .stream
        .listen((state) {
      if (state is SelectCountryState) {
        selectedPhoneCountry = state.countryData;
      }
    });
    checkBeneficiaryAccountStatusBloc.stream.listen((state) {
      if (state is CheckBeneficiaryAccountStatusState) {
        if (state.value.code ==
            HTTPResponseStatusCodes.momoAccountStatusSuccessCode) {
          if (state.value.data?.status == "ACTIVE") {
            if (mounted) {
              Navigator.pushNamed(context, AppRoutes.transactiondetail,
                  arguments: TransactionDetailScreen(
                    toAccount: state.beneficiary,
                    isContactPay: true,
                    receiverType: state.userType,
                  ));
            }
          } else {
            if (mounted) {
              showFailedDialog(state.value.message, context);
            }
          }
        } else {
          if (mounted) {
            showFailedDialog(state.value.message, context);
          }
        }
      }
      if (state is ApisBlocErrorState) {
        if (!mounted) return;
        showFailedDialog(state.message, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: verifyContactBloc,
        listener: (context, state) {
          if (state is VerifyContactState) {
            if (state.value.code == 200) {
              var beneficiary = state.value.data;
              if (beneficiary != null) {
                SharedPreferenceHelper.getUserId().then((myCustomerId) {
                  if (beneficiary.bankInfo?.customerId == myCustomerId) {
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
                    requestToContact: newContact,
                  ));
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
        builder: (context, verifyContactState) {
          return BlocBuilder(
              bloc: loadingBloc,
              builder: (context, loadingBlocState) {
                if (loadingBlocState is SelectBoolState) {
                  return ModalProgressHUD(
                    progressIndicator: const Loader(),
                    inAsyncCall: verifyContactState is ApisBlocLoadingState ||
                        loadingBlocState.value,
                    child: BlocConsumer(
                        bloc: permissionBloc,
                        listener: (context, state) {
                          if (state is PermissionRequestState) {
                            if (state.value == PermissionStatus.granted) {
                              getContactFuture =
                                  FastContacts.getAllContacts(fields: [
                                ContactField.displayName,
                                ContactField.familyName,
                                ContactField.givenName,
                                ContactField.middleName,
                                ContactField.namePrefix,
                                ContactField.nameSuffix,
                                ContactField.phoneNumbers,
                                ContactField.phoneLabels,
                              ]);
                            }
                          }
                        },
                        builder: (context, permissionState) {
                          if (permissionState is PermissionRequestState) {
                            var status = permissionState.value;
                            if (status != PermissionStatus.granted) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${appLocalizations(context).contactPermission} ${status.name}"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    (status ==
                                            PermissionStatus.permanentlyDenied)
                                        ? ElevatedButton(
                                            onPressed: () {
                                              openAppSettings();
                                            },
                                            child: Text(
                                                appLocalizations(context)
                                                    .openAppSetting))
                                        : ElevatedButton(
                                            onPressed: () {
                                              permissionBloc.add(
                                                  PermissionRequestEvent(
                                                      permission:
                                                          Permission.contacts));
                                            },
                                            child: Text(
                                                appLocalizations(context)
                                                    .requestPermission)),
                                  ],
                                ),
                              );
                            }

                            return FutureBuilder(
                                future: getContactFuture,
                                builder: (context,
                                    AsyncSnapshot<List<Contact>> snapshot) {
                                  if (snapshot.hasData) {
                                    var contacts = snapshot.data
                                            ?.where((e) =>
                                                e.displayName
                                                    .toLowerCase()
                                                    .contains(widget.searchText
                                                        .toLowerCase()) ||
                                                (e.phones.isEmpty
                                                        ? ""
                                                        : e.phones.first.number
                                                            .replaceAll(
                                                                specialCharAndSpaceRegex,
                                                                ""))
                                                    .toLowerCase()
                                                    .contains(widget.searchText
                                                        .toLowerCase()))
                                            .toList() ??
                                        [];
                                    if (contacts.isEmpty) {
                                      if (widget.showContactWhenNotExist &&
                                          widget.searchText.isNotEmpty) {
                                        return BlocBuilder(
                                            bloc:
                                                widget.selectPhoneCountryBloc ??
                                                    selectPhoneCountryBloc,
                                            builder: (context, state) {
                                              if (state is SelectCountryState) {
                                                var contact = Contact(
                                                    id: "0",
                                                    phones: [
                                                      Phone(
                                                        number:
                                                            "+${selectedPhoneCountry!.phoneCode} ${widget.searchText}",
                                                        label: "Unknown",
                                                      )
                                                    ],
                                                    emails: const [],
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
                                                return SizedBox(
                                                  height: 80,
                                                  child: ContactListItem(
                                                    contact: contact,
                                                    onTap: () {
                                                      onContactTap(contact);
                                                    },
                                                  ),
                                                );
                                              }
                                              return const Loader();
                                            });
                                      }
                                      return Center(
                                        child: Text(
                                          appLocalizations(context).noContacts,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }
                                    return AnimationLimiter(
                                      child: Scrollbar(
                                        thickness: 10,
                                        interactive: true,
                                        radius: const Radius.circular(10),
                                        child: ListView.builder(
                                          physics: widget.physics,
                                          shrinkWrap: true,
                                          itemCount: contacts.length,
                                          itemBuilder: (context, index) =>
                                              ListAnimation(
                                            index: index,
                                            child: ContactListItem(
                                                onTap: () {
                                                  onContactTap(contacts[index]);
                                                },
                                                contact: contacts[index]),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const Loader();
                                });
                          }
                          return const Loader();
                        }),
                  );
                }
                return const Loader();
              });
        });
  }

  void onContactTap(Contact contact) {
    loadingBloc.add(SelectBoolEvent(true));
    if (widget.kycStatus != KYCStatus.approved) {
      loadingBloc.add(SelectBoolEvent(false));
      showFailedDialog(
          appLocalizations(context).kycNotApprovedDialogMessage, context);
    } else if (contact.phones.isNotEmpty) {
      ///show confirm contact dialog
      var phone = contact.phones.first.number;
      phone = phone.replaceAll(specialCharAndSpaceRegex, "");
      seperatePhoneAndDialCode("+$phone",
              changeCountry: true,
              selectPhoneCountryBloc:
                  widget.selectPhoneCountryBloc ?? selectPhoneCountryBloc)
          .then((country) {
        phoneController.text = phone.substring(country?.phoneCode != null
            ? ((country?.phoneCode?.length ?? 0))
            : 0);
        if (country != null) {
          selectedPhoneCountry = country;
        }
        loadingBloc.add(SelectBoolEvent(false));
        if (!mounted) return;
        showCustomDialog(
          "",
          context,
          btnOkText: appLocalizations(context).ok,
          btnNoText: appLocalizations(context).cancel,
          body: Column(
            children: [
              Text(appLocalizations(context).confirmContactDialogDesc),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      labelText: appLocalizations(context).mobileNumber,
                      hintText: AppLocalizations.of(context)!.enterMobileNumber,
                      prefixWidget: CountryPickerTxtFieldPrefix(
                        readOnly: false,
                        selectPhoneCountryBloc: widget.selectPhoneCountryBloc ??
                            selectPhoneCountryBloc,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return appLocalizations(context)
                              .pleaseEnterYourMobileNumber;
                        }
                        if (selectedPhoneCountry!.phoneCode == "224" &&
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
                  ),
                ],
              ),
            ],
          ),
          onYesTap: () {
            if (validatePhone(phoneController.text)) {
              if (selectedPhoneCountry != null) {
                Navigator.pop(context);
                newContact = Contact(
                    id: contact.id,
                    phones: [
                      Phone(
                          number:
                              "+${selectedPhoneCountry!.phoneCode}${phoneController.text}",
                          label: "")
                    ],
                    emails: contact.emails,
                    structuredName: contact.structuredName,
                    organization: contact.organization);
                if (widget.isRequestToPay) {
                  verifyContactBloc.add(CheckContactExistEvent(
                      receiverPhoneCode: "+${selectedPhoneCountry!.phoneCode}",
                      receiverPhoneNumber: phoneController.text));
                } else if (widget.isMobileRecharge) {
                  Navigator.pushNamed(context, AppRoutes.mobilerechargeform,
                      arguments: MobileRechargeForm(
                        contact: newContact,
                      ));
                } else {
                  verifyContactBloc.add(VerifyContactEvent(
                      receiverPhoneCode: "+${selectedPhoneCountry!.phoneCode}",
                      receiverPhoneNumber: phoneController.text));
                }
              } else {
                showToast(
                    appLocalizations(context).pleaseSelectCountryPhoneCode);
              }
            } else {
              showToast(appLocalizations(context).pleaseEnterValidMobileNumber);
            }
          },
        );
      });
    } else {
      loadingBloc.add(SelectBoolEvent(false));
      showToast(appLocalizations(context).mobileNumberDoesntExist);
    }
  }
}
