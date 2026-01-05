import 'dart:io';

import 'package:bctpay/lib.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  const VideoItem(
      {super.key,
      required this.videoFilePath,
      required this.isNetwork,
      this.format});

  final String videoFilePath;
  final String? format;
  final bool isNetwork;

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController? _controller;

  Future<void> playerConfig() async {
    _controller = widget.isNetwork
        ? VideoPlayerController.networkUrl(
            formatHint: VideoFormat.other,
            httpHeaders: await ApiClient.header(),
            Uri.parse(widget.videoFilePath +
                (widget.format?.isNotEmpty ?? false
                    ? ".${widget.format}"
                    : "")))
        : VideoPlayerController.file(File(widget.videoFilePath))
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void initState() {
    playerConfig();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          widget.isNetwork
              ? (_controller?.value.isInitialized ?? false)
                  ? SizedBox(
                      width: 80,
                      height: 80,
                      child: VideoPlayer(_controller!),
                    )
                  : Loader()
              : SizedBox(
                  width: 80,
                  height: 80,
                  child: VideoPlayer(_controller!),
                ),
          if (!(_controller?.value.isPlaying ?? true))
            Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 80,
            ),
        ],
      ),
      onTap: () {
        setState(() {
          _controller?.value.isPlaying ?? true
              ? _controller?.pause()
              : _controller?.play();
        });
      },
    );
  }
}
