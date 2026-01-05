import 'dart:io';

import 'package:bctpay/globals/index.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class KYCFileView extends StatelessWidget {
  final XFile? file;
  final bool disableOntap;
  final String? extension;

  const KYCFileView(
      {super.key, this.file, this.disableOntap = false, this.extension});

  @override
  Widget build(BuildContext context) {
    late XFile? newFile;
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is KYCFileView) {
      newFile = args.file;
    } else {
      newFile = file;
    }
    return (newFile?.isNetworkFile() ?? false)
        ? InkWell(
            onTap: disableOntap
                ? null
                : () async {
                    if (args is! KYCFileView) {
                      if (extension == "pdf") {
                        final header = await ApiClient.header();
                        log("$baseUrlKYCImage${newFile?.path}");
                        if (!context.mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: CustomAppBar(title: ""),
                                body: SfPdfViewer.network(
                                  "$baseUrlKYCImage${newFile?.path}",
                                  headers: header,
                                ),
                              ),
                            ));
                      } else {
                        Navigator.pushNamed(context, AppRoutes.imageView,
                            arguments: ImageView(
                              imageUrl: "$baseUrlKYCImage${newFile?.path}",
                            ));
                      }
                    }
                  },
            child: extension != "pdf"
                ? Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(2),
                    child: CachedNetworkImage(
                      imageUrl: "$baseUrlKYCImage${newFile?.path}",
                      fit: BoxFit.contain,
                      progressIndicatorBuilder: progressIndicatorBuilder,
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ))
                : Container(
                    padding: const EdgeInsets.all(30),
                    child: Image.asset(
                      Assets.assetsImagesPdf,
                      fit: BoxFit.contain,
                      height: 50,
                      width: 50,
                    ),
                  ),
          )
        : (newFile?.isImage() ?? false)
            ? InkWell(
                onTap: disableOntap
                    ? null
                    : () {
                        Navigator.pushNamed(context, AppRoutes.imageView,
                            arguments: ImageView(
                              imageUrl: newFile?.path,
                              isLocal: true,
                            ));
                      },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  child: Image.file(
                    File(
                      newFile?.path ?? "",
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(2),
                color: Colors.red,
                child: Center(
                    child: Text(
                  newFile?.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                )));
  }
}
