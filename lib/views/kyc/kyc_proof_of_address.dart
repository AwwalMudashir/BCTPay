import 'package:bctpay/globals/index.dart';

class KYCProofOfAddress extends StatefulWidget {
  final KYCData? kycData;
  final String? userName;
  final String? dob;
  final List<IdentityProof>? identityProofList;
  final XFile? selfieImage;
  final String? phoneCode;
  final String? phoneNumber;
  final String? email;
  final bool fromDetail;

  const KYCProofOfAddress(
      {super.key,
      this.kycData,
      this.userName,
      this.dob,
      this.identityProofList,
      this.selfieImage,
      this.phoneCode,
      this.phoneNumber,
      this.email,
      this.fromDetail = false});

  @override
  State<KYCProofOfAddress> createState() => _KYCProofOfAddressState();
}

class _KYCProofOfAddressState extends State<KYCProofOfAddress> {
  var canSubmitBloc = SelectionBloc(SelectBoolState(false));
  var selectMediaBloc = SelectionBloc(SelectionBlocInitialState());
  var selectStateBloc = SelectionBloc(SelectionBlocInitialState());
  var selectCityBloc = SelectionBloc(SelectionBlocInitialState());
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var pincodeController = TextEditingController();
  var line1Controller = TextEditingController();
  var line2Controller = TextEditingController();
  var landmarkController = TextEditingController();
  List<IdentityProof> addressProofList = [];

  KYCData? kycData;

  var kycDocsListBloc = ApisBloc(ApisBlocInitialState());
  List<KYCDocData> kycDocTypes = [];
  String identityTypeForIdentity = "ADDRESSIDENTITY";

  StateData? selectedState;

  bool canUpdate = false;

