import 'package:bctpay/lib.dart';

class ChildGridView extends StatefulWidget {
  final IdentityProof? identityProof;
  final KYCDocData kycDocType;
  final SelectionBloc addIdentityProofBloc;
  final KYCData? kycData;

  const ChildGridView(
      {super.key,
      required this.kycDocType,
      required this.kycData,
      required this.identityProof,
      required this.addIdentityProofBloc});

  @override
  State<ChildGridView> createState() => _ChildGridViewState();
}

class _ChildGridViewState extends State<ChildGridView> {
  var selectImagesBloc = SelectionBloc(SelectionBlocInitialState());
  IdentityProof? identityProof;

  final _key = GlobalKey();

  var identityTypeForIdentity = "ADDRESSIDENTITY";

  @override
  void initState() {
    super.initState();
    identityProof = widget.identityProof;
  }

  @override
  void didUpdateWidget(covariant ChildGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.identityProof != oldWidget.identityProof) {
      identityProof = widget.identityProof;
    }
  }

  @override
  Widget build(BuildContext context) {
    var kycDocType = widget.kycDocType;
    return Stack(
      children: [
        BlocConsumer(
            bloc: selectImagesBloc,
            listener: (context, state) {
              if (state is SelectMultipleMediaState) {
                setState(() {
                  identityProof =
                      (identityProof ?? widget.identityProof)
                          ?.copyWith(localFiles: state.files);
                });
              }
            },
            builder: (context, state) {
              if (identityProof != null &&
                  (identityProof?.localFiles?.isNotEmpty ?? false)) {
                return InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, AppRoutes.kycViewAllDocsScreen,
                        arguments: KYCViewAllDocsScreen(
                          kycDoc: widget.kycDocType,
                          kycData: widget.kycData,
                          identityProof: identityProof,
                          addIdentityProofBloc: widget.addIdentityProofBloc,
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration:
                        shadowDecoration.copyWith(color: Colors.black38),
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2),
                            scrollDirection: Axis.horizontal,
                            itemCount: identityProof?.localFiles?.length,
                            itemBuilder: (context, index) => KYCFileView(
                              file: identityProof?.localFiles?[index],
                              disableOntap:
                                  identityProof?.localFiles?.isNotEmpty ?? false
                                      ? true
                                      : false,
                              extension:
                                  identityProof?.files?.isNotEmpty ?? false
                                      ? (identityProof
                                              ?.files?[index].fileExtension ??
                                          "")
                                      : "",
                            ),
                          ),
                        ),
                        Wrap(
                          children: [
                            Text(
                              selectedLanguage == 'en'
                                  ? kycDocType.docNameForEn
                                  : kycDocType.docNameForGn,
                              style: textTheme(context)
                                  .titleMedium
                                  ?.copyWith(color: themeLogoColorOrange),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              return ImagePickerView(
                  isSelected: identityProof != null,
                  bgImageUrl:
                      baseUrlDocFiles + (widget.kycDocType.docImageIcon ?? ""),
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, AppRoutes.kycViewAllDocsScreen,
                        arguments: KYCViewAllDocsScreen(
                          kycDoc: widget.kycDocType,
                          kycData: widget.kycData,
                          identityProof: identityProof,
                          addIdentityProofBloc: widget.addIdentityProofBloc,
                        ));
                  },
                  iconSize: 70,
                  btnText:
                      "${selectedLanguage == "fr" ? widget.kycDocType.docNameForGn : widget.kycDocType.docNameForEn} ${widget.kycDocType.isMandatory ? "*" : ""}");
            }),
        if (identityProof != null &&
            canUploadKYC(
              canUpload: identityProof?.canUpload,
              docStatus: identityProof?.status,
              mainKYCStatus: widget.kycData?.kycStatus,
            ))
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                if (identityProof?.localFiles
                        ?.map((e) => e?.mimeType == "http")
                        .toList()
                        .contains(true) ??
                    false) {
                  if (widget.kycDocType.identityType?.toLowerCase() ==
                      identityTypeForIdentity.toLowerCase()) {
                    kycBloc.add(DeleteKYCAddressDocEvent(
                        identityProof: identityProof!,
                        kycData: widget.kycData,
                        isFile: false));
                  } else {
                    kycBloc.add(DeleteKYCIdDocEvent(
                        identityProof: identityProof!,
                        kycData: widget.kycData,
                        isFile: false));
                  }
                } else {
                  widget.addIdentityProofBloc
                      .add(RemoveIdProofEvent(identityProof!));
                }
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.red,
              ),
            ),
          ),
        if (widget.kycData != null &&
            identityProof != null &&
            ((identityProof?.status ?? KYCStatus.pending) != KYCStatus.pending))
          Positioned(
            top: 13,
            left: 13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KYCStatusView(
                    kycStatus: identityProof?.status ?? KYCStatus.pending),
                if (identityProof?.viewComment == "true" &&
                    (identityProof?.comment?.isNotEmpty ?? false))
                  InkWell(
                    onTap: () {
                      final dynamic tooltip = _key.currentState;
                      tooltip.ensureTooltipVisible();
                    },
                    child: Tooltip(
                        key: _key,
                        message: identityProof?.comment ?? "",
                        child: const Icon(
                          Icons.info_outline,
                          size: 20,
                        )),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
