import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:videowall/adapters/dailymotionvideoadapter.dart';
import 'package:videowall/adapters/motherlessadapter.dart';
import 'package:videowall/adapters/redtubeadapter.dart';
import 'package:videowall/adapters/scorebat.dart';
import 'package:videowall/adapters/testvideoadapter.dart';
import 'package:videowall/adapters/videowalladapterbase.dart';
import 'package:videowall/adapters/xvideosadapter.dart';
import 'package:videowall/widgets/embeddedvideo.dart';
import 'package:videowall/widgets/mp4video.dart';

class VideoGrid extends StatefulWidget {
  final String numberOfVideos;
  final VideowallAdapterBase videowallAdapter;

  VideoGrid(this.numberOfVideos, this.videowallAdapter);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  @override
  Widget build(BuildContext context) {
    double _gridSize = sqrt(int.parse(widget.numberOfVideos));

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double _columnSize = queryData.size.width < 1000 ? 1 : _gridSize;
    double _rowSize = _gridSize;

    return Scaffold(
      body: new Container(
        padding: EdgeInsets.all(20),
        child: LayoutGrid(
          columnGap: 20,
          rowGap: 20,
          templateColumnSizes: [
            for (var i = 0; i < _columnSize; i++) FlexibleTrackSize(1),
          ],
          templateRowSizes: [
            for (var i = 0; i < _rowSize; i++) FlexibleTrackSize(1),
          ],
          children: [
            for (var i = 0;
                i <
                    countPlaces(_rowSize, _columnSize,
                        double.parse(widget.numberOfVideos));
                i++)
              addVideowallItem()
          ],
        ),
      ),
    );
  }

  double countPlaces(double rowsize, double columnsize, double numberofvideo) {
    var availablePlaces = columnsize + rowsize;
    return numberofvideo > availablePlaces
        ? numberofvideo - rowsize
        : numberofvideo;
  }

  Widget addVideowallItem() {
    switch (widget.videowallAdapter.runtimeType) {
      case TestVideoAdapter:
        return MP4Video(adapter: widget.videowallAdapter);
      case DailymotionVideoAdapter:
        return EmbeddedVideo(adapter: widget.videowallAdapter);
      case ScorebatVideoAdapter:
        return EmbeddedVideo(adapter: widget.videowallAdapter);
      case XVideosAdapter:
        return MP4Video(adapter: widget.videowallAdapter);
      case RedtubeAdapter:
        return MP4Video(adapter: widget.videowallAdapter);
      case MotherlessAdapter:
        return MP4Video(adapter: widget.videowallAdapter);
    }
    // Unkown adapter
    throw new Exception('Unknown adapter is requested.');
  }
}
