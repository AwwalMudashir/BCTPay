import 'dart:io';

import 'package:bctpay/lib.dart';

class KYCSelfiePreview extends StatelessWidget {
  final KYCData? kycData;
  final XFile? file;
  final SelectionBloc? showPreviewBloc;

  const KYCSelfiePreview(
      {super.key, this.kycData, this.file, this.showPreviewBloc});

  @override
  Widget build(BuildContext context) {
    var arg = args(context) as KYCSelfiePreview;
    var kycData = arg.kycData;
    var kycStatus = kycData?.kycStatus ?? KYCStatus.pending;
    var file = arg.file;
    var url = kycData?.photoProof?.fileName;
    final key = GlobalKey();
    var canSubmitBloc = SelectionBloc(SelectBoolState(false));
    checkCanSubmitOrNot(canSubmitBloc);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        appBar: CustomAppBar(
          title: "",
          titleWidget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations(context).kycDetails,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${appLocalizations(context).kycStatus} : ",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    kycStatus.name,
                    style: TextStyle(
                        color: getKYCStatusColor(kycStatus), fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          leading: BackButton(
            onPressed: () {
              Navigator.popUntil(
                  context,
                  (route) =>
                      route.settings.name == AppRoutes.profileDetails ||
                      route.settings.name == AppRoutes.bottombar);
            },
          ),
          actions: [
            if ((kycData?.kycStatus ?? KYCStatus.pending) != KYCStatus.pending)
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.kycHistory);
                  },
                  icon: const Icon(Icons.history))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(
                appLocalizations(context).selfieVerification,
                textAlign: TextAlign.center,
                style: textTheme(context)
                    .headlineMedium
                    ?.copyWith(color: themeLogoColorOrange),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                appLocalizations(context).selfieVerificationPurpose,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: height * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: file?.mimeType == "http"
                      ? Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Positioned.fill(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.imageView,
                                      arguments: ImageView(
                                        imageUrl: "$baseUrlKYCImage$url",
                                      ));
                                },
                                child: CachedNetworkImage(
                                  imageUrl: "$baseUrlKYCImage$url",
                                  progressIndicatorBuilder:
                                      progressIndicatorBuilder,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              child: Row(
                                children: [
                                  KYCStatusView(
                                      kycStatus: kycData?.photoProof?.status ??
                                          KYCStatus.pending),
                                  if (kycData?.photoProof?.viewComment ==
                                          "true" &&
                                      (kycData?.photoProof?.comment
                                              ?.isNotEmpty ??
                                          false))
                                    InkWell(
                                      onTap: () {
                                        final dynamic tooltip =
                                            key.currentState;
                                        tooltip.ensureTooltipVisible();
                                      },
                                      child: Tooltip(
                                          key: key,
                                          message:
                                              kycData?.photoProof?.comment ??
                                                  "",
                                          child: const Icon(
                                            Icons.info_outline,
                                            size: 20,
                                          )),
                                    ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Image.file(
                          File(
                            file?.path ?? "",
                          ),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (kycData != null && file?.mimeType != "http")
                ElevatedButton.icon(
                    onPressed: canUploadKYC(
                            mainKYCStatus: kycData.kycStatus,
                            canUpload: kycData.photoProof?.canUpload,
                            docStatus: kycData.photoProof?.status)
                        ? () {
                            kycBloc.add(KYCUpdatePhotoProofEvent(
                                oldKYCData: kycData,
                                userName: null,
                                dob: null,
                                identityProofList: null,
                                addressProofList: null,
                                selfieImage: file,
                                phoneCode: null,
                                phoneNumber: null,
                                email: null,
                                pinCode: null,
                                city: null,
                                state: null,
                                address: null));
                          }
                        : null,
                    icon: const Icon(Icons.history),
                    label: Text(appLocalizations(context).update)),
              if (kycData?.photoProof?.viewComment == "true" &&
                  (kycData?.photoProof?.comment?.isNotEmpty ?? false))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${appLocalizations(context).comment} : "),
                    Text(kycData?.photoProof?.comment ?? "")
                  ],
                ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  if (canUploadKYC(
                      mainKYCStatus: kycData?.kycStatus,
                      canUpload: kycData?.photoProof?.canUpload,
                      docStatus: kycData?.photoProof?.status)) ...[
                    Expanded(
                      child: CustomBtn(
                        color: Colors.red,
                        maxWidth: double.infinity,
                        text: appLocalizations(context).recapture,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    10.width,
                  ],
                  Expanded(
                    child: BlocBuilder(
                        bloc: canSubmitBloc,
                        builder: (context, state) {
                          if (state is SelectBoolState) {
                            return CustomBtn(
                              onTap: state.value
                                  ? () {
                                      if (kycData != null) {
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes
                                                .kycIdentityVerificationDetails);
                                      } else {
                                        Navigator.pushNamed(context,
                                            AppRoutes.kycProofOfIdentity,
                                            arguments: KYCProofOfIdentity(
                                              selfieImage: file,
                                              kycData: kycData,
                                            ));
                                      }
                                    }
                                  : null,
                              text: appLocalizations(context).next,
                              width: width * 0.4,
                            );
                          }
                          return CustomBtn(
                            text: appLocalizations(context).next,
                            width: width * 0.4,
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void checkCanSubmitOrNot(SelectionBloc canSubmitBloc) {
    var canSubmit = canUploadKYC(
        mainKYCStatus: kycData?.kycStatus,
        canUpload: kycData?.photoProof?.canUpload,
        docStatus: kycData?.photoProof?.status);
    canSubmitBloc.add(SelectBoolEvent(canSubmit));
  }
}
