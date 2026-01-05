import 'package:bctpay/lib.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer1 extends StatelessWidget {
  final String? videoUrl;
  const VideoPlayer1({super.key, this.videoUrl});

  @override
  Widget build(BuildContext context) {
    var arg =
        args(context) is VideoPlayer1 ? args(context) as VideoPlayer1 : null;
    var url = videoUrl ?? arg?.videoUrl ?? "";
    var controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize();
    return VideoPlayer(controller);
  }
}
