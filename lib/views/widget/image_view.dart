import 'dart:io';

import 'package:bctpay/globals/index.dart';

class ImageView extends StatelessWidget {
  final String? imageUrl;
  final bool? isLocal;
  const ImageView({super.key, this.imageUrl, this.isLocal = false});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as ImageView;
    return Scaffold(
      appBar: const CustomAppBar(title: ""),
      body: InteractiveViewer(
        child: Center(
          child: (args.isLocal ?? false)
              ? Image.file(File(args.imageUrl ?? ""))
              : CachedNetworkImage(
                  imageUrl: args.imageUrl ?? "",
                  // height: 150,
                  progressIndicatorBuilder: progressIndicatorBuilder,
                  errorWidget: (BuildContext context, String s, Object o) =>
                      const Icon(Icons.photo),
                ),
        ),
      ),
    );
  }
}