  @override
  void initState() {
    super.initState();
    kycDocsListBloc.add(GetKYCDocsListEvent());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var args =
          ModalRoute.of(context)!.settings.arguments as KYCProofOfAddress;
      kycData = args.kycData;
      updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations(context).addressVerification,
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
                BlocBuilder(
                    bloc: canSubmitBloc,
                    builder: (context, state) {
                      if (state is SelectBoolState) {
                        return CustomBtn(
                          onTap: state.value ? submit : null,
                          text: kycData != null
                              ? appLocalizations(context).update
                              : appLocalizations(context).submit,
                          width: width * 0.4,
                        );
                      }
                      return CustomBtn(
                        text: kycData != null
                            ? appLocalizations(context).update
                            : appLocalizations(context).submit,
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
            if (state is KYCSubmitState) {
              if (state.value.code == 200) {
                profileBloc.add(GetProfileEvent());
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
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(state.value.message, context);
              } else {
                showFailedDialog(state.value.message, context);
              }
              kycBloc.add(GetKYCDetailEvent());
            }
            if (state is DeleteKYCAddressDocState) {
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
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: state is ApisBlocLoadingState,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Text(appLocalizations(context).addressVerificationDesc),
                  const SizedBox(
                    height: 20,
                  ),
                  TitleWidget(
                      title:
                          appLocalizations(context).uploadYourAddressDocument),
                  if (kycData?.addProof?.isNotEmpty ?? false)
                    const SizedBox(
                      height: 10,
                    ),
                  BlocConsumer(
                    bloc: selectMediaBloc,
                    listener: (context, state) {
                      if (state is SelectIdProofState) {
                        var matchedDocType = addressProofList
                            .where((element) =>
                                element.docType == state.value.docType)
                            .toList();
                        if (matchedDocType.isNotEmpty) {
                          addressProofList.remove(matchedDocType.first);
                          if ((state.value.localFiles?.isNotEmpty ?? false) ||
                              (state.value.docIdNumber?.isNotEmpty ?? false)) {
                            addressProofList.add(state.value);
                          }
                        } else {
                          if ((state.value.localFiles?.isNotEmpty ?? false) ||
                              (state.value.docIdNumber?.isNotEmpty ?? false)) {
                            addressProofList.add(state.value);
                          }
                        }
                        isDetailsChanged();
                      }
                      if (state is RemoveIdProofState) {
                        addressProofList.remove(state.value);
                        isDetailsChanged();
                      }
                    },
                    builder: (context, selectMediaState) {
                      return BlocConsumer(
                          bloc: kycDocsListBloc,
                          listener: (context, state) {
                            if (state is GetKYCDocsListState &&
                                state.value.data != null) {
                              if (state.value.code == 200) {
                                kycDocTypes =
                                    getKYCDocTypesCountryAndIdentityWise(
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
                              kycDocTypes =
                                  getKYCDocTypesCountryAndIdentityWise(
                                      kycDocsList: state.value.data,
                                      identityTypeForIdentity:
                                          identityTypeForIdentity);
                              return BlocConsumer(
                                  bloc: selectMediaBloc,
                                  listener: (context, state) {
                                    if (state is SelectIdProofState) {
                                      var matchedDocType = addressProofList
                                          .where((element) =>
                                              element.docType ==
                                              state.value.docType)
                                          .toList();
                                      if (matchedDocType.isNotEmpty) {
                                        addressProofList
                                            .remove(matchedDocType.first);
                                        if ((state.value.localFiles
                                                    ?.isNotEmpty ??
                                                false) ||
                                            (state.value.docIdNumber
                                                    ?.isNotEmpty ??
                                                false)) {
                                          addressProofList.add(state.value);
                                        }
                                      } else {
                                        if ((state.value.localFiles
                                                    ?.isNotEmpty ??
                                                false) ||
                                            (state.value.docIdNumber
                                                    ?.isNotEmpty ??
                                                false)) {
                                          addressProofList.add(state.value);
                                        }
                                      }
                                      isDetailsChanged();
                                    }
                                    if (state is RemoveIdProofState) {
                                      addressProofList.remove(state.value);
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
                                              identityProof: matchIdProof(
                                                  kycDocTypes[index]),
                                              addIdentityProofBloc:
                                                  selectMediaBloc,
                                            ));
                                  });
                            }
                            return const Loader();
                          });
                    },
                  ),
                  10.height,
                  BlocConsumer(
                      bloc: selectStateBloc,
                      listener: (context, state) {
                        if (state is SelectStateState) {
                          selectedState = state.state;
                          stateController.text = selectedState?.state ?? "";

                          ///setting initial city while selecting state
                          if (selectedState?.cities?.isNotEmpty ?? false) {
                            selectCityBloc.add(SelectStringEvent(
                                selectedState?.cities?.first));
                          }
                          isDetailsChanged();
                        }
                      },
                      builder: (context, state) {
                        return CustomTextField(
                          onTap: canUpdate
                              ? () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: isDarkMode(context)
                                        ? themeLogoColorBlue
                                        : Colors.white,
                                    builder: (context) => StatePickerView(
                                      bloc: selectStateBloc,
                                    ),
                                  );
                                }
                              : null,
                          readOnly: true,
                          controller: stateController,
                          labelText: "${appLocalizations(context).state} *",
                          hintText: appLocalizations(context).selectState,
                          prefix: Image.asset(
                            Assets.assetsImagesCountry1,
                            scale: textFieldSuffixScale,
                          ),
                          onChanged: (p0) {
                            isDetailsChanged();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return appLocalizations(context)
                                  .pleaseSelectYourState;
                            } else if (!specialCharRegex.hasMatch(value)) {
                              return appLocalizations(context)
                                  .pleaseEnterValidValue;
                            }
                            return null;
                          },
                        );
                      }),
                  Row(
                    children: [
                      Expanded(
                        child: BlocConsumer(
                            bloc: selectCityBloc,
                            listener: (context, state) {
                              if (state is SelectStringState) {
                                cityController.text = state.value ?? "";
                                isDetailsChanged();
                              }
                            },
                            builder: (context, state) {
                              return CustomTextField(
                                onTap: canUpdate
                                    ? () {
                                        showModalBottomSheet(
                                          backgroundColor: isDarkMode(context)
                                              ? themeLogoColorBlue
                                              : Colors.white,
                                          context: context,
                                          builder: (context) => CityPickerView(
                                            bloc: selectCityBloc,
                                            selectedState: selectedState,
                                          ),
                                        );
                                      }
                                    : null,
                                readOnly: true,
                                controller: cityController,
                                labelText:
                                    "${appLocalizations(context).city} *",
                                hintText: appLocalizations(context).enterCity,
                                prefix: Image.asset(
                                  Assets.assetsImagesCity1,
                                  scale: textFieldSuffixScale,
                                ),
                                onChanged: (p0) {
                                  isDetailsChanged();
                                },
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return appLocalizations(context)
                                        .pleaseEnterYourCity;
                                  } else if (!specialCharRegex.hasMatch(p0)) {
                                    return appLocalizations(context)
                                        .pleaseEnterValidValue;
                                  }
                                  return null;
                                },
                              );
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          readOnly: !canUpdate,
                          controller: pincodeController,
                          keyboardType: TextInputType.number,
                          labelText: appLocalizations(context).pinCode,
                          hintText: appLocalizations(context).enterPinCode,
                          prefix: Image.asset(
                            Assets.assetsImagesPincode1,
                            scale: textFieldSuffixScale,
                          ),
                          onChanged: (p0) {
                            isDetailsChanged();
                          },
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    readOnly: !canUpdate,
                    controller: line1Controller,
                    labelText: appLocalizations(context).line1,
                    hintText: appLocalizations(context).enterLine1,
                    prefix: Image.asset(
                      Assets.assetsImagesLocation1,
                      scale: textFieldSuffixScale,
                    ),
                    onChanged: (p0) {
                      isDetailsChanged();
                    },
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return appLocalizations(context).pleaseEnterLine1;
                      } else if (!specialCharRegex.hasMatch(p0)) {
                        return appLocalizations(context).pleaseEnterValidValue;
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    readOnly: !canUpdate,
                    controller: line2Controller,
                    labelText: appLocalizations(context).line2,
                    hintText: appLocalizations(context).enterLine2,
                    prefix: Image.asset(
                      Assets.assetsImagesLocation1,
                      scale: textFieldSuffixScale,
                    ),
                    onChanged: (p0) {
                      isDetailsChanged();
                    },
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return appLocalizations(context).pleaseEnterLine2;
                      } else if (!specialCharRegex.hasMatch(p0)) {
                        return appLocalizations(context).pleaseEnterValidValue;
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    readOnly: !canUpdate,
                    controller: landmarkController,
                    labelText: appLocalizations(context).landmark,
                    hintText: appLocalizations(context).enterLandmark,
                    prefix: Image.asset(
                      Assets.assetsImagesLocation1,
                      scale: textFieldSuffixScale,
                    ),
                    onChanged: (p0) {
                      isDetailsChanged();
                    },
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return appLocalizations(context).pleaseEnterLandmark;
                      } else if (!specialCharRegex.hasMatch(p0)) {
                        return appLocalizations(context).pleaseEnterValidValue;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void submit() {
    var args = ModalRoute.of(context)!.settings.arguments as KYCProofOfAddress;
    if (kycData != null) {
      kycBloc.add(KYCUpdateAddressProofEvent(
        oldKYCData: kycData,
        userName: null,
        dob: null,
        identityProofList: null,
        addressProofList: addressProofList,
        phoneCode: null,
        phoneNumber: null,
        email: null,
        pinCode: pincodeController.text,
        city: cityController.text,
        state: stateController.text,
        address: getUserAddress(
            line1: line1Controller.text,
            line2: line2Controller.text,
            landmark: landmarkController.text),
        line1: line1Controller.text,
        line2: line2Controller.text,
        landmark: landmarkController.text,
      ));
    } else {
      kycBloc.add(KYCSubmitEvent(
        oldKYCData: kycData,
        userName: args.userName,
        dob: args.dob,
        identityProofList: args.identityProofList,
        addressProofList: addressProofList,
        selfieImage: args.selfieImage,
        phoneCode: args.phoneCode,
        phoneNumber: args.phoneNumber,
        email: args.email,
        pinCode: pincodeController.text,
        city: cityController.text,
        state: stateController.text,
        address: getUserAddress(
            line1: line1Controller.text,
            line2: line2Controller.text,
            landmark: landmarkController.text),
        line1: line1Controller.text,
        line2: line2Controller.text,
        landmark: landmarkController.text,
      ));
    }
  }

  String getUserAddress(
      {required String line1,
      required String line2,
      required String landmark}) {
    var add = line1.isEmpty ? "" : line1;
    if (line2.isNotEmpty) {
      add = add.isNotEmpty ? "$add $line2" : line2;
    }
    if (landmark.isNotEmpty) {
      add = add.isNotEmpty ? "$add, $landmark" : landmark;
    }
    return add;
  }

  bool isDetailsChanged() {
    var isTrue =
        cityController.text.isNotEmpty && stateController.text.isNotEmpty;

    var mandatoryKYCDocs =
        kycDocTypes.where((element) => element.isMandatory).toList();
    var listOfIsMandatory = mandatoryKYCDocs
        .map((mandatoryDoc) => addressProofList
            .where((element) => element.docType == mandatoryDoc.docNameForEn)
            .isNotEmpty)
        .toList();
    bool isRequirementNotFullFilled = listOfIsMandatory.contains(false);
    if (kycData != null) {
      canUpdate = (kycData?.addProof?.isEmpty ?? true)
          ? true
          : canUploadKYC(
              mainKYCStatus: kycData?.kycStatus,
              canUpload: kycData!.addProof!
                      .map((e) => e.canUpload == "true")
                      .toList()
                      .contains(true)
                  ? "true"
                  : "false",

              /// check the kyc status
              docStatus: kycData!.addProof!
                      .map((e) => e.status == KYCStatus.suspended)
                      .toList()
                      .contains(true)
                  ? KYCStatus.suspended
                  : kycData!.addProof!
                          .map((e) => e.status == KYCStatus.rejected)
                          .toList()
                          .contains(true)
                      ? KYCStatus.rejected
                      : kycData!.addProof!
                              .map((e) => e.status == KYCStatus.expired)
                              .toList()
                              .contains(true)
                          ? KYCStatus.expired
                          : kycData!.addProof!
                                  .map((e) => e.status == KYCStatus.underReview)
                                  .toList()
                                  .contains(true)
                              ? KYCStatus.underReview
                              : kycData!.addProof!
                                      .map((e) => e.status == KYCStatus.updated)
                                      .toList()
                                      .contains(true)
                                  ? KYCStatus.updated
                                  : kycData!.addProof!
                                          .map((e) =>
                                              e.status == KYCStatus.uploaded)
                                          .toList()
                                          .contains(true)
                                      ? KYCStatus.uploaded
                                      : kycData!.addProof!
                                              .map((e) =>
                                                  (e.status ??
                                                      KYCStatus.pending) ==
                                                  KYCStatus.pending)
                                              .toList()
                                              .contains(true)
                                          ? KYCStatus.pending
                                          : kycData!.addProof!
                                                  .map((e) => e.status == KYCStatus.approved)
                                                  .toList()
                                                  .contains(true)
                                              ? KYCStatus.approved
                                              : KYCStatus.approved,
            );
      canSubmitBloc.add(
          SelectBoolEvent(isTrue && !isRequirementNotFullFilled && canUpdate));
    } else {
      canUpdate = true;
      canSubmitBloc.add(SelectBoolEvent(isTrue && !isRequirementNotFullFilled));
    }

    return true;
  }

  void updateData() {
    if (kycData != null) {
      //add old kyc data
      cityController.text = kycData?.city ?? "";
      stateController.text = kycData?.state ?? "";
      pincodeController.text = kycData?.pinCode ?? "";
      addressProofList = (kycData?.addProof ?? [])
          .map((e) => e.copyWith(
              localFiles: e.files
                  ?.map((e) =>
                      XFile(e.fileName ?? "", mimeType: "http", name: e.id))
                  .toList()))
          .toList();
    }

    ///add profile data
    getProfileDetailFromLocalBloc.stream.listen((state) {
      if (state is SharedPrefGetUserDetailState) {
        var user = state.user;
        cityController.text = user.city ?? "";
        stateController.text = user.state ?? "";
        pincodeController.text = user.pinCode ?? "";
        line1Controller.text = user.line1 ?? "";
        line2Controller.text = user.line2 ?? "";
      }
    });
    getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
    isDetailsChanged();
    setState(() {});
  }

  IdentityProof? matchIdProof(KYCDocData kycDocType) {
    var filteredIdentityProofList = addressProofList
        .where((element) => element.docType == kycDocType.docNameForEn)
        .toList();
    if (filteredIdentityProofList.isNotEmpty) {
      return filteredIdentityProofList.first;
    } else {
      return null;
    }
  }
}
