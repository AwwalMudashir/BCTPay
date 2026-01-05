import 'package:bctpay/lib.dart';

class QRCodeViewWidget extends StatelessWidget {
  final String qrCodeString;
  final String? logo;

  const QRCodeViewWidget({super.key, required this.qrCodeString, this.logo});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: QrImageView(
        backgroundColor: Colors.white,
        errorCorrectionLevel: QrErrorCorrectLevel.H,
        embeddedImage: getImage(),
        data: qrCodeString,
        version: QrVersions.auto,
        size: 300,
        gapless: false,
        errorStateBuilder: (cxt, err) {
          return Center(
            child: Text(
              appLocalizations(context).error,
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }

  ImageProvider<Object>? getImage() {
    final hasLogo = logo != null && (logo?.isNotEmpty ?? false);
    if (hasLogo) {
      return NetworkImage(logo!);
    }
    return const AssetImage(Assets.assetsImagesCircularLogo);
  }
}
