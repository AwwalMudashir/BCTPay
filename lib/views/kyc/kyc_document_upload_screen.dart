import 'dart:io';

import 'package:bctpay/globals/index.dart';
import 'package:bctpay/data/models/kyc/kyc_response.dart';
import 'package:bctpay/data/repository/kyc_repo/kyc_repository.dart';
import 'package:path/path.dart' as path;

class KycDocumentUploadScreen extends StatefulWidget {
  static const String routeName = 'kyc-document-upload-screen';
  const KycDocumentUploadScreen({super.key, required this.item});
  final KYCItem item;

  @override
  State<KycDocumentUploadScreen> createState() =>
      _KycDocumentUploadScreenState();
}

class _KycDocumentUploadScreenState
    extends State<KycDocumentUploadScreen> {
  String? selectedDocumentType;
  File? uploadedDocument;
  String? documentFileName;
  String? documentFileSize;
  bool isUploading = false;
  bool isDocumentVerified = false;
  String? uploadError;

  final ImagePicker _imagePicker = ImagePicker();
  final int maxFileSizeInBytes = 5 * 1024 * 1024; // 5MB
  final List<String> allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf'];

  final List<DocumentType> documentTypes = [
    DocumentType(
      id: 'nin',
      title: 'National Identity Number (NIN)',
      subtitle: 'Government issued NIN slip or card',
      icon: Icons.credit_card_outlined,
      acceptedFormats: ['PDF', 'JPG', 'PNG'],
    ),
    DocumentType(
      id: 'drivers_license',
      title: 'Driver\'s License',
      subtitle: 'Valid Nigerian driver\'s license',
      icon: Icons.drive_eta_outlined,
      acceptedFormats: ['PDF', 'JPG', 'PNG'],
    ),
    DocumentType(
      id: 'voters_card',
      title: 'Voter\'s Card (PVC)',
      subtitle: 'Permanent Voter\'s Card',
      icon: Icons.how_to_vote_outlined,
      acceptedFormats: ['PDF', 'JPG', 'PNG'],
    ),
    DocumentType(
      id: 'international_passport',
      title: 'International Passport',
      subtitle: 'Nigerian international passport',
      icon: Icons.flight_takeoff_outlined,
      acceptedFormats: ['PDF', 'JPG', 'PNG'],
    ),
  ];

  DocumentType? get selectedDocument {
    if (selectedDocumentType == null) return null;
    return documentTypes.firstWhere((doc) => doc.id == selectedDocumentType);
  }

  bool get canProceed {
    return selectedDocumentType != null &&
        uploadedDocument != null &&
        !isUploading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: themeLogoColorBlue,
        title: Text(
          'Upload ID Document',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: themeLogoColorBlue,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identity Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Upload a clear photo or scan of your government-issued ID document for verification.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            SizedBox(height: 32),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Document Type Selection
                    Text(
                      'Select Document Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),

                    ...documentTypes.map(
                      (docType) => _buildDocumentTypeCard(docType),
                    ),

                    if (selectedDocumentType != null) ...[
                      SizedBox(height: 32),
                      Text(
                        'Upload Document',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16),
                      if (uploadedDocument == null)
                        _buildUploadSection()
                      else
                        _buildUploadedDocumentPreview(),
                    ],

                    if (uploadError != null) ...[
                      SizedBox(height: 16),
                      _buildErrorMessage(),
                    ],

                    SizedBox(height: 32),
                    _buildUploadRequirements(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            if (selectedDocumentType != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeLogoColorBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed:
                      canProceed
                          ? () {
                            _submitDocument();
                          }
                          : uploadedDocument == null
                          ? () {
                            _showUploadOptions();
                          }
                          : null,
                  child: Text(
                    uploadedDocument == null
                        ? "Select Upload Method"
                        : isUploading
                        ? "Uploading..."
                        : "Submit Document",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTypeCard(DocumentType docType) {
    final isSelected = selectedDocumentType == docType.id;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDocumentType = docType.id;
            uploadedDocument = null;
            uploadError = null;
            documentFileName = null;
            documentFileSize = null;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isSelected ? themeLogoColorBlue : Colors.grey[200]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? themeLogoColorBlue.withOpacity(0.1)
                          : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  docType.icon,
                  color:
                      isSelected
                          ? themeLogoColorBlue
                          : Colors.grey[600],
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      docType.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected
                                ? themeLogoColorBlue
                                : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      docType.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Formats: ${docType.acceptedFormats.join(", ")}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: themeLogoColorBlue,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        children: [
          Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'No document uploaded',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Choose how you\'d like to upload your ${selectedDocument?.title}',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildUploadOption(
                  icon: Icons.camera_alt_outlined,
                  title: 'Take Photo',
                  subtitle: 'Use camera',
                  onTap: _takePhoto,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildUploadOption(
                  icon: Icons.photo_library_outlined,
                  title: 'Gallery',
                  subtitle: 'From photos',
                  onTap: _pickFromGallery,
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Icon(icon, color: themeLogoColorBlue, size: 24),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            2.height,
            Text(
              subtitle,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadedDocumentPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                uploadedDocument != null && _isImageFile(uploadedDocument!)
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(uploadedDocument!, fit: BoxFit.cover),
                    )
                    : Icon(
                      Icons.description,
                      color: Colors.grey[600],
                      size: 24,
                    ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentFileName ?? 'Document',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.height,
                Text(
                  'Size: $documentFileSize',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[600],
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Ready for upload',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                uploadedDocument = null;
                documentFileName = null;
                documentFileSize = null;
                uploadError = null;
              });
            },
            icon: Icon(Icons.close, color: Colors.grey[600], size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red[600], size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              uploadError!,
              style: TextStyle(fontSize: 14, color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadRequirements() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange[600], size: 20),
              SizedBox(width: 8),
              Text(
                'Document Requirements',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...requirements.map(
            (req) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      req,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange[700],
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<String> requirements = [
    'Document must be clear and readable',
    'All corners and edges must be visible',
    'No blurry or pixelated images',
    'File size should not exceed 5MB',
    'Ensure good lighting when taking photos',
    'Document must be valid and not expired',
  ];

  // Permission handling
  Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true; // iOS doesn't need explicit storage permission for gallery
  }

  // File validation
  bool _validateFile(File file) {
    // Check file size
    final fileSizeInBytes = file.lengthSync();
    if (fileSizeInBytes > maxFileSizeInBytes) {
      setState(() {
        uploadError =
            'File size exceeds 5MB limit. Please choose a smaller file.';
      });
      return false;
    }

    // Check file extension
    final fileExtension = path
        .extension(file.path)
        .toLowerCase()
        .replaceAll('.', '');
    if (!allowedExtensions.contains(fileExtension)) {
      setState(() {
        uploadError = 'Invalid file format. Please use JPG, PNG, or PDF files.';
      });
      return false;
    }

    setState(() {
      uploadError = null;
    });
    return true;
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  bool _isImageFile(File file) {
    final extension = path.extension(file.path).toLowerCase();
    return ['.jpg', '.jpeg', '.png'].contains(extension);
  }

  // Camera functionality
  Future<void> _takePhoto() async {
    try {
      final hasPermission = await _requestCameraPermission();
      if (!hasPermission) {
        setState(() {
          uploadError = 'Camera permission is required to take photos.';
        });
        return;
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        final file = File(image.path);
        if (_validateFile(file)) {
          setState(() {
            uploadedDocument = file;
            documentFileName = path.basename(file.path);
            documentFileSize = _formatFileSize(file.lengthSync());
          });
        }
      }
    } catch (e) {
      setState(() {
        uploadError = 'Error taking photo: ${e.toString()}';
      });
    }
  }

  // Gallery functionality
  Future<void> _pickFromGallery() async {
    try {
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        setState(() {
          uploadError = 'Storage permission is required to access gallery.';
        });
        return;
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final file = File(image.path);
        if (_validateFile(file)) {
          setState(() {
            uploadedDocument = file;
            documentFileName = path.basename(file.path);
            documentFileSize = _formatFileSize(file.lengthSync());
          });
        }
      }
    } catch (e) {
      setState(() {
        uploadError = 'Error picking image: ${e.toString()}';
      });
    }
  }


  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Upload ${selectedDocument?.title}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 24),
                _buildBottomSheetOption(
                  icon: Icons.camera_alt_outlined,
                  title: 'Take Photo',
                  subtitle: 'Use your camera to capture the document',
                  onTap: () {
                    Navigator.pop(context);
                    _takePhoto();
                  },
                ),
                SizedBox(height: 16),
                _buildBottomSheetOption(
                  icon: Icons.photo_library_outlined,
                  title: 'Choose from Gallery',
                  subtitle: 'Select from your photo library',
                  onTap: () {
                    Navigator.pop(context);
                    _pickFromGallery();
                  },
                ),
                SizedBox(height: 16),
                SizedBox(height: 24),
              ],
            ),
          ),
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: themeLogoColorBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: themeLogoColorBlue, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  // Document upload to server
  Future<void> _submitDocument() async {
    if (!canProceed) return;

    setState(() {
      isUploading = true;
      uploadError = null;
    });

    try {
      // For now, just save the KYC data with the file path as placeholder
      // In a real implementation, you'd upload the file first and get a URL back
      final kycRepository = KycRepository();
      final saveResult = await kycRepository.saveKycData(
        widget.item.copyWith(
          kycValue: uploadedDocument!.path, // This should be replaced with actual file URL
          kycDataType: selectedDocumentType,
        ),
      );

      if (mounted) {
        if (saveResult.success) {
          _showSuccessDialog();
          setState(() {
            isUploading = false;
            uploadedDocument = null;
            documentFileName = null;
          });
        } else {
          setState(() {
            uploadError = saveResult.errorMessage ?? 'Save failed';
            isUploading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        uploadError = 'Error uploading document: ${e.toString()}';
        isUploading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green[600],
                    size: 48,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Document Submitted!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Your document has been submitted for verification. You\'ll be notified once the review is complete.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeLogoColorBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Complete KYC'),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class DocumentType {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> acceptedFormats;

  DocumentType({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.acceptedFormats,
  });
}