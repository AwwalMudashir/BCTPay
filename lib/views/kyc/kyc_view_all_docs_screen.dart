import 'package:bctpay/globals/index.dart';

class KYCViewAllDocsScreen extends StatefulWidget {
  final IdentityProof? identityProof;
  final KYCDocData? kycDoc;
  final KYCData? kycData;

  final SelectionBloc? addIdentityProofBloc;

  const KYCViewAllDocsScreen(
      {super.key,
      this.kycDoc,
      this.kycData,
      this.identityProof,
      this.addIdentityProofBloc});

  @override
  State<KYCViewAllDocsScreen> createState() => _KYCViewAllDocsScreenState();
}

class _KYCViewAllDocsScreenState extends State<KYCViewAllDocsScreen> {
  var docIdController = TextEditingController();

  var validityController = TextEditingController();
  var canSubmitBloc = SelectionBloc(SelectBoolState(false));
  var selectDateRangeBloc = SelectionBloc(SelectionBlocInitialState());
  DateTimeRange? selectedValidity;

  KYCData? kycData;
  var selectDOBBloc = SelectionBloc(SelectionBlocInitialState());
  List<XFile?> selectedDocsList = [];
  var selectMediaBloc = SelectionBloc(SelectionBlocInitialState());

  IdentityProof? identityProof;

  KYCDocData? kycDoc;

  List<FileElement> serverImages = [];

  String identityTypeForIdentity = "ADDRESSIDENTITY";

