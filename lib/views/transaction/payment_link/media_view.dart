import 'package:bctpay/lib.dart';

class MediaView extends StatelessWidget {
  final EventBannerInfo media;
  const MediaView({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    if (media.imageExtension?.isVideo() ?? false) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.videoPlayer,
              arguments: VideoPlayer1(
                videoUrl: "$baseUrlBannerImage${media.imageName}",
              ));
        },
        child: VideoItem(
          isNetwork: true,
          videoFilePath: "$baseUrlBannerImage${media.imageName}",
          format: media.imageExtension,
        ),
      );
    }
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.imageView,
            arguments: ImageView(
              imageUrl: "$baseUrlBannerImage${media.imageName}",
            ));
      },
      child: CachedNetworkImage(
        imageUrl: "$baseUrlBannerImage${media.imageName}",
        errorWidget: (context, url, error) => Icon(Icons.error),
        progressIndicatorBuilder: progressIndicatorBuilder,
        fit: BoxFit.cover,
      ),
    );
  }
}
