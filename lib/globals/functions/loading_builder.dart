import 'package:bctpay/globals/index.dart';

Widget loadingBuilder(
    BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return Center(
    child: CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
          : null,
    ),
  );
}

Widget progressIndicatorBuilder(
    BuildContext context, String string, DownloadProgress? loadingProgress) {
  if (loadingProgress == null) {
    return const Loader();
  }
  return Center(
    child: CircularProgressIndicator(
      value: loadingProgress.progress,
    ),
  );
}
