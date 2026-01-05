import 'package:bctpay/globals/index.dart';

extension IsImage on XFile {
  bool isImage() {
    final fileName = name;
    final fileExtension = fileName.split(".").last.toLowerCase();
    final lowerMimeType = mimeType?.toLowerCase();

    return lowerMimeType == "png" ||
        fileExtension == "png" ||
        lowerMimeType == "jpeg" ||
        fileExtension == "jpeg" ||
        lowerMimeType == "jpg" ||
        fileExtension == "jpg";
  }

  bool isNetworkFile() {
    final fileName = name;
    final fileExtension = fileName.split(".").last.toLowerCase();
    final lowerMimeType = mimeType?.toLowerCase();

    return lowerMimeType == "http" || fileExtension == "http";
  }
}
