import 'dart:async';

import 'package:bctpay/globals/index.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class KycFaceVerification extends StatefulWidget {
  const KycFaceVerification({super.key});

  @override
  State<KycFaceVerification> createState() => _KycFaceVerificationState();
}

class _KycFaceVerificationState extends State<KycFaceVerification>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  late FaceDetector _faceDetector;
  bool _isCameraInitialized = false;
  bool _isDetecting = false;
  bool _stepCompleted = false;
  String? _error;
  List<Face> _faces = [];

  final List<_LivenessStep> _steps = [
    _LivenessStep.lookStraight,
    _LivenessStep.turnLeft,
    _LivenessStep.turnRight,
    _LivenessStep.blink,
  ];
  int _currentStepIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initDetector();
    _initCamera();
  }

  void _initDetector() {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: false,
        enableLandmarks: true,
        enableClassification: true,
        performanceMode: FaceDetectorMode.fast,
      ),
    );
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final front = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        front,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _cameraController!.initialize();

      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
        _error = null;
      });

      _startImageStream();
    } catch (e) {
      setState(() {
        _error = 'Camera initialization failed: ${e.toString()}';
      });
    }
  }

  void _startImageStream() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;

    _cameraController!.startImageStream((CameraImage image) async {
      if (_isDetecting) return;
      _isDetecting = true;

      try {
        final inputImage = _convertCameraImage(image, _cameraController!.description.sensorOrientation);
        if (inputImage == null) return;
        final faces = await _faceDetector.processImage(inputImage);
        if (!mounted) return;
        setState(() => _faces = faces);
        if (faces.isNotEmpty) {
          _evaluateLiveness(faces.first);
        }
      } catch (e) {
        // ignore frame errors
      } finally {
        _isDetecting = false;
      }
    });
  }

  InputImage? _convertCameraImage(CameraImage image, int rotation) {
    try {
      final allBytes = WriteBuffer();
      for (final plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final imageSize = Size(image.width.toDouble(), image.height.toDouble());

      final inputImageFormat = InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;

      final planeData = image.planes.map(
        (plane) => InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        ),
      ).toList();

      final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: InputImageRotationValue.fromRawValue(rotation) ?? InputImageRotation.rotation0deg,
        inputImageFormat: inputImageFormat,
        planeData: planeData,
      );

      return InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    } catch (e) {
      return null;
    }
  }

  void _evaluateLiveness(Face face) {
    final step = _steps[_currentStepIndex];
    bool passed = false;

    switch (step) {
      case _LivenessStep.lookStraight:
        final y = face.headEulerAngleY ?? 0.0;
        final z = face.headEulerAngleZ ?? 0.0;
        passed = y.abs() < 15 && z.abs() < 15;
        break;
      case _LivenessStep.turnLeft:
        final y = face.headEulerAngleY ?? 0.0;
        passed = y > 20;
        break;
      case _LivenessStep.turnRight:
        final y = face.headEulerAngleY ?? 0.0;
        passed = y < -20;
        break;
      case _LivenessStep.blink:
        final left = face.leftEyeOpenProbability ?? 1.0;
        final right = face.rightEyeOpenProbability ?? 1.0;
        passed = left < 0.4 && right < 0.4;
        break;
    }

    if (passed) {
      if (_currentStepIndex < _steps.length - 1) {
        setState(() => _currentStepIndex++);
      } else {
        setState(() => _stepCompleted = true);
        _finishLiveness();
      }
    }
  }

  void _finishLiveness() {
    // Stop camera and return success
    _cameraController?.stopImageStream();
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: Text(appLocalizations(context).kyc)),
        body: Center(child: Text(_error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations(context).kyc)),
      body: _isCameraInitialized
          ? Column(
              children: [
                AspectRatio(
                  aspectRatio: _cameraController!.value.aspectRatio,
                  child: CameraPreview(_cameraController!),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(child: _buildStepIndicator()),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildStepIndicator() {
    final labels = ['Look straight', 'Turn left', 'Turn right', 'Blink'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Follow instructions to verify your selfie', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: List.generate(labels.length, (i) {
            final active = i == _currentStepIndex || (i < _currentStepIndex);
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: active ? themeLogoColorBlue : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(labels[i], style: TextStyle(color: active ? Colors.white : Colors.black, fontSize: 12)),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

enum _LivenessStep { lookStraight, turnLeft, turnRight, blink }