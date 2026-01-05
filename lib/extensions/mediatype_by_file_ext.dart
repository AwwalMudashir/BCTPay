extension MediaType on String {
  bool isImage() {
    if (isEmpty) {
      return false; // Handle null input
    }

    final lowerExtension = toLowerCase();

    return lowerExtension == 'jpg' ||
        lowerExtension == 'jpeg' ||
        lowerExtension == 'png' ||
        lowerExtension == 'gif' ||
        lowerExtension == 'bmp' ||
        lowerExtension == 'webp' ||
        lowerExtension == 'heic' ||
        lowerExtension == 'heif' ||
        lowerExtension == 'tiff' ||
        lowerExtension == 'tif'; // Add more as needed
  }

  bool isVideo() {
    if (isEmpty) {
      return false; // Handle null input
    }

    final lowerExtension = toLowerCase();

    return lowerExtension == 'mp4' ||
        lowerExtension == 'avi' ||
        lowerExtension == 'mov' ||
        lowerExtension == 'mkv' ||
        lowerExtension == 'webm' ||
        lowerExtension == 'flv' ||
        lowerExtension == '3gp' ||
        lowerExtension == 'wmv' ||
        lowerExtension == 'mpg' ||
        lowerExtension == 'mpeg' ||
        lowerExtension == 'ogv'; // Add more as needed
  }

  bool isPDF() {
    if (isEmpty) {
      return false; // Handle null input
    }

    final lowerExtension = toLowerCase();

    return lowerExtension == 'pdf'; // Add more as needed
  }
}
