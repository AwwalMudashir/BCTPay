import 'dart:io';

import 'package:bctpay/globals/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

bool isAndroidTv = false;

class StaggeredPhotoGridview extends StatefulWidget {
  final QueryMessage? queryMessage;

  const StaggeredPhotoGridview({
    super.key,
    required this.queryMessage,
  });

  @override
  State<StaggeredPhotoGridview> createState() => _StaggeredPhotoGridviewState();
}

class _StaggeredPhotoGridviewState extends State<StaggeredPhotoGridview> {
  bool isExpanded = false;
  var timelineMediaFocusNode = FocusNode()..requestFocus();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    int length = widget.queryMessage!.queryImage?.length ?? 0;
    var focusColor = Colors.grey;
    if (length == 1) {
      return SizedBox(
          height: isAndroidTv ? height - AppBar().preferredSize.height : 230,
          child: InkWell(
            focusNode: timelineMediaFocusNode,
            focusColor: focusColor,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => TimelineMediaView(
                        queryImage: widget.queryMessage!.queryImage,
                        index: 0,
                      )));
            },
            child: tile(
                queryImageList: widget.queryMessage!.queryImage!, index: 0),
          ));
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: isExpanded ? length : 1,
        itemBuilder: (ctx, i) {
          if (i % 3 == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: StaggeredGrid.count(
                crossAxisCount: (length < 3) ? length : 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: (length < 3) ? 1 : 2,
                    mainAxisCellCount: (length < 3) ? 1 : 2,
                    child: InkWell(
                      focusNode: timelineMediaFocusNode,
                      focusColor: focusColor,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => TimelineMediaView(
                                  queryImage: widget.queryMessage!.queryImage,
                                  index: i,
                                )));
                      },
                      child: tile(
                          queryImageList: widget.queryMessage!.queryImage!,
                          index: i),
                    ),
                  ),
                  if (i + 1 < widget.queryMessage!.queryImage!.length)
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: InkWell(
                        focusColor: focusColor,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => TimelineMediaView(
                                    queryImage: widget.queryMessage!.queryImage,
                                    index: i + 1,
                                  )));
                        },
                        child: tile(
                            queryImageList: widget.queryMessage!.queryImage!,
                            index: i + 1),
                      ),
                    ),
                  if (i + 2 < widget.queryMessage!.queryImage!.length)
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: InkWell(
                        focusColor: focusColor,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => TimelineMediaView(
                                    queryImage: widget.queryMessage!.queryImage,
                                    index: i + 2,
                                  )));
                        },
                        child: tile(
                            queryImageList: widget.queryMessage!.queryImage!,
                            index: i + 2),
                      ),
                    ),
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }

  Widget tile({
    required List<QueryImage> queryImageList,
    required int index,
  }) {
    var queryImage = queryImageList[index];
    int remaining = queryImageList.length - 3;
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.8,
          child: Hero(
            tag: queryImageList[index].id!,
            child: queryImage.imageExtension?.isPDF() ?? false
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        size: 100,
                        color: Colors.red,
                      ),
                      Text(
                          "${queryImage.imageName}.${queryImage.imageExtension}"),
                    ],
                  ))
                : CachedNetworkImage(
                    imageUrl: (queryImage.imageExtension?.isVideo() ?? false)
                        ? baseUrlProfileImage + queryImage.imageName!
                        : baseUrlProfileImage + queryImage.imageName!,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        if (queryImage.imageExtension?.isVideo() ?? false)
          const Positioned.fill(
            child: Icon(
              Icons.play_circle_outline_rounded,
              size: 70,
              color: Colors.white,
            ),
          ),
        if (index == 2 && !isExpanded)
          if (remaining != 0)
            Positioned.fill(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = true;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black54,
                  child: Text(
                    '+$remaining',
                    style: const TextStyle(fontSize: 32, color: Colors.grey),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

class TimelineMediaView extends StatefulWidget {
  final int? index;
  final List<QueryImage>? queryImage;

  const TimelineMediaView({super.key, this.queryImage, this.index});

  @override
  State<TimelineMediaView> createState() => _TimelineMediaViewState();
}

class _TimelineMediaViewState extends State<TimelineMediaView> {
  Widget media = const Center(
    child: Text('No Media'),
  );

  InteractiveViewer imageView(QueryImage queryImage) => InteractiveViewer(
          child: Hero(
        tag: queryImage.id!,
        child: CachedNetworkImage(
            imageUrl: baseUrlProfileImage + queryImage.imageName!),
      ));

  FutureBuilder<File> pdfView(QueryImage queryImage) => FutureBuilder(
      future: createFileOfPdfUrl(baseUrlProfileImage + queryImage.imageName!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PDFView(
            filePath: snapshot.data?.path ?? "",
          );
        }
        return Loader();
      });

  Widget getMediaType(QueryImage queryImage) {
    final mediaType = queryImage.imageExtension;
    if (mediaType != null && mediaType.isVideo()) {
      return imageView(queryImage);
    } else if (mediaType != null && mediaType.isPDF()) {
      return pdfView(queryImage);
    } else {
      return imageView(queryImage);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: isAndroidTv
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: height,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            autoPlay: false,
            initialPage: widget.index!,
          ),
          items: widget.queryImage!.map((e) => getMediaType(e)).toList(),
        ),
      ),
    );
  }
}