  void autoFillData() {
    var args =
        ModalRoute.of(context)!.settings.arguments as KYCViewAllDocsScreen;
    kycDoc = args.kycDoc;
    kycData = args.kycData;
    identityProof = args.identityProof;
    serverImages = identityProof?.files ?? [];
    if (serverImages.isNotEmpty) {
      ///add server files
      for (var e in serverImages) {
        selectedDocsList
            .add(XFile(e.fileName ?? "", mimeType: "http", name: e.id));
      }
    } else {
      ///add local files
      selectedDocsList = identityProof?.localFiles ?? [];
    }
    docIdController.text = identityProof?.docIdNumber ?? "";
    selectedValidity = identityProof?.validFrom == null
        ? null
        : DateTimeRange(
            start: identityProof!.validFrom!, end: identityProof!.validTill!);
    validityController.text = selectedValidity == null
        ? ""
        : "${selectedValidity?.start.formattedDate()} - ${selectedValidity?.end.formattedDate()}";
    setState(() {});
    isDetailsChanged();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      autoFillData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as KYCViewAllDocsScreen;
    bool canUpload = canUploadKYC(
        mainKYCStatus: kycData?.kycStatus,
        canUpload: identityProof?.canUpload,
        docStatus: identityProof?.status);
    return Scaffold(
      appBar: CustomAppBar(
        title: selectedLanguage == "fr"
            ? (args.kycDoc?.docNameForGn ?? "")
            : (args.kycDoc?.docNameForEn ?? ""),
        actions: [
          if ((kycData?.kycStatus ?? KYCStatus.pending) != KYCStatus.pending)
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.kycHistory);
              },
              icon: const Icon(Icons.history),
            )
        ],
      ),
      bottomNavigationBar: Container(
        height: 55,
        margin: EdgeInsets.fromLTRB(
            5, 5, 5, MediaQuery.of(context).viewInsets.bottom + 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBtn(
                  color: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: appLocalizations(context).cancel,
                  width: width * 0.4,
                ),
                BlocBuilder(
                    bloc: canSubmitBloc,
                    builder: (context, state) {
                      if (state is SelectBoolState) {
                        return CustomBtn(
                          onTap: state.value ? submit : null,
                          text: appLocalizations(context).save,
                          width: width * 0.4,
                        );
                      }
                      return CustomBtn(
                        text: appLocalizations(context).save,
                        width: width * 0.4,
                      );
                    }),
              ],
            )
          ],
        ),
      ),
      body: BlocConsumer(
          bloc: kycBloc,
          listener: (context, state) {
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
                  if (kycData?.addProof?.isNotEmpty ?? false)
                    Row(
                      children: [
                        Text("${appLocalizations(context).status} : "),
                        KYCStatusView(
                            kycStatus:
                                identityProof?.status ?? KYCStatus.pending),
                      ],
                    ),

                  /// check the comment show main status comment here and show item comment ablove
                  if (identityProof?.viewComment == "true" &&
                      (identityProof?.comment?.isNotEmpty ?? false))
                    Row(
                      children: [
                        Text("${appLocalizations(context).comment} : "),
                        Text(identityProof?.comment ?? "")
                      ],
                    ),
                  BlocConsumer(
                      bloc: selectMediaBloc,
                      listener: (context, state) {
                        if (state is SelectMultipleMediaState) {
                          if ((state.files.length + selectedDocsList.length) <=
                              (kycDoc?.numberOfFiles ?? 0)) {
                            selectedDocsList.addAll(state.files);
                          } else {
                            showFailedDialog(
                                appLocalizations(context)
                                    .youCantAddMoreThanDocs(
                                        kycDoc?.numberOfFiles ?? 0),
                                context);
                          }
                        }
                        if (state is SelectImageState) {
                          selectedDocsList.remove(state.image);
                        }
                        isDetailsChanged();
                      },
                      builder: (context, state) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.8),
                          itemCount: ((selectedDocsList.length <
                                      (kycDoc?.numberOfFiles ?? 0)) &&
                                  canUploadKYC(
                                      canUpload: identityProof?.canUpload,
                                      docStatus: identityProof?.status,
                                      mainKYCStatus: kycData?.kycStatus))
                              ? selectedDocsList.length + 1
                              : selectedDocsList.length,
                          itemBuilder: (context, i) => selectedDocsList
                                      .length ==
                                  i
                              ? ImagePickerView(
                                  onTap: () {
                                    ImagePickerController.pickMultipleMedia(
                                            enableImageCrop: false)
                                        .then((value) {
                                      selectMediaBloc
                                          .add(SelectMultipleMediaEvent(value));
                                    });
                                  },
                                  iconSize: 70,
                                )
                              : Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    KYCFileView(
                                      file: selectedDocsList[i]!,
                                      extension:
                                          identityProof?.files?.isNotEmpty ??
                                                  false
                                              ? (identityProof?.files?[i]
                                                      .fileExtension ??
                                                  "")
                                              : "",
                                    ),
                                    if (canUploadKYC(
                                        mainKYCStatus: kycData?.kycStatus,
                                        canUpload: identityProof?.canUpload,
                                        docStatus: identityProof?.status))
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            if (selectedDocsList[i]?.mimeType ==
                                                "http") {
                                              if (kycDoc?.identityType
                                                      ?.toLowerCase() ==
                                                  identityTypeForIdentity
                                                      .toLowerCase()) {
                                                kycBloc.add(
                                                    DeleteKYCAddressDocEvent(
                                                        identityProof:
                                                            identityProof!
                                                                .copyWith(
                                                                    files: [
                                                              serverImages[i]
                                                            ]),
                                                        kycData: kycData));
                                              } else {
                                                kycBloc.add(DeleteKYCIdDocEvent(
                                                    identityProof:
                                                        identityProof!.copyWith(
                                                            files: [
                                                          serverImages[i]
                                                        ]),
                                                    kycData: kycData));
                                              }
                                              selectMediaBloc.add(
                                                  SelectImageEvent(
                                                      selectedDocsList[i]));
                                            } else {
                                              selectMediaBloc.add(
                                                  SelectImageEvent(
                                                      selectedDocsList[i]));
                                            }
                                          },
                                          child: const Card(
                                            elevation: 5,
                                            child: Icon(
                                              Icons.clear,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    readOnly: !canUpload,
                    controller: docIdController,
                    labelText: "${appLocalizations(context).docIdNumber} *",
                    hintText: appLocalizations(context).enterDocId,
                    onChanged: (p0) {
                      isDetailsChanged();
                    },
                  ),
                  BlocConsumer(
                      bloc: selectDateRangeBloc,
                      listener: (context, state) {
                        if (state is SelectDateRangeState) {
                          if ((state.value?.end.isToday() ?? false) ||
                              (state.value?.end.isAfter(DateTime.now()) ??
                                  false)) {
                            selectedValidity = state.value;
                            validityController.text = selectedValidity == null
                                ? ""
                                : "${selectedValidity?.start.formattedDate()} - ${selectedValidity?.end.formattedDate()}";
                            isDetailsChanged();
                          } else {
                            showFailedDialog(
                                appLocalizations(context).pleaseSelectValidDate,
                                context);
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is SelectDateRangeState) {
                          return CustomTextField(
                            controller: validityController,
                            readOnly: true,
                            onTap: canUpload
                                ? () {
                                    docValidityPicker();
                                  }
                                : null,
                            labelText:
                                "${appLocalizations(context).selectValidity} (${appLocalizations(context).asPerDocument})",
                            hintText: appLocalizations(context).selectValidity,
                            suffix: IconButton(
                              onPressed: () {
                                selectDateRangeBloc
                                    .add(SelectDateRangeEvent(null));
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                            ),
                            onChanged: (p0) {
                              isDetailsChanged();
                            },
                          );
                        }
                        return CustomTextField(
                          controller: validityController,
                          readOnly: true,
                          onTap: canUpload
                              ? () {
                                  docValidityPicker();
                                }
                              : null,
                          labelText:
                              "${appLocalizations(context).selectValidity} (${appLocalizations(context).asPerDocument})",
                          hintText: appLocalizations(context).selectValidity,
                          onChanged: (p0) {
                            isDetailsChanged();
                          },
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void submit() {
    var args =
        ModalRoute.of(context)!.settings.arguments as KYCViewAllDocsScreen;
    var idProof = (args.identityProof ?? IdentityProof()).copyWith(
      localFiles: selectedDocsList,
      docIdNumber: docIdController.text,
      validFrom: selectedValidity?.start,
      validTill: selectedValidity?.end,
      docType: args.kycDoc?.docNameForEn ?? "",
    );
    Navigator.pop(context, idProof);

    args.addIdentityProofBloc?.add(SelectIdProofEvent(idProof));
  }

  bool isDetailsChanged() {
    bool isTrue = (docIdController.text.isNotEmpty &&
        selectedValidity != null &&
        selectedDocsList.isNotEmpty &&
        canUploadKYC(
            mainKYCStatus: kycData?.kycStatus,
            canUpload: identityProof?.canUpload,
            docStatus: identityProof?.status));

    /// can_upload parameter should be true if you want to upload
    canSubmitBloc.add(SelectBoolEvent(isTrue));
    return isTrue;
  }

  void docValidityPicker() {
    showDatePicker(
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            helpText: appLocalizations(context).validFrom,
            context: context,
            initialDate: selectedValidity?.start,
            firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
            lastDate: DateTime.now().add(const Duration(days: 365 * 100)))
        .then((selectedStartDate) {
      if (selectedStartDate != null) {
        if (!mounted) return;
        showDatePicker(
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                helpText: appLocalizations(context).validTill,
                context: context,
                initialDate: selectedValidity?.end,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 100)))
            .then((selectedEndDate) {
          if (selectedEndDate != null) {
            selectDateRangeBloc.add(SelectDateRangeEvent(
                DateTimeRange(start: selectedStartDate, end: selectedEndDate)));
          } else {
            if (!mounted) return;
            showToast(appLocalizations(context).pleaseSelectValidDate);
          }
        });
      }
    });
  }
}
