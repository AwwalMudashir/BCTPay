import 'package:bctpay/globals/index.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePickerController {
  static final ImagePicker _picker = ImagePicker();
  static var imageQuality = 25;
  static var maxHeight = 1024.0;
  static var maxWidth = 1024.0;

  static Future<XFile?> cameraCapture({bool enableImageCrop = true}) async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
    // return file;
    if (file != null) {
      return enableImageCrop ? await cropImage(file) : file;
    } else {
      return null;
    }
    // return croppedImage;
  }

  static Future<XFile?> pickImageFromGallery(
      {bool enableImageCrop = true}) async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
    // return file;
    var croppedImage = enableImageCrop ? await cropImage(file!) : file;
    return croppedImage;
  }

  static Future<List<XFile?>> pickMultipleMedia(
      {bool enableImageCrop = true}) async {
    final List<XFile> files = await _picker.pickMultipleMedia(
      imageQuality: imageQuality,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
    if (enableImageCrop) {
      List<XFile?> croppedImages = [];
      for (var file in files) {
        var mimeType = file.mimeType?.toLowerCase();
        var ext = file.name.split(".").last.toLowerCase();
        if (mimeType == "jpeg" ||
            mimeType == "jpg" ||
            mimeType == "png" ||
            ext == "jpeg" ||
            ext == "jpg" ||
            ext == "png") {
          var croppedImage = await cropImage(file);
          croppedImages.add(croppedImage);
        } else {
          croppedImages.add(file);
        }
      }
      return croppedImages;
    } else {
      return files;
    }
  }

  // Function to crop the selected image using the image_cropper package
  static Future<XFile?> cropImage(XFile pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: imageQuality,
      maxHeight: maxHeight.toInt(),
      maxWidth: maxWidth.toInt(),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    // Returning the edited/cropped image if available, otherwise the original image
    if (croppedFile != null) {
      return XFile(croppedFile.path);
    } else {
      return XFile(pickedFile.path);
    }
  }
}
