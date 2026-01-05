import 'package:bctpay/globals/index.dart';

class KYCProofOfIdentity extends StatefulWidget {
  final XFile? selfieImage;
  final KYCData? kycData;
  final bool fromDetail;

  const KYCProofOfIdentity(
      {super.key, this.selfieImage, this.kycData, this.fromDetail = false});

  @override
  State<KYCProofOfIdentity> createState() => _KYCProofOfIdentityState();
}

class _KYCProofOfIdentityState extends State<KYCProofOfIdentity> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var dobController = TextEditingController();
  List<KYCDocData> kycDocTypes = [];
  KYCData? kycData;
  String? selectedPhoneCode;
  List<IdentityProof> identityProofList = [];
  var kycDocsListBloc = ApisBloc(ApisBlocInitialState());
  var canSubmitBloc = SelectionBloc(SelectBoolState(false));
  var selectDOBBloc = SelectionBloc(SelectionBlocInitialState());
  var selectPhoneCodeBloc = SelectionBloc(SelectionBlocInitialState());
  var addIdentityProofBloc = SelectionBloc(SelectionBlocInitialState());

  StreamSubscription<ApisBlocState>? streamSubs;

  String identityTypeForIdentity = "IDENTITY";

  bool canUpdate = false;

  DateTime? selectedDOB;

  @override
  void initState() {
    kycDocsListBloc.add(GetKYCDocsListEvent());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var args =
          ModalRoute.of(context)!.settings.arguments as KYCProofOfIdentity?;
      kycData = args?.kycData;
      updateData();
    });
    streamSubs = kycBloc.stream.listen((state) {
      if (state is KYCSubmitState) {
        var code = state.value.code;
        if (code == 200) {
          if (!mounted) return;
          showSuccessDialog(
            state.value.message,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context,
            onOkBtnPressed: () {
              Navigator.popUntil(context,
                  (route) => route.settings.name == AppRoutes.bottombar);
            },
          );
        } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
          if (!mounted) return;
          sessionExpired(state.value.message, context);
        } else {
          if (!mounted) return;
          showFailedDialog(state.value.message, context);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as KYCProofOfIdentity;
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations(context).identityVerification,
        actions: [
          if ((kycData?.kycStatus ?? KYCStatus.pending) != KYCStatus.pending)
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.kycHistory);
                },
                icon: const Icon(Icons.history))
        ],
      ),
      bottomNavigationBar: Container(
        height: kycData != null ? 85 : 55,
        margin: EdgeInsets.fromLTRB(
            5, 5, 5, MediaQuery.of(context).viewInsets.bottom + 5),
        child: Column(
          children: [
            if (kycData != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${appLocalizations(context).kycStatus} : "),
                  KYCStatusView(
                      kycStatus: kycData?.kycStatus ?? KYCStatus.pending)
                ],
              ),
            if (kycData != null)
              const SizedBox(
                height: 5,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBtn(
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: appLocalizations(context).prev,
                  width: width * 0.4,
                ),
                BlocConsumer(
                    bloc: canSubmitBloc,
                    listener: (context, state) {
                      if (state is SelectBoolState) {
                        canUpdate = (kycData?.identityProof?.isEmpty ?? true)
                            ? true
                            : canUploadKYC(
                                mainKYCStatus: kycData?.kycStatus,
                                canUpload: kycData!.identityProof!
                                        .map((e) => e.canUpload == "true")
                                        .toList()
                                        .contains(true)
                                    ? "true"
                                    : "false",
                                docStatus: kycData!.identityProof!
                                        .map((e) =>
                                            e.status == KYCStatus.suspended)
                                        .toList()
                                        .contains(true)
                                    ? KYCStatus.suspended
                                    : kycData!.identityProof!
                                            .map((e) =>
                                                e.status == KYCStatus.rejected)
                                            .toList()
                                            .contains(true)
                                        ? KYCStatus.rejected
                                        : kycData!.identityProof!.map((e) => e.status == KYCStatus.expired).toList().contains(
                                                true)
                                            ? KYCStatus.expired
                                            : kycData!.identityProof!
                                                    .map((e) =>
                                                        e.status ==
                                                        KYCStatus.underReview)
                                                    .toList()
                                                    .contains(true)
                                                ? KYCStatus.underReview
                                                : kycData!.identityProof!
                                                        .map((e) =>
                                                            e.status ==
                                                            KYCStatus.updated)
                                                        .toList()
                                                        .contains(true)
                                                    ? KYCStatus.updated
                                                    : kycData!.identityProof!
                                                            .map((e) => e.status == KYCStatus.uploaded)
                                                            .toList()
                                                            .contains(true)
                                                        ? KYCStatus.uploaded
                                                        : kycData!.identityProof!.map((e) => (e.status ?? KYCStatus.pending) == KYCStatus.pending).toList().contains(true)
                                                            ? KYCStatus.pending
                                                            : kycData!.identityProof!.map((e) => e.status == KYCStatus.approved).toList().contains(true)
                                                                ? KYCStatus.approved
                                                                : KYCStatus.approved,
                              );
                      }
                    },
                    builder: (context, state) {
                      if (state is SelectBoolState) {
                        return CustomBtn(
                          onTap:
                              (state.value || kycData != null) ? submit : null,
                          text: arg.fromDetail
                              ? appLocalizations(context).update
                              : appLocalizations(context).next,
                          width: width * 0.4,
                        );
                      }
                      return CustomBtn(
                        text: arg.fromDetail
                            ? appLocalizations(context).update
                            : appLocalizations(context).next,
                        width: width * 0.4,
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
      body: BlocConsumer(
          bloc: kycBloc,
          listener: (context, state) {
            if (state is GetKYCDetailState) {
              var code = state.value.code;
              if (code == 200) {
                kycData = state.value.data;
                updateData();
              } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }
            if (state is DeleteKYCIdDocState) {
              var code = state.value.code;
              if (code == 200) {
                showSuccessDialog(
                    state.value.message ?? state.value.error ?? "", context);
              } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
              kycBloc.add(GetKYCDetailEvent());
            }
          },
          builder: (context, kycState) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: kycState is ApisBlocLoadingState,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Text(appLocalizations(context).idVerificationDesc),
                  const SizedBox(
                    height: 20,
                  ),
                  TitleWidget(
                      title:
                          appLocalizations(context).uploadFollowingDocuments),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer(
                      bloc: kycDocsListBloc,
                      listener: (context, state) {
                        if (state is GetKYCDocsListState &&
                            state.value.data != null) {
                          if (state.value.code == 200) {
                            kycDocTypes = getKYCDocTypesCountryAndIdentityWise(
                                kycDocsList: state.value.data,
                                identityTypeForIdentity:
                                    identityTypeForIdentity);
                            isDetailsChanged();
                          } else if (state.value.code ==
                              HTTPResponseStatusCodes.sessionExpireCode) {
                            sessionExpired(state.value.message, context);
                          } else {
                            showToast(state.value.message);
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is GetKYCDocsListState &&
                            state.value.data != null) {
                          kycDocTypes = getKYCDocTypesCountryAndIdentityWise(
                              kycDocsList: state.value.data,
                              identityTypeForIdentity: identityTypeForIdentity);
                          return BlocConsumer(
                              bloc: addIdentityProofBloc,
                              listener: (context, state) {
                                if (state is SelectIdProofState) {
                                  var matchedDocType = identityProofList
                                      .where((element) =>
                                          element.docType ==
                                          state.value.docType)
                                      .toList();
                                  if (matchedDocType.isNotEmpty) {
                                    identityProofList
                                        .remove(matchedDocType.first);
                                    if ((state.value.localFiles?.isNotEmpty ??
                                            false) ||
                                        (state.value.docIdNumber?.isNotEmpty ??
                                            false)) {
                                      identityProofList.add(state.value);
                                    }
                                  } else {
                                    if ((state.value.localFiles?.isNotEmpty ??
                                            false) ||
                                        (state.value.docIdNumber?.isNotEmpty ??
                                            false)) {
                                      identityProofList.add(state.value);
                                    }
                                  }
                                  isDetailsChanged();
                                }
                                if (state is RemoveIdProofState) {
                                  identityProofList.remove(state.value);
                                  isDetailsChanged();
                                }
                              },
                              builder: (context, state) {
                                return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 200 / 240,
                                    ),
                                    itemCount: kycDocTypes.length,
                                    itemBuilder: (context, index) =>
                                        ChildGridView(
                                          kycDocType: kycDocTypes[index],
                                          kycData: kycData,
                                          identityProof:
                                              matchIdProof(kycDocTypes[index]),
                                          addIdentityProofBloc:
                                              addIdentityProofBloc,
                                        ));
                              });
                        }
                        return const Loader();
                      }),
                  CustomTextField(
                    readOnly: !canUpdate,
                    controller: nameController,
                    labelText:
                        "${appLocalizations(context).fullName} (${appLocalizations(context).asPerDocument}) *",
                    hintText: appLocalizations(context).enterYourFullName,
                    onChanged: (p0) {
                      isDetailsChanged();
                    },
                  ),
                  CustomTextField(
                    readOnly: true,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: "${appLocalizations(context).emailAddress} *",
                    hintText: appLocalizations(context).enterEmailAddress,
                    prefix: Image.asset(
                      Assets.assetsImagesEmail,
                      scale: textFieldSuffixScale,
                    ),
                    onChanged: (p0) {
                      isDetailsChanged();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return appLocalizations(context)
                            .pleaseEnterYourEmailAddress;
                      } else if (!validateEmail(value)) {
                        return appLocalizations(context)
                            .pleaseEnterYourValidEmailAddress;
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    readOnly: true,
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    labelText: "${appLocalizations(context).mobileNumber} *",
                    hintText: AppLocalizations.of(context)!.enterMobileNumber,
                    onChanged: (phone) async {
                      var country = await seperatePhoneAndDialCode(phone,
                          selectPhoneCountryBloc: selectPhoneCodeBloc);
                      if (country != null) {
                        selectPhoneCodeBloc.add(SelectCountryEvent(
                            Country.parse(country.countryCode), country));
                      }
                      isDetailsChanged();
                    },
                    prefixWidget: CountryPickerTxtFieldPrefix(
                      selectPhoneCountryBloc: selectPhoneCodeBloc,
                      readOnly: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return appLocalizations(context)
                            .pleaseEnterYourMobileNumber;
                      }
                      if (selectedPhoneCode == "+224" &&
                          !gnPhoneRegx.hasMatch(value)) {
                        return appLocalizations(context)
                            .pleaseEnterValidMobileNumber;
                      } else if (!validatePhone(value)) {
                        return appLocalizations(context)
                            .pleaseEnterValidMobileNumber;
                      }
                      return null;
                    },
                  ),
                  BlocConsumer(
                      bloc: selectDOBBloc,
                      listener: (context, state) {
                        if (state is SelectDateState) {
                          selectedDOB = state.value;
                          dobController.text = state.value.formattedDate();
                          isDetailsChanged();
                        }
                      },
                      builder: (context, state) {
                        if (state is SelectDateState) {
                          return CustomTextField(
                            controller: dobController,
                            readOnly: true,
                            onTap: canUpdate
                                ? () {
                                    showDatePicker(
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      context: context,
                                      firstDate: DateTime.now().subtract(
                                          const Duration(days: 365 * 200)),
                                      lastDate: DateTime.now(),
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        selectDOBBloc
                                            .add(SelectDateEvent(selectedDate));
                                      }
                                    });
                                  }
                                : null,
                            labelText:
                                "${appLocalizations(context).dob} (${appLocalizations(context).asPerDocument}) *",
                            hintText: appLocalizations(context).enterDOB,
                            onChanged: (p0) {
                              isDetailsChanged();
                            },
                          );
                        }
                        return CustomTextField(
                          controller: dobController,
                          readOnly: true,
                          onTap: canUpdate
                              ? () {
                                  showDatePicker(
                                    initialEntryMode:
                                        DatePickerEntryMode.calendarOnly,
                                    context: context,
                                    firstDate: DateTime.now().subtract(
                                        const Duration(days: 365 * 200)),
                                    lastDate: DateTime.now(),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      selectDOBBloc
                                          .add(SelectDateEvent(selectedDate));
                                    }
                                  });
                                }
                              : null,
                          labelText:
                              "${appLocalizations(context).dob} (${appLocalizations(context).asPerDocument}) *",
                          hintText: appLocalizations(context).enterDOB,
                          onChanged: (p0) {
                            isDetailsChanged();
                          },
                        );
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void submit() {
    var args = ModalRoute.of(context)!.settings.arguments as KYCProofOfIdentity;
    if (args.fromDetail) {
      kycBloc.add(KYCUpdateIdProofEvent(
          oldKYCData: kycData,
          userName: nameController.text,
          dob: dobController.text,
          identityProofList: identityProofList,
          addressProofList: null,
          phoneCode: selectedPhoneCode,
          phoneNumber: phoneController.text,
          email: emailController.text,
          pinCode: null,
          city: null,
          state: null,
          address: null));
    } else {
      Navigator.pushNamed(context, AppRoutes.kycProofOfAddress,
          arguments: KYCProofOfAddress(
            kycData: kycData,
            userName: nameController.text,
            dob: selectedDOB.toString().split('.').first,
            identityProofList: identityProofList,
            selfieImage: args.selfieImage,
            phoneCode: selectedPhoneCode,
            phoneNumber: phoneController.text,
            email: emailController.text,
          ));
    }
  }

  void updateData() {
    if (kycData != null) {
      ///add old kyc data
      identityProofList = (kycData?.identityProof ?? [])
          .map((e) => e.copyWith(
              localFiles: e.files
                  ?.map((e) =>
                      XFile(e.fileName ?? "", mimeType: "http", name: e.id))
                  .toList()))
          .toList();
      nameController.text = kycData?.userName ?? "";
      emailController.text = kycData?.email ?? "";
      phoneController.text = kycData?.phoneNumber ?? "";
      selectedPhoneCode = kycData?.phoneCode ?? "";
      selectPhoneCodeBloc.add(SelectCountryEvent(
          Country.parse(selectedCountry?.countryName ?? "GN"),
          selectedCountry!));
      dobController.text = kycData?.userDob?.formattedDate() ?? "";
    } else {
      ///add profile data
      getProfileDetailFromLocalBloc.stream.listen((state) {
        if (state is SharedPrefGetUserDetailState) {
          var user = state.user;
          selectedPhoneCode = user.phoneCode;
          selectPhoneCodeBloc.add(SelectCountryEvent(
              Country.parse(selectedCountry?.countryName ?? "GN"),
              selectedCountry!));
          nameController.text = user.userName;
          phoneController.text = user.phone;
          emailController.text = user.email;
        }
      });
      selectPhoneCodeBloc.stream.listen((state) {
        if (state is SelectCountryState) {
          selectedPhoneCode = "+${state.countryData.phoneCode}";
        }
      });
      getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
    }
    isDetailsChanged();
    setState(() {});
  }

  void isDetailsChanged() {
    ///check isUpdated or not
    var isTrue = nameController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        (selectedPhoneCode?.isNotEmpty ?? false) &&
        phoneController.text.isNotEmpty &&
        identityProofList.isNotEmpty;

    /// check mandatory docs for identity proof
    var mandatoryKYCDocs =
        kycDocTypes.where((element) => element.isMandatory).toList();
    var listOfIsMandatory = mandatoryKYCDocs
        .map((mandatoryDoc) => identityProofList
            .where((element) => element.docType == mandatoryDoc.docNameForEn)
            .isNotEmpty)
        .toList();
    bool isRequirementNotFullFilled = listOfIsMandatory.contains(false);
    canSubmitBloc.add(SelectBoolEvent(isTrue && !isRequirementNotFullFilled));
  }

  IdentityProof? matchIdProof(KYCDocData kycDocType) {
    var filteredIdentityProofList = identityProofList
        .where((element) => element.docType == kycDocType.docNameForEn)
        .toList();
    if (filteredIdentityProofList.isNotEmpty) {
      return filteredIdentityProofList.first;
    } else {
      return null;
    }
  }
}
