import 'package:bctpay/globals/index.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  var verifyQRCodeBloc = ApisBloc(ApisBlocInitialState());
  final checkBeneficiaryAccountStatusBloc = ApisBloc(ApisBlocInitialState());
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  KYCStatus? kycStatus;

  final toggleFlashBloc = SelectionBloc(SelectBoolState(false));

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    kycBloc.add(GetKYCDetailEvent());
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: appLocalizations(context).scanQR,
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer(
            bloc: kycBloc,
            listener: (context, kycState) {
              if (kycState is GetKYCDetailState) {
                if (kycState.value.code == 200) {
                  kycStatus =
                      kycState.value.data?.kycStatus ?? KYCStatus.pending;
                }
              }
            },
            builder: (context, kycState) {
              return BlocConsumer(
                  bloc: checkBeneficiaryAccountStatusBloc,
                  listener: (context, state) {
                    if (state is CheckBeneficiaryAccountStatusState) {
                      if (state.value.code ==
                          HTTPResponseStatusCodes
                              .momoAccountStatusSuccessCode) {
                        if (state.value.data?.status == "ACTIVE") {
                          if (state.invoiceData != null) {
                            ///handle invoice transaction
                            Navigator.pushNamed(
                                context, AppRoutes.invoiceDetail,
                                arguments: InvoiceDetail(
                                  invoiceData: InvoiceData(
                                      invoiceDetails: state.invoiceData),
                                  isScanToPay: true,
                                ));
                          } else {
                            ///handle profile QR transaction
                            Navigator.pushNamed(
                                context, AppRoutes.transactiondetail,
                                arguments: TransactionDetailScreen(
                                  toAccount: state.beneficiary,
                                  receiverType: state.userType,
                                  isScanToPay:
                                      state.invoiceData != null ? true : true,
                                  isInvoicePay: state.invoiceData != null,
                                  invoiceData: state.invoiceData,
                                ));
                          }
                        } else {
                          showFailedDialog(state.value.message, context);
                        }
                      } else {
                        showFailedDialog(state.value.message, context);
                      }
                    }
                    if (state is ApisBlocErrorState) {
                      showFailedDialog(state.message, context);
                    }
                  },
                  builder: (context, beneficiaryAccountStatusState) {
                    return BlocConsumer(
                        bloc: verifyQRCodeBloc,
                        listener: (context, state) {
                          if (state is VerifyQRState) {
                            if (state.value.code == 200 &&
                                state.value.data != null) {
                              _handleSuccessullyVerified(state.value.data);
                            } else if (state.value.code ==
                                HTTPResponseStatusCodes.sessionExpireCode) {
                              sessionExpired(state.value.message, context);
                            } else {
                              showFailedDialog(state.value.message, context,
                                  dismissOnBackKeyPress: false,
                                  dismissOnTouchOutside: false, onTap: () {
                                controller!.resumeCamera();
                                Navigator.pop(context);
                              });
                            }
                          }
                          if (state is VerifyTxnQRState) {
                            if (state.value.code == 200 &&
                                state.value.data != null) {
                              var json = state.value.data;
                              Navigator.pushNamed(
                                  context, AppRoutes.transactionHistoryDetail,
                                  arguments: TransactionHistoryDetail(
                                    isFromVerify: true,
                                    transaction: TransactionData(
                                        details: Transaction.fromJson(json)),
                                  ));
                            } else if (state.value.code ==
                                HTTPResponseStatusCodes.sessionExpireCode) {
                              sessionExpired(
                                  state.value.message ??
                                      state.value.error ??
                                      "",
                                  context);
                            } else {
                              showFailedDialog(
                                  state.value.message ??
                                      state.value.error ??
                                      "",
                                  context,
                                  dismissOnBackKeyPress: false,
                                  dismissOnTouchOutside: false, onTap: () {
                                controller!.resumeCamera();
                                Navigator.pop(context);
                              });
                            }
                          }
                        },
                        builder: (context, state) {
                          return ModalProgressHUD(
                            progressIndicator: const Loader(),
                            inAsyncCall: state is ApisBlocLoadingState,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: QRView(
                                    key: qrKey,
                                    onQRViewCreated: _onQRViewCreated,
                                    overlay: QrScannerOverlayShape(
                                        overlayColor:
                                            themeLogoColorBlue.withAlpha(200)),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    children: [
                                      Text(
                                        appLocalizations(context)
                                            .alignQRCodeWithinFrameToScan,
                                        textAlign: TextAlign.center,
                                        style: textTheme.titleMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: CustomBtn(
                                              text: appLocalizations(context)
                                                  .scan,
                                              onTap: () {
                                                controller!.resumeCamera();
                                              },
                                            )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: CustomBtn(
                                              text: appLocalizations(context)
                                                  .importQRCode,
                                              onTap: () {
                                                ImagePickerController
                                                        .pickImageFromGallery(
                                                            enableImageCrop:
                                                                false)
                                                    .then((image) {
                                                  if (image != null) {
                                                    return QrCodeToolsPlugin
                                                            .decodeFrom(
                                                                image.path)
                                                        .then((res) {
                                                      controller!.pauseCamera();
                                                      if (res != null) {
                                                        checkSelfQROrNot(res);
                                                      }
                                                    });
                                                  } else {}
                                                });
                                              },
                                            )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () async {
                                        controller?.toggleFlash();
                                        final isFlashOn =
                                            await controller?.getFlashStatus();
                                        toggleFlashBloc.add(SelectBoolEvent(
                                            isFlashOn ?? false));
                                      },
                                      icon: BlocBuilder(
                                          bloc: toggleFlashBloc,
                                          builder: (context, state) {
                                            return Icon(
                                              (state as SelectBoolState).value
                                                  ? Icons.flash_on
                                                  : Icons.flash_off,
                                              color: state.value
                                                  ? themeLogoColorOrange
                                                  : Colors.white,
                                            );
                                          })),
                                )
                              ],
                            ),
                          );
                        });
                  });
            }),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      controller.pauseCamera();
      if (scanData.code != null) {
        checkSelfQROrNot(scanData.code!);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _handleSuccessullyVerified(VerifyQRData? data) {
    var beneficiary = data?.receiverAccount;

    ///check if invoiceQR then navigate to invoice detail
    if (kycStatus != KYCStatus.approved) {
      controller!.pauseCamera();
      showFailedDialog(
          appLocalizations(context).kycNotApprovedDialogMessage, context,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false, onTap: () {
        Navigator.popUntil(
            context, (route) => route.settings.name == AppRoutes.bottombar);
      });
    } else if (data?.invoiceDetails != null) {
      Navigator.pushNamed(context, AppRoutes.invoiceDetail,
          arguments: InvoiceDetail(
            invoiceData: InvoiceData(invoiceDetails: data?.invoiceDetails),
            isScanToPay: true,
          ));
    } else if (data?.subscriber != null) {
      Navigator.pushNamed(context, AppRoutes.subscriptionDetail,
          arguments: SubscriptionDetail(
            subscriber: data?.subscriber,
            isScanToPay: true,
          ));
    } else if (data?.paymentLinkData != null) {
      Navigator.pushNamed(context, AppRoutes.paymentLinkScreen,
          arguments: PaymentLinkScreen(
            paymentLinkData: data?.paymentLinkData,
          ));
    } else if (beneficiary != null) {
      showCustomDialog(
        beneficiary.beneficiaryname ??
            beneficiary.accountnumber ??
            appLocalizations(context).unknown,
        context,
        btnOkText: appLocalizations(context).pay,
        btnNoText: appLocalizations(context).rescan,
        customHeader: data?.profilePic == null
            ? null
            : ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: CachedNetworkImage(
                  imageUrl: "$baseUrlProfileImage${data?.profilePic}",
                  progressIndicatorBuilder: progressIndicatorBuilder,
                  errorWidget: (context, url, error) => const Icon(Icons.image),
                ),
              ),
        body: BeneficiaryListItem(
          beneficiary: beneficiary,
          showPoupMenuBtn: false,
        ),
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        onYesTap: () {
          {
            SharedPreferenceHelper.getUserId().then((myCustomerId) {
              if (beneficiary.customerId == myCustomerId) {
                if (!mounted) return;
                Navigator.pop(context);
                showFailedDialog(
                    appLocalizations(context)
                        .youCanNotTransferAmountToYourselfSelectOtherAccountToProceed,
                    context);
              } else {
                if (!mounted) return;
                if (data?.invoiceDetails?.paymentStatus == "PAID") {
                  Navigator.pop(context);
                  showInvoiceAlreadyPaidDialog(data?.invoiceDetails);
                } else {
                  checkBeneficiaryAccountStatusBloc.add(
                      CheckBeneficiaryAccountStatusEvent(
                          beneficiary: beneficiary,
                          receiverType: "QR_SCAN",
                          userType: data?.receiverType,
                          invoiceData: data?.invoiceDetails));
                  Navigator.pop(context);
                }
              }
            });
          }
        },
        onNoTap: () {
          controller!.resumeCamera();
          Navigator.pop(context);
        },
      );
    }
  }

  void checkSelfQROrNot(String qrUrlString) {
    var qrUrl = Uri.parse(qrUrlString);
    var id = qrUrl.queryParameters["id"]?.replaceAll(" ", "+");
    var type = qrUrl.queryParameters["type"];
    log("$qrUrlString\n\ntype:$type, id:$id");
    SharedPreferenceHelper.getQRString().then((qr) {
      if (qrUrlString == qr) {
        if (!mounted) return;
        showFailedDialog(
            appLocalizations(context)
                .youCanNotTransferAmountToYourselfSelectOtherAccountToProceed,
            context);
      } else {
        if (type == "1228") {
          verifyQRCodeBloc.add(VerifyTxnQREvent(
            qrCode: (id?.isNotEmpty ?? false) ? id! : qrUrlString,
            type: type ?? "",
          ));
        } else {
          verifyQRCodeBloc.add(VerifyQREvent(
            qrCode: (id?.isNotEmpty ?? false) ? id! : qrUrlString,
            type: type ?? "",
          ));
        }
      }
    });
  }

  void showInvoiceAlreadyPaidDialog(Invoice? invoiceDetails) {
    showCustomDialog(
      appLocalizations(context).invoiceAlreadyPaid,
      context,
      btnNoText: appLocalizations(context).cancel,
      btnOkText: appLocalizations(context).invoiceDetail,
      onYesTap: () {
        Navigator.pushNamed(context, AppRoutes.invoiceDetail,
            arguments: InvoiceDetail(
              invoiceData: InvoiceData(invoiceDetails: invoiceDetails),
              isScanToPay: true,
            ));
      },
    );
  }
}
