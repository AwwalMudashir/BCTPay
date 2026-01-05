import 'package:bctpay/globals/index.dart';
import 'package:camera/camera.dart' as cam;
import 'package:camera/camera.dart';

class KYCTakeASelfie extends StatefulWidget {
  const KYCTakeASelfie({super.key});

  @override
  State<KYCTakeASelfie> createState() => _KYCTakeASelfieState();
}

class _KYCTakeASelfieState extends State<KYCTakeASelfie> {
  late List<CameraDescription> _cameras;
  CameraController? cameraController;

  AppLifecycleListener? _listener;

  var canSubmitBloc = SelectionBloc(SelectBoolState(false));

  XFile? capturedSelfie;

  KYCData? kycData;

  void initializeCameraController() async {
    _cameras = await availableCameras();
    var camera = _cameras
        .where(
            (element) => element.lensDirection == cam.CameraLensDirection.front)
        .toList();
    if (camera.isNotEmpty) {
      cameraController =
          CameraController(camera.first, ResolutionPreset.medium);
      cameraController?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is cam.CameraException) {
          showToast("Camera Error: ${e.description}");
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    } else {
      log("Selfie Camera not available only $_cameras");
    }
  }

  Future<void> cameraConfig() async {
    await handlePermission();
    initializeCameraController();
    _listener = AppLifecycleListener(onInactive: () {
      cameraController?.dispose();
    }, onResume: () {
      initializeCameraController();
    }, onStateChange: (state) {
      if (cameraController == null ||
          !(cameraController?.value.isInitialized ?? true)) {
        return;
      }
    });
  }

  final permissionBloc = PermissionBloc(PermissionBlocInitialState());

  Future<void> handlePermission() async {
    Permission cameraPermission = Permission.camera;
    permissionBloc.add(PermissionRequestEvent(permission: cameraPermission));
  }

  @override
  void initState() {
    super.initState();
    kycBloc.add(GetKYCDetailEvent(showPreview: true));
    cameraConfig();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    _listener?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations(context).takeASelfie,
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
        height: kycData != null ? 80 : 55,
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
                  color: const Color.fromRGBO(244, 67, 54, 1),
                  onTap: () {
                    cameraController?.takePicture().then((value) {
                      showPreview(file: value);
                    });
                  },
                  text: appLocalizations(context).capture,
                  width: width * 0.4,
                ),
                BlocBuilder(
                    bloc: canSubmitBloc,
                    builder: (context, state) {
                      if (state is SelectBoolState) {
                        return CustomBtn(
                          onTap: state.value ? submit : null,
                          text: appLocalizations(context).next,
                          width: width * 0.4,
                        );
                      }
                      return CustomBtn(
                        text: appLocalizations(context).next,
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
              kycData = state.value.data;
              var serverSelfies = kycData?.photoProof?.fileName;
              if (serverSelfies?.isNotEmpty ?? false) {
                capturedSelfie = XFile(serverSelfies ?? "",
                    mimeType: "http", name: serverSelfies ?? "");
              }
              if (kycData != null && state.showPreview) {
                showPreview(file: capturedSelfie, url: serverSelfies ?? "");
              }
            }
            if (state is KYCSubmitState) {
              if (state.value.code == 200) {
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
          },
          builder: (context, state) {
            if (state is GetKYCDetailState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    appLocalizations(context).selfieVerification,
                    textAlign: TextAlign.center,
                    style: textTheme(context)
                        .headlineMedium
                        ?.copyWith(color: themeLogoColorOrange),
                  ),
                  Text(
                    appLocalizations(context).selfieVerificationDesc,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                        height: 300,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: (!(cameraController?.value.isInitialized ??
                                        false) &&
                                    cameraController == null)
                                ? Center(
                                    child: TextButton(
                                      onPressed: () {
                                        ImagePickerController
                                                .pickImageFromGallery()
                                            .then((image) {
                                          showPreview(
                                            file: image,
                                          );
                                        });
                                      },
                                      child: Text(
                                          "Camera not available or something went wrong",
                                          textAlign: TextAlign.center,
                                          style: textTheme(context)
                                              .bodyMedium
                                              ?.copyWith(color: Colors.grey)),
                                    ),
                                  )
                                : CameraPreview(
                                    cameraController!,
                                    child: CustomPaint(
                                      painter: CustomPainter1(),
                                    ),
                                  ))),
                  ),
                  Text(
                    appLocalizations(context).selfieVerificationTnC,
                    style: textTheme(context).bodyMedium?.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }
            return const Loader();
          }),
    );
  }

  void submit() {
    Navigator.pushNamed(context, AppRoutes.kycProofOfIdentity,
        arguments: KYCProofOfIdentity(
          selfieImage: capturedSelfie,
          kycData: kycData,
        ));
  }

  void showPreview({XFile? file, String? url}) {
    Navigator.pushNamed(context, AppRoutes.kycSelfiePreview,
        arguments: KYCSelfiePreview(
          file: file,
          kycData: kycData,
        ));
  }
}

class CustomPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = themeLogoColorOrange //Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width * 0.3;

    final rect =
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius);
    final roundedRect =
        RRect.fromRectAndRadius(rect, const Radius.circular(12.0));
    canvas.drawRRect(roundedRect, paint);

    path.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }
}
