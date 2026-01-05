import 'dart:io';

import 'package:bctpay/lib.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailWidget extends StatefulWidget {
  final String videoUrl;

  const VideoThumbnailWidget({super.key, required this.videoUrl});

  @override
  VideoThumbnailWidgetState createState() => VideoThumbnailWidgetState();
}

class VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  String? _thumbnailUrl;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    try {
      _thumbnailUrl = await VideoThumbnail.thumbnailFile(
        video: widget.videoUrl,
        thumbnailPath: null, // generates a temp file
        imageFormat: ImageFormat.JPEG,
        maxHeight: 200, // Adjust as needed
        quality: 75, // Adjust as needed
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (_error.isNotEmpty) {
      return Center(child: Text('Error loading thumbnail: $_error'));
    } else if (_thumbnailUrl != null) {
      return Image.file(
        //Use Image.network(_thumbnailUrl!) for web support.
        //But for mobile, use Image.file.
        //If you want to use network, you must change the thumbnailPath to a web accessible url.
        //For local files, VideoThumbnail.thumbnailFile will create a temporary file.
        //For network urls, the thumbnail will be saved in the temporary file.
        //Therefore, for network, the best approach is to store the thumbnail to a web accessible url.
        //Then, use Image.network.
        //For simplicity, this example uses Image.file.
        File(_thumbnailUrl!),
        fit: BoxFit.cover,
      );
    } else {
      return Center(child: Text('Thumbnail not available'));
    }
  }
}
